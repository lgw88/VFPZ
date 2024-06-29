* Stripe: Wrapper for the Stripe.com API
* Created 12/1/14 by Todd Landrum, todd@paladinpgm.com
* Project hosted on Github: https://github.com/VFPX/StripeX
* Version 1.1 9/8/15: TGL Added functions for adding/updating customers
* Version 1.2 10/12/15: Rick Schummer - Added currency type, cleaned up some return values. 
* Version 1.7 12/8/15: Todd Landrum - Added Plan, Card, Subscription functions
* Version 1.8 1/12/16: Todd Landrum - Added ChargeCard function
* Version 1.9 1/10/17: Todd Landrum - Added CustomerList function
* Version 2.0 8/09/17: Todd Landrum - Minor fixes. See Github.
* Version 2.1 9/11/17: Todd Landrum - Minor fixes. See Github.

* This is a very basic API wrapper for working with Stripe.com. It only does a few
* of the many, many API calls that Stripe supports. 

* With thanks to:
*    Steve Bodnar - Whose Web API talk introduced me to Stripe
*    Toni Feltman - Whose Restful API talk introduced me to Curl
*    Eric Selje - Whose LibCurl with Freshbook provided good examples. 
*    Southwest Fox Conference - Where I heard all of those talks. 
*    Rick Strahl - Whose Westwind classes replaced the no longer working Curl

* Methods
*	 AddParm: Adds a parameter before making a call
*	 AddMetaData: Adds a metadata parm before making a call
*    Authenticate: Just verifies that you have a good API entered & can communicate with Stripe
*    CardCreate: Create a card for the customer
*    CardDelete: Delete a card from the customer
* 	 CardList: Create a cursor of card IDs for the customer
*    CardRetrieve: Get the card data for a customer & card ID
*    Charge: Charges a credit card
*    ChargeCard: Charge a credit card that was previously added to Stripe with CardCreate
*	 Customer: Creates a new customer or updates an existing one. 
*	 CustomerList: Create a cursor of all customer IDs
*	 CustomerRetrieve: Get the customer data for 1 customer
*    ObjectExtract: Pulls values from Stripe text objects when passed an ID
*	 PlanList: List of all subscription plans on your account
*    PlanRetrieve: Retrieve information for a plan
*    SubscriptionCreate: Create a subscription for a customer
*    SubscriptionDelete: Delete a subscription for a customer
*    SubscriptionList: List all subscriptions for a customer
*    SubscriptionRetrieve: Get info for one subscription

* A sample call:
*!*		SET PROCEDURE TO w:\vfp7com\prog\StripeX

*!*		PUBLIC o 
*!*		o = NEWOBJECT("StripeX")
*!*		o.cAPIKey = "YourApiKey"

*!*		IF !o.Authenticate()
*!*			?"Auth", "Failed", o.cErrorMessage
*!*				return
*!*		ELSE
*!*			* Good authentication
*!*		endif

*!*		IF !o.Charge(1, "4242 4242 4242 4242", "1218", "123", "Test Charge " + TTOC(DATETIME()), "Stripe Test")
*!*			?"Charge Error", o.iResult, o.cErrorMessage
*!*		ELSE
*!*			* Good charge, pull results from o.cData which is what stripe returns. 
*!*		endif


* Makes use of:
*    Stripe API: https://stripe.com/docs/api/curl#intro 
* 	 
* Project Includes
*    StripX.prg - This program

* Dependencies for distribution:
*    wwUtils, wwHTTP -- all from https://store.west-wind.com/product/wwclient60


DEFINE CLASS StripeX AS Custom

cAlias = ""					&& Just holds the current alias when chaning tables
cAPIKey = ""				&& This needs to be set by user. 
cCurrencyISOCode = "usd"	&& Currency code, default to US $, can override
cData = ""					&& Data returned by Stripe from the call
cErrorMessage = ""			&& Any returned error message
cParms = ""					&& The parms that were passed to Stripe

cURL = "https://api.stripe.com/v1/"	&& The URL to Stripe API

iResult = 0			&& Supposed to return 1 on a fail, 0 on success. 

oHTTP = ""

************************** 
PROCEDURE Init()
	
	DO wwUtils
	DO wwHTTP
	
	this.oHTTP = CREATEOBJECT("wwHTTP")
	this.oHttp.cContentType = "application/x-www-form-urlencoded"
	
ENDPROC
************************** 
FUNCTION Destroy()

	this.oHTTP = Null

ENDFUNC
************************** 
FUNCTION AddParm()
* Adds one parameter to the call. 
* Mostly an internal method, not something called in your program. 
PARAMETERS tName, tValue

	this.oHTTP.AddPostKey(tName, tValue)
	
