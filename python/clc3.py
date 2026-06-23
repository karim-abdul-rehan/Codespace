usage="""
      usage:
         ./calc3.py   <equation>

      example:
         ./calc3.py 4 + 5 """

def main(arg):
	try :
		os.system("echo "+arg[1]+" "+arg[2]+" "+arg[3]+" | bc -l" )
	except :
		print usage
if __name__ == '__main__':
	import os
	import sys
	sys.exit(main(sys.argv))

