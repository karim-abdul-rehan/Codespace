import sympy
banner="""
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
   OOOOOO  OOOOOO O      OOOOOO O    O O      OOOOOO OOOOOO OOOOOO OOOOO
   O       O    0 O      O      O    O O      O    O   O    O    O O   O
   O       OOOOOO O      O      O    O O      OOOOOO   O    O    O OOOOO
   O       O    O O      O      O    O O      O    O   O    O    O O  O
   OOOOOO  O    O OOOOOO OOOOOO OOOOOO OOOOOO O    O   O    OOOOOO O   O V.10.4.26
--------------------------------------------------------------------------------------
              github: k.a.rehan-zx"
--------------------------------------------------------------------------------------
"""
usage="""
      [o] strict bodmas
          (10 + 2) * 3**2 / 4
          result : 27.0

      [o] fractional accuracy
          1/3 + 1/6
          result: 1/2

      [o] algebra
           (x + 1)**2 + (x - 1)**2
           result: 2*x**2 + 2

      [o] trigonometry
           sin(pi/2)
           resullt : 1
"""
while True :
	print(banner)
	print(usage)
	try :
		result=sympy.simplify(input("[ EQUATION ]->> "))
		print("[RESULT]: ",result)
	except :
		print(usage)
		exit()
