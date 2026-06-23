#!/usr/bin/python
import os
a = "-------------------------------------------------------------------------------------"
banner ="""

-------------------------------------------------------------------------------------

  DDDD DDDDD DDDDD DDDDD DDDD D   D
  D    D     D   D D   D D    D   D
  DDDD DDD   DDDDD DDDDD D    DDDDD
     D D     D   D D  M  D    D   D
  DDDD DDDDD D   D D   M DDDD D   D V.10.4.26

-------------------------------------------------------------------------------------
"""
help = """
-------------------------------------------------------------------------------------
usage :

  seach <arg>                       <arg> = search parameter
  search help                        show help message

------------------------------------------------------------------------------------
"""
def search(folder,file):
  os.system("ls "+folder+" |grep "+file)
def work(get):
  print(a + "\n")    #bin
  print("-----------------------------------|folder : /bin|-----------------------------------\n")
  search("/bin",get)
  print("-----------------------------------|folder : /sbin|----------------------------------\n") #sbin
  search("/sbin",get)
  print("----------------------------------|folder :/usr/bin|---------------------------------\n")  #usrbin
  search("/usr/bin",get)
  print(a)
def start(get):
  print(banner)
  if get == "help":
    print(help)
  else :
    work(get)
  return 0
def main(arg):
  import string
  try :
    arg = str(arg[1])
    start(arg)
  except :
    print(banner)
    print(help)
    quit()
if __name__ == '__main__':
  import sys
  sys.exit(main(sys.argv))