endfunc
************************** 
FUNCTION AddMetaData()
* Add a piece of meta data
*	Name : Name you want to give the metadata
*	Value : Value for the meta data, has to be character

PARAMETERS tName, tValue

	* 1/12/16 TGL: Remove any special characters that cause trouble
	tValue = STRTRAN(tValue, "&", "and")
	
	* Add it in
	this.AddParm("metadata[" + tName + "]", tValue)
		
return
************************** 
PROCEDURE Authenticate()
* 12/1/14: A call to see if your Stripe account is valid. 

	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.cData = this.ohttp.httpget("https://api.stripe.com/v1/charges")

	DO CASE 
	
		CASE ["message"] $ this.cData
			this.cErrorMessage = STREXTRACT(this.cData, ["message"], "}")
			this.iResult = 1
			RETURN .f.

		CASE "Bad Request" $ this.cData
			this.cErrorMessage = this.cData
			this.iResult = 1
			RETURN .f.
					
		CASE EMPTY(this.cData)
			* This can happen if CURL not installed or properly registered. 
			this.cErrorMessage = "No data returned."
			this.iResult = 1
			RETURN .f.
			
		otherwise
			RETURN .t.
			
	endcase
	
ENDPROC
************************** 
FUNCTION CardCreate()
* 11/5/15: Add a card to a customer.
* Parameters:
*	tCustomerID - Customer ID to create this to
*	tNumber - Card number, no spaces or dashes
*	tExpire - Expire date MMYY
* 	tCVC - CVC Code
* Returns: ID number if added, otherwise "0"

PARAMETERS tCustomerID, tNumber, tExpire, tCVC

	* Make the call
	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)

	this.AddParm("source[object]", "card")
	this.AddParm("source[exp_month]", STRTRAN(LEFT(tExpire, 2), " ", "0"))
	this.AddParm("source[exp_year]", RIGHT(tExpire, 2))
	this.AddParm("source[number]", ALLTRIM(tNumber))
	this.AddParm("source[cvc]", ALLTRIM(tCVC))
	
	this.oHTTP.cHTTPVerb = "POST"	
	this.cData = this.ohttp.httpget(this.cURL + "customers/" + tCustomerID + "/sources")

	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN "0"
	ELSE
		RETURN STREXTRACT(this.cData, ["id": "], [",])	
	endif

ENDFUNC 
************************** 
FUNCTION CardDelete()
* 11/5/15: Delete a card from a customer
* Parameters:
*	tCustomerID - Customer ID to create this to
*	tCardID - Card ID
* Returns: T/F if the card was deleted.

PARAMETERS tCustomerID, tCardID
	
	* Make the call
	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.oHTTP.chttpverb = "DELETE"
	this.cData = this.ohttp.httpget(this.cURL + "customers/" + ALLTRIM(tCustomerID) + "/sources/" + ALLTRIM(tCardID))

	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN .f.
	ELSE
		RETURN this.ObjectExtract("deleted", this.cData)
	endif

ENDFUNC 
************************** 
FUNCTION CardList()
* 11/5/15: Get a list of all cards on the customer
* Parameters:
*	tCustomerID - Customer ID to create this for
* Returns: Number of cards found
* CurStripeCard cursor has all of the IDs. 

PARAMETERS tCustomerID

	this.cAlias = ALIAS()
	
	* Make the call
	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.cData = this.ohttp.httpget(this.cURL + "customers/" + tCustomerID + "/sources?object=card&limit=100")

	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN 0
	ELSE
		LOCAL lCardID, lCount
		lCardID = 0
		lCount = 0
		
		this.CloseCursor("CurStripeCard")
		
		CREATE TABLE CurStripeCard Free;
			(ID C(30))
		this.ResetAlias()
		
		DO WHILE .t.
			lCount = lCount + 1		
			lCardID = STREXTRACT(this.cData, ["id": "], [",], lCount)
			IF EMPTY(lCardID)
				EXIT
			else
				INSERT INTO CurStripeCard VALUES (lCardID)
			ENDIF
		enddo
		RETURN lCount - 1 
	endif

ENDFUNC 
************************** 
FUNCTION CardRetrieve
* 11/16/15: Retrieves a card object for the passed ID
* Parameters:
*   tCustomerID - The id for the customer
*	tCardID - The ID for the card
*   tCursor - Optional. Name of a cursor to put the object in. If blank, no cursor is created,
*				but the card object can be found in cData
* Returns: T/F if the card was found. cData has the card object. 
* Card Object: https://stripe.com/docs/api/curl#card_object

