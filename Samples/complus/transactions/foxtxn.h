#DEFINE ERRLOGFILE	"c:\mts1.txt"
#DEFINE DBCFILE		"c:\vfp\COM+\Transactions\testdata"

#DEFINE CRLF 			CHR(13)+CHR(10)
#DEFINE S_OK			0

#DEFINE MTX_CLASS	"MTXAS.APPSERVER.1"
#DEFINE ORDER_CLASS	"foxviper.order"
#DEFINE PROD_CLASS	"foxviper.prod"
#DEFINE CUST_CLASS	"foxviper.cust"
#DEFINE MSMQ_CLASS	"foxviper.msmqmsg"
#DEFINE MSMQ_QUEUE	"FoxViperQueue"


#DEFINE CONTEXT_E_ABORTED	-1
#DEFINE NONE_PROCESSED		-2
#DEFINE CUST_NOT_FOUND		-3
#DEFINE LIMIT_EXCEEDED		-4
#DEFINE ITEM_EXCEEDED		-5
#DEFINE ITEM_NOT_FOUND		-6
#DEFINE MIN_AMOUNT	5000

#DEFINE TRANSFAIL1_LOC "Transaction failed. Customer does not have enough Maxordamt for this order. The minimum balance for a customer account is $5000."
#DEFINE NOORDERS_LOC "No orders to process."
#DEFINE TRANSFAIL2_LOC "Transaction failed. Check for not enough quantity in stock."
#DEFINE TRANSFAIL3_LOC "Transaction failed. Possible error accessing SQL Server data."
#DEFINE TRANSFAIL4_LOC "Transaction failed. Customer not found."
#DEFINE TRANSFAIL5_LOC "Transaction failed. Item not found."
#DEFINE TRANSGOOD_LOC "Transaction succeeded."

#DEFINE NOQTY_LOC	"Please fill in a quantity."
#DEFINE C_ORDERS_LOC  "You have an outstanding order that have not been processed for this customer. Do you really want to abort current transaction and start a new customer order?"
#DEFINE C_ORDERS2_LOC "You have an outstanding order that have not been processed for this customer. Do you really want to abort current transaction and quit?"
#DEFINE CHECKGOOD_LOC "Orders are valid."
#DEFINE ERR_CUSTNOTFOUND_LOC "Error in Cust: Customer ID not found."
#DEFINE ERR_PRODNOTFOUND_LOC "Error in Prod: Product ID not found."