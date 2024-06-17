*-- Demo 6 - Vector graphics
loForm = CreateObject('DynamicForm')
loForm.Caption = 'Dynamic Forms'

loForm.cHeading ='Vector graphics demo.'
loForm.cHeaderMarkup = ''
loForm.cFooterMarkup = ''
	
lcBodyMarkup = ''
pi2 = Pi() * 2

r = 250
x_center = 300
y_center = 300
lnPoints = 720

last_x = r * Cos(0) + x_center
last_y = r * Sin(0) + y_center

For n = 1 to lnPoints

	x = r * Cos(n/360 * pi2) + x_center
	y = r * Sin(n/360 * pi2) + y_center

	lnWidth = Abs(Abs(x) - Abs(last_x)) + 1
	lnHeight = Abs(Abs(y) - Abs(last_y)) + 1

	lcBodyMarkup = lcBodyMarkup + ":class => 'line' " + ;
								":top => " + Transform(y) + ;
								":left => " + Transform(x) + ;
								":height => " + Transform(lnHeight) + ;
								":width => " + Transform(lnWidth) + ;
								":lineslant => '" + Iif((x > x_center and y > y_center) or (x < x_center and y < y_center), '/', '') + "'|"
	last_x = x
	last_y = y

EndFor

loForm.cBodyMarkup = lcBodyMarkup

loform.Show(1, _screen)