PARAMETERS tCustomerID, tCardID, tCursor

	* Make the call
	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.cData = this.ohttp.httpget(this.cURL + "customers/" + ALLTRIM(tCustomerID) + "/sources/" + ALLTRIM(tCardID))

	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN .f.
	ELSE
		RETURN .t.
	ENDIF

ENDFUNC
************************** 
FUNCTION Charge()
* 12/1/14: Charge a credit card passing the credit card info
* Parameters:
*	Amount: In dollars and cents
* 	Card number
*	Expire date in MMYY
*	CVC
*   Description that goes in Stripe
*	Description for customer statement - 22 character max

PARAMETERS tAmount, tCard, tExpire, tCVC, tDesc, tStatementDesc
IF VARTYPE(tAmount) = "Y"	&& 1/12/16 TGL
	tAmount = MTON(tAmount)
ENDIF

	* Pass all the parameters to Stripe
	this.AddParm("amount", TRANSFORM(tAmount * 100))	&& Stripe wants it in pennies
	this.AddParm("currency", this.cCurrencyISOCode)
	this.AddParm("card[number]", tCard)
	this.AddParm("card[exp_month]", LEFT(tExpire, 2))
	this.AddParm("card[exp_year]", RIGHT(tExpire, 2))
	this.AddParm("card[cvc]", tCVC)
	this.AddParm("description", EVL(tDesc, ""))
	this.AddParm("statement_descriptor", EVL(tStatementDesc, ""))

	* Make the call
	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.cData = this.ohttp.httpget(this.cURL + "charges")

	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN .f.
	ELSE
		RETURN .t.
	endif

ENDFUNC 
************************** 
FUNCTION ChargeCard()
* 1/12/16: Charge a credit card on file
* Parameters:
*	Stripe customer ID
*	Stripe credit card ID
*	Amount: In dollars and cents
*	Description that goes in stripe 
*   Description on user statement - 22 character max

PARAMETERS tCustomerID, tCardID, tAmount, tDesc, tStatementDesc
IF VARTYPE(tAmount) = "Y"	&& 1/12/16 TGL
	tAmount = MTON(tAmount)
ENDIF

	* Pass all the parameters to Stripe
	this.AddParm("customer", tCustomerID)
	this.AddParm("source", tCardID)
	this.AddParm("amount", TRANSFORM(tAmount * 100))	&& Stripe wants it in pennies
	this.AddParm("currency", this.cCurrencyISOCode)
	this.AddParm("description", EVL(tDesc, ""))
	this.AddParm("statement_descriptor", EVL(tStatementDesc, ""))

	* Make the call
	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.cData = this.ohttp.httpget(this.cURL + "charges")

	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN .f.
	ELSE
		RETURN .t.
	endif

ENDFUNC 
************************** 
FUNCTION Customer()
* 9/1/15: Create a customer or update a customer
* Parameters:
* 	ID: If empty, a new customer is created. Otherwise updates the existing ID
*	Description: Description you want to put on the client
*   You can use this.AddMetaData() to add any metadata you want to the customer. 
*   Returns: "0" if not found, otherwise returns the ID

PARAMETERS tID, tDescription, tEmail
IF EMPTY(tDescription)
	tDescription = ""
ENDIF

	this.oHTTP.AddHeader("Authorization", "Bearer " + this.cAPIKey)
	
	IF !EMPTY(tDescription)
		this.AddParm("description", tDescription)
	ENDIF
	IF !EMPTY(tEmail)
		this.AddParm("email", tEmail)
	endif	
	
	IF EMPTY(tID)
		this.cData = this.ohttp.httpget(this.cURL + "customers")
	else
		this.cData = this.ohttp.httpget(this.cURL + "customers/" + tID)
	endif
	
	* Process results. 		
	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN "0"
	ELSE
		RETURN STREXTRACT(this.cData, ["id": "], [",])
	endif
	
