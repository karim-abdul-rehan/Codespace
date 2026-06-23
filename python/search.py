#!/bin/python
import os
a = "-------------------------------------------------------------------------------------"
banner ="""

-------------------------------------------------------------------------------------

  DDDD DDDDD DDDDD DDDDD DDDD D   D
  D    D     D   D D   D D    D   D
  DDDD DDD   DDDDD DDDDD D    DDDDD
     D D     D   D D  M  D    D   D
  DDDD DDDDD D   D D   M DDDD D   D V.8.4.26 

-------------------------------------------------------------------------------------
"""
help = """
-------------------------------------------------------------------------------------

  exit|quit|q               quit from code
  help                      show help message

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
  raw_input("[enter]")
  main()
def main():
  os.system("clear")
  print(banner)
  get = raw_input("---|search|--->>")
# to exit code
  if get == "exit" :
    quit()
  elif get == "quit":
    quit()
  elif get == "q":
    quit()
  elif get == "help":
    print(help)
    raw_input("[enter]")
    main()
  else :
    work(get)
main()