endfunc
**************************
FUNCTION CustomerList()
* 1/4/16: Get a list of all customers
* Parameters:
* Returns: Cursor CurCustomer is a cursor of all the IDs found

	* Create the CurCustomer cursor that will store the IDs
	this.cAlias = ALIAS()
	this.CloseCursor("CurCustomer")
		
	CREATE TABLE CurCustomer Free;
		(ID C(30))
	this.ResetAlias()	
	
	* Stripe only returns a limited number of customers at a time. 
	* We have to loop through with multiple calls until there are 
	* no more. 
	LOCAL lStartAfter, lHasMore, lPerform
	lStartAfter = ""	&& Grab next page of customers after this value. 
	lHasMore = .t.		&& Are there more customers to retrieve?
	lPerform = ""		&& Used to build the CURL call
	
	* Variables for extracting IDs from the returned data
	LOCAL lID, lCount, lIDCount
	lID = 0
	lCount = 0
	lIDCount = 0
	
		
	DO WHILE lHasMore
		* Make the call to get a page worth of customers.
		lPerform = "customers?limit=100"
		IF !EMPTY(lStartAfter)
			lPerform = lPerform + "&starting_after=" + ALLTRIM(lStartAfter)
		ENDIF
		
		this.oHTTP.AddHeader("Authorization", "Bearer " + this.cAPIKey)
		this.cData = this.ohttp.httpget(this.cURL + lPerform)

		IF "error" $ this.cData
			this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
			RETURN 0
		endif
		
		* Loop through this group of customers and add to the cursor. 
		lIDCount = 0	&& Reset my search for ID in the cData
		DO WHILE .t.
			lIDCount = lIDCount + 1
			lID = STREXTRACT(this.cData, ["id": "], [",], lIDCount)
			IF EMPTY(lID)
				EXIT
			ELSE
				* Stripe returns the customer ID as well as card & subscription ids
				* So have to make sure the ID we found is a customer ID
				IF lID = "cus_"
					lCount = lCount + 1		
					INSERT INTO CurCustomer VALUES (lID)
				endif
			ENDIF
		ENDDO
		
		* Set the next Start after
		lStartAfter = ALLTRIM(CurCustomer.ID)
		
		* Need the very last has_more field to know if more customer IDs
		lHasMore = ALLTRIM(STREXTRACT(RIGHT(this.cData, 52), ["has_more": ], [,]))
		lHasMore = (lHasMore = "true")
		
	enddo
	
	RETURN lCount - 1 

ENDFUNC 
************************** 
FUNCTION CustomerRetrieve
* 8/31/16: Retrieves a customer object for the passed ID
* Parameters:
*   tCustomerID - The id for the customer
* Returns: T/F if the customer was found. cData has the customer object. 
* Customer Object: https://stripe.com/docs/api#customers

PARAMETERS tID, tCursor

	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.cData = this.ohttp.httpget(this.cURL + "customers/" + ALLTRIM(tID))

	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN .f.
	ELSE
		RETURN .t.
	ENDIF

ENDFUNC
************************** 
FUNCTION ObjectExtract()
* 11/16/15: Extract the value for an object
* Parameters:
* 	tID: The value for the id you want
*	tText: The text of the object. Probably this.cData

PARAMETERS tID, tText

	LOCAL lValue, lReturn
	lValue = STREXTRACT(tText, ["] + tID + [": ], ",")	&& Get the raw data. 
	lReturn = ""
	
	DO case
	
		CASE lValue = ["]
			* Text field
			lReturn = STRTRAN(lValue, ["], "")	&& Remote quotes
		
		CASE lValue = "null"
			lReturn = .null. 
		
		CASE lValue = "true"
			lReturn = .t.
			
		CASE lValue = "false"
			lReturn = .f.
			
		OTHERWISE
			* Number is only other thing?
			lReturn = VAL(lValue)
			
	endcase		

	RETURN lReturn
	
endfunc
************************** 
FUNCTION PlanList()
* 11/17/15: Get a list of all plans
* Returns: Count of plans found. Cursor CurStripePlan is a table
* 			of all the IDs. 

	this.cAlias = ALIAS()
	
	* Make the call
	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.cData = this.ohttp.httpget(this.cURL + "plans?limit=100")

	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN 0
	ELSE
		LOCAL lID, lCount
		lID = 0
		lCount = 0
		
		this.CloseCursor("CurStripePlan")
		
		CREATE TABLE CurStripePlan Free;
			(ID C(30))
		this.ResetAlias()
		
		DO WHILE .t.
			lCount = lCount + 1		
			lID = STREXTRACT(this.cData, ["id": "], [",], lCount)
			IF EMPTY(lID)
				EXIT
			ELSE
				INSERT INTO CurStripePlan VALUES (lID)
			ENDIF
		enddo
		RETURN IIF(lCount = 0, 0, lCount - 1)
	endif

ENDFUNC 
************************** 
FUNCTION PlanRetrieve
* 11/17/15: Retrieves a plan object for the passed ID
* Parameters:
*	tID - The plan ID for the card
* Returns: T/F if found. cData has the plan object. 
* Card Object: https://stripe.com/docs/api/curl#plan_object

PARAMETERS tID

	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.cData = this.ohttp.httpget(this.cURL + "plans/" + ALLTRIM(tID))
	
	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN .f.
	ELSE
		RETURN .t.
	ENDIF

ENDFUNC
************************** 
FUNCTION SubscriptionCreate()
* 11/5/15: Add a subscription to a customer.
* Parameters:
*	tCustomerID - Customer ID to create this to
*	tPlanID - Subscripition plan to add
*   tTrialEnd - Date the trial period should end, empty if start now. 
* Returns: ID number if added, otherwise "0"

PARAMETERS tCustomerID, tPlanID, tTrialEnd

	* Trial End has to be Unix timestamp
	IF EMPTY(tTrialEnd)
		tTrialEnd = "now"	&& Special thing stripe allows. 
	ELSE		
		tTrialEnd = DTOT(tTrialEnd)-DATETIME(1970, 1, 1, 0, 0, 0) 
	ENDIF
	
	* Pass all the parameters to Stripe
	this.AddParm("plan", ALLTRIM(tPlanID))
	this.AddParm("customer", ALLTRIM(tCustomerID))
	this.AddParm("trial_end", tTrialEnd)

	* Make the call
	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.oHTTP.cHTTPVerb = "POST"	
	this.cData = this.ohttp.httpget(this.cURL + "subscriptions")

	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN "0"
	ELSE
		RETURN STREXTRACT(this.cData, ["id": "], [",])	
	endif

ENDFUNC 
************************** 
FUNCTION SubscriptionDelete()
* 11/17/15: Delete a subscription from a customer
* Parameters:
*	tID - Subscription ID
* Returns: T/F if the subscription was deleted.

PARAMETERS tID

	* Make the call
	this.oHTTP.chttpverb = "DELETE"	
	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.cData = this.ohttp.httpget(this.cURL + "subscriptions/" + ALLTRIM(tID))

	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN "0"
	ELSE
		RETURN this.cData 
	endif

ENDFUNC 
************************** 
FUNCTION SubscriptionList()
* 11/17/15: Get a list of all subsciptions on the customer
* Parameters:
*	tCustomerID - Customer ID 
* Returns: Count of IDs found. Cursor CurStripeSubscription is a table
* 			of all the IDs. 

PARAMETERS tCustomerID

	this.cAlias = ALIAS()
	
	* Make the call
	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.cData = this.ohttp.httpget(this.cURL + "subscriptions?customer=" + tcCustomerID + "&limit=10")

	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN 0
	ELSE
		LOCAL lID, lCount, lPlanID
		lID = 0
		lCount = 0
		lPlanID = 0
		
		this.CloseCursor("CurStripeSubscription")
		
		CREATE TABLE CurStripeSubscription Free;
			(ID C(30),;
			 PlanID C(30))
		this.ResetAlias()		
		
		DO WHILE .t.
			lCount = lCount + 1		
			lID = STREXTRACT(this.cData, ["id": "], [",], lCount)
			IF EMPTY(lID)
				EXIT
			ELSE
				lCount = lCount + 1
				lPlanID = STREXTRACT(this.cData, ["id": "], [",], lCount)
				INSERT INTO CurStripeSubscription VALUES (lID, lPlanID)
			ENDIF
		enddo
		RETURN IIF(lCount = 0, 0, lCount - 1)
	endif

ENDFUNC 
************************** 
FUNCTION SubscriptionRetrieve
* 11/16/15: Retrieves a subscription from the ID
* Parameters:
*   tCustomerID - The id for the customer
*	tID - The ID for the subscription
* Returns: T/F if the card was found. cData has the card object. 
* Card Object: https://stripe.com/docs/api/curl#card_object

PARAMETERS tCustomerID, tID

	* Make the call
	this.oHTTP.AddHeader("Authorization","Bearer " + this.cAPIKey)
	this.cData = this.ohttp.httpget(this.cURL + "subscriptions/" + ALLTRIM(tID))

	IF "error" $ this.cData
		this.cErrorMessage = STREXTRACT(this.cData, ["message": "], ["])
		RETURN .f.
	ELSE
		RETURN .t.
	ENDIF

ENDFUNC
************************** 
FUNCTION ResetAlias

	IF !EMPTY(this.cAlias) AND USED(this.cAlias)
		SELECT (this.cAlias)
	endif

ENDFUNC 
************************* 
PROCEDURE CloseCursor
LPARAMETERS tcCursor
LOCAL loError

   TRY 
      IF USED(tcCursor)
         USE IN (tcCursor)
      ENDIF 
   CATCH TO loerror 
   ENDTRY 
   
ENDPROC
************************* 
   
ENDDEFINE 