; multi-segment executable file template.

data segment
    username_1 db '20221130$'
    password_1 db 78h,7Bh,72h,7Fh,76h,77h,5 dup('$')
    username_2 db 11 dup('$')
    password_2 db 11 dup('$')
    emptypass db 11 dup('$')
    emotionstring db 81 dup('$')
    greet db 'Welcome to emotion detector!',0Dh,0Ah,'$'
    select1 db '1)Admin',0Dh,0Ah,'$'
    select2 db '2)User',0Dh,0Ah,'$'
    select3 db '3)Guest',0Dh,0Ah,'$'
    adselect1 db '1)Enroll new user',0Dh,0Ah,'$'
    adselect2 db '2)Manage encrypted passwords',0Dh,0Ah,'$'
    adselect3 db '3)Exit',0Dh,0Ah,'$'
    entuser db 'Enter username: ',0Dh,0Ah,'$'
    entpass db 'Enter password: ',0Dh,0Ah,'$'
    invopt db 'Invalid Option, Try again',0Dh,0Ah,'$'
    invuser db 'No such user exists, Try again',0Dh,0Ah,'$'
    accessg db 'Access Granted',0Dh,0Ah,'$'
    accessd db 'Incorrect Password',0Dh,0Ah,'$'
    faillog db 'Too many failed attempts',0Dh,0Ah,'$'
    charlim db 'String limit reached.',0Dh,0Ah,'$'
    uaddpeditend db 'User add successful',0Dh,0Ah,'$'
    editpassend db 'Password edit successful',0Dh,0Ah,'$'
    editpass db '1)Edit password',0Dh,0Ah,'$'
    delpass db '2)Delete password',0Dh,0Ah,'$'
    seluser db 'Select user 1 or 2:',0Dh,0Ah,'$'
    dpassend db 'Password deleted',0Dh,0Ah,'$'
    enterstring db 'How are you feeling today?',0Dh,0Ah,'$'
    pscorestart db 'Your score: ',0Dh,0Ah,'$'
    Amazing db 'amazing$'
    Joyful db 'joyful$'
    Glad db 'glad$'
    Upset db 'upset$'
    Miserable db 'miserable$'
    Depressed db 'depressed$'
    low_6 db 'Consider taking a break and getting support',0Dh,0Ah,'$'
    low_5 db 'Try to slow down and rest',0Dh,0Ah,'$'
    low_4 db 'Take some time to recharge',0Dh,0Ah,'$'
    low_3 db 'Take it one step at a time',0Dh,0Ah,'$'
    low_2 db 'Stay patient, good things come to those who wait',0Dh,0Ah,'$'
    low_1 db 'Stay focused and keep moving forward!',0Dh,0Ah,'$'
    neutral db 'You seem balanced today',0Dh,0Ah,'$'
    high_1 db "You're are on the right track!",0Dh,0Ah,'$'
    high_2 db 'Keep up the pace!',0Dh,0Ah,'$'
    high_3 db 'Pause and enjoy the moment',0Dh,0Ah,'$'
    high_4 db 'Things are going very well, GREAT!',0Dh,0Ah,'$'
    high_5 db "That's amazing, keep it up!",0Dh,0Ah,'$'
    high_6 db "Amazing to hear, you're doing fantastic!",0Dh,0Ah,'$'
    prev_score db '$'
    try_again db 'Press 1 to check your mood again?',0Dh,0Ah,'$'
    improve db 'Your mood is improving$',0Dh,0Ah,'$'
    decline db 'Your mood is declining$',0Dh,0Ah,'$'
    same db 'Your mood has stayed the same$',0Dh,0Ah,'$'
    guestscore db 'Your score = $'
    
    
ends

stack segment
    dw   128  dup(0)
ends

code segment
    
readstr PROC
    mov ah,01h
readloop:    
    INT 21h
    cmp al,0Dh
    JE endread
    stosb
    LOOP readloop
    lea dx,charlim
    mov ah,09h
    INT 21h
endread:
    mov al,'$'
    stosb
    RET
readstr ENDP

readstrCI PROC
    mov ah,01h
CIreadloop:    
    INT 21h
    cmp al,0Dh
    JE endread
    cmp al,'A'
    JB store
    cmp al,'Z'
    JA store
    add al,20h
store:
    stosb
    LOOP CIreadloop
    lea dx,charlim
    mov ah,09h
    INT 21h
endreadCI:
    mov al,'$'
    stosb
    RET
readstrCI ENDP

readencrypt PROC
    mov ah,01h
readenc:
    INT 21h
    cmp al,0Dh
    JE endreadenc
    xor al,13h
    stosb
    LOOP readenc
    lea dx,charlim
    mov ah,09h
    INT 21h
endreadenc:
    mov al,'$'
    stosb
    RET
readencrypt ENDP

useradd PROC
    mov ah,02h
    mov dl,0Dh
    INT 21h
    mov dl,0Ah
    INT 21h
    lea dx,entuser
    mov ah,09h
    INT 21h
    mov cx,10
    lea di,username_2
    cld
    CALL readstr
    mov ah,02h
    mov dl,0Dh
    INT 21h
    mov dl,0Ah
    INT 21h
    lea dx,entpass
    mov ah,09h
    INT 21h
    mov cx,10
    lea di,password_2
readpass:
    CALL readencrypt
uaddend:
    mov ah,02h
    mov dl,0Dh
    INT 21h
    mov dl,0Ah
    INT 21h
    lea dx,uaddpeditend
    mov ah,09h
    INT 21h
    RET
useradd ENDP

epass PROC
edpasscmp:
    cmp al,'1'
    JE editp1
    cmp al,'2'
    JE  editp2
    lea dx,invuser
    mov ah,09h
    INT 21h
    RET
editp1:
    lea di,password_1
    mov dl,0Dh
    mov ah,02h
    INT 21h
    mov dl,0Ah
    INT 21h
    lea dx,entpass
    mov ah,09h
    INT 21h
    mov cx,10
    CALL readencrypt
    lea dx,editpassend
    mov ah,09h
    INT 21h
    RET
editp2:
    lea di,password_2
    mov dl,0Dh
    mov ah,02h
    INT 21h
    mov dl,0Ah
    INT 21h
    lea dx,entpass
    mov ah,09h
    INT 21h
    mov cx,10
    CALL readencrypt
    lea dx,editpassend
    mov ah,09h
    INT 21h
    RET
epass ENDP

dpass PROC
dpasscmp:
    cmp al,'1'
    JE dpass1
    cmp al,'2'
    JE dpass2
    lea dx,invuser
    mov ah,09h
    INT 21h
    RET
dpass1:
    lea si,emptypass
    lea di,password_1
    cld
    mov cx,11
    JMP clrp
dpass2:
    lea si,emptypass
    lea di,password_2
    cld
    mov cx,11
clrp:
    movsb
    LOOP clrp
    lea dx,dpassend
    mov ah,09h
    INT 21h
    RET
dpass ENDP

authuser PROC
compare5:
    mov ah,01h
    INT 21h
    xor bl,bl
    xor bh,bh
    cmp al,'1'
    JE u1login
    cmp al,'2'
    JE u2login
    lea dx,invuser
    mov ah,09h
    INT 21h
    JMP compare5
u1login:
    mov dl,0Dh
    mov ah,02h
    INT 21h
    mov dl,0Ah
    INT 21h
    lea di,password_1
    mov si,di
    mov ah,09h
    lea dx,entpass
    INT 21h
    mov cx,10
    cld
    JMP passchck
u2login:
    mov dl,0Dh
    mov ah,02h
    INT 21h
    mov dl,0Ah
    INT 21h
    lea di,password_2
    mov si,di
    mov ah,09h
    lea dx,entpass
    INT 21h
    mov cx,10
    cld
passchck:
    mov ah,08h
    INT 21h
    cmp al,0Dh
    JE endpchck
    push ax
    mov ah,02h
    mov dl,'*'
    INT 21h
    pop ax
    xor al,13h
    scasb
    JE match
    inc bl
match:
    LOOP passchck
    mov ah,08h
    INT 21h
    cmp al,0Dh
    JNE wrongp
endpchck:
    mov al,[di]
    cmp al,'$'
    JNE wrongp
    mov ah,02h
    mov dl,0Dh
    INT 21h
    mov dl,0Ah
    INT 21h
    cmp bl,0
    JE corrpass
wrongp:
    inc bh
    xor bl,bl
    mov ah,02h
    mov dl,0Dh
    INT 21h
    mov dl,0Ah
    INT 21h
    lea dx,accessd
    mov ah,09h
    INT 21h
    mov di,si
    mov cx,10
    cmp bh,3
    JNE passchck
    lea dx,faillog
    INT 21h
    JMP EXIT
corrpass:
    lea dx,accessg
    mov ah,09h
    INT 21h
    RET
authuser ENDP
    
    
nextword PROC
skipword:
    mov al,[di]
    cmp al,'$'
    JE nxtwdone
    cmp al,' '
    JE skipspaces
    inc di
    jmp skipword
skipspaces:
    mov al,[di]
    cmp al,'$'
    JE nxtwdone
    cmp al,' '
    JNE nxtwdone
    inc di
    JMP skipspaces
nxtwdone:
    RET
nextword ENDP

comparewrd PROC
    cld
    PUSH di
    PUSH si
cmpwrd:
    cmpsb
    JNE pnomatch
    mov al,[di]
    cmp al,'$'
    JE stringend
    LOOP cmpwrd

stringend:
    mov al,[si]
    cmp al,'$'
    JNE pnomatch
    mov al,[di]
    cmp al,' '
    JE pmatch
    cmp al,'$'
    JE pmatch
pnomatch:
    clc
    mov al,[di]
    POP si
    POP di
    RET
pmatch:
    stc
    mov al,[di]
    POP si
    POP di
    RET
comparewrd ENDP

emotiondetector PROC
emotdetection:
    mov ah,02h
    mov dl,0Dh
    INT 21h
    mov dl,0Ah
    INT 21h
    mov ah,09h
    lea dx,enterstring
    INT 21h
    mov cx,80
    lea di,emotionstring
    xor bl,bl
    CALL readstrCI
    lea di,emotionstring
    mov al,[di]
    cmp al,' '
    JE spaskip
    lea si,Amazing
    mov cx,7
    cld
    JMP amcheck
spaskip:    
    call nextword
amsi:
    lea si,Amazing
    mov cx,7
amcheck:
    mov al,[di]
    cmp al,'$'
    JE endemotdetector
    CALL comparewrd
    JNC joysi
    call nextword
    add bl,3
    JMP amsi
joysi:
    lea si,Joyful
    mov cx,6
joycheck:
    mov al,[di]
    cmp al,'$'
    JE endemotdetector
    CALL comparewrd
    JNC gladsi
    call nextword
    add bl,2
    JMP amsi
gladsi:
    lea si,Glad
    mov cx,4
gladcheck:
    mov al,[di]
    cmp al,'$'
    JE endemotdetector
    CALL comparewrd
    JNC upsetsi
    call nextword
    inc bl
    JMP amsi            
upsetsi:
    lea si,Upset
    mov cx,5
upcheck:
    mov al,[di]
    cmp al,'$'
    JE endemotdetector
    CALL comparewrd
    JNC misersi
    call nextword
    dec bl
    JMP amsi
misersi:
    lea si,Miserable
    mov cx,9
mischeck:
    mov al,[di]
    cmp al,'$'
    JE endemotdetector
    CALL comparewrd
    JNC deprsi
    call nextword
    sub bl,2
    JMP amsi
deprsi:
    lea si,Depressed
    mov cx,9
deprcheck:
    mov al,[di]
    cmp al,'$'
    JE endemotdetector
    CALL comparewrd
    JNC depr_nomatch
    call nextword
    sub bl,3
    JMP amsi
depr_nomatch:
    call nextword
    JMP amsi
endemotdetector:
    RET
emotiondetector ENDP

printscore PROC
    mov ah,02h
    mov dl,0Ah
    INT 21h
    mov dl,0Dh
    INT 21h
    mov ah,09h
    lea dx,pscorestart
    INT 21h
    mov ah,02h
    xor ch,ch
    mov cl,13
    mov bh,7
    sub bh,bl
    cmp bl,0
    JE noscore
    JL negloop
posloop:
    cmp cl,6
    JE posfull
    mov dl,0B0h
    INT 21h
    mov dl,20h
    INT 21h
    LOOP posloop
    JMP pscoreend
posfull:
    cmp cl,bh
    JL posloop
    mov dl,0B2h
    INT 21h
    mov dl,20h
    INT 21h
    LOOP posfull
    JMP pscoreend
negloop:
    cmp cl,bh
    JE negfull
    mov dl,0B0h
    INT 21h
    mov dl,20h
    INT 21h
    LOOP negloop
    JMP pscoreend
negfull:
    cmp cl,7
    JE negloop
    mov dl,0B2h
    INT 21h
    mov dl,20h
    INT 21h
    LOOP negfull
    JMP pscoreend
noscore:
    cmp cl,7
    JE printmid
    mov dl,0B0h
    INT 21h
    mov dl,20h
    INT 21h
    LOOP noscore
    JMP pscoreend
printmid:
    mov dl,0B2h
    INT 21h
    mov dl,20h
    INT 21h
    LOOP noscore
    JMP pscoreend
pscoreend:
    RET
printscore ENDP 

showadvice PROC
    mov ah,02h
    mov dl,0Ah
    INT 21h
    mov dl,0Dh
    INT 21h
    cmp bl,-6
    JLE neg6
    cmp bl,-5
    JE neg5
    cmp bl,-4
    JE neg4
    cmp bl,-3
    JE neg3
    cmp bl,-2
    JE neg2
    cmp bl,-1
    JE neg1
    cmp bl,0
    JZ neut
    cmp bl,1
    JE pos1
    cmp bl,2
    JE pos2
    cmp bl,3
    JE pos3
    cmp bl,4
    JE pos4
    cmp bl,5
    JE pos5
    lea dx,high_6
    mov ah,09h
    INT 21h
    RET
neg6:
    lea dx,low_6
    mov ah,09h
    INT 21h
    RET
neg5:
    lea dx,low_5
    mov ah,09h
    INT 21h
    RET
neg4:
    lea dx,low_4
    mov ah,09h
    INT 21h
    RET
neg3:
    lea dx,low_3
    mov ah,09h
    INT 21h
    RET
neg2:
    lea dx,low_2
    mov ah,09h
    INT 21h
    RET
neg1:
    lea dx,low_1
    mov ah,09h
    INT 21h
    RET
neut:
    lea dx,neutral
    mov ah,09h
    INT 21h
    RET
pos1:
    lea dx,high_1
    mov ah,09h
    INT 21h
    RET
pos2:
    lea dx,high_2
    mov ah,09h
    INT 21h
    RET
pos3:
    lea dx,high_3
    mov ah,09h
    INT 21h
    RET
pos4:
    lea dx,high_4
    mov ah,09h
    INT 21h
    RET
pos5:
    lea dx,high_5
    mov ah,09h
    INT 21h
    RET
showadvice ENDP

emotioncomp PROC
    mov al,prev_score
    cmp al,'$'
    JE firsttime
    cmp bl,al
    JE equal
    JL below
    mov ah,02h
    mov dl,0Ah
    INT 21h
    mov dl,0Dh
    INT 21h
    mov ah,09h
    lea dx,improve
    INT 21h
    RET
firsttime:
    RET 
equal:
    mov ah,02h
    mov dl,0Ah
    INT 21h
    mov dl,0Dh
    INT 21h
    mov ah,09h
    lea dx,same
    INT 21h
    RET
below:
    mov ah,02h
    mov dl,0Ah
    INT 21h
    mov dl,0Dh
    INT 21h
    mov ah,09h
    lea dx,decline
    INT 21h
    RET
emotioncomp ENDP

start:
    mov ax, DATA
    mov ds, ax
    mov es, ax
    
    lea dx, greet
    mov ah,09h
    INT 21h
    lea dx, select1
    INT 21h
    lea dx, select2
    INT 21h
    lea dx, select3
    INT 21h
compare1:
    mov bh,'1'
    mov ah,01h
    INT 21h
    cmp al,'1'
    JE ADMIN
    cmp al,'2'
    JE USER
    cmp al,'3'
    JE GUEST
    mov ah,02h
    mov dl,0Ah
    INT 21h
    mov dl,0Dh
    INT 21h
    lea dx,invopt
    mov ah,09h
    INT 21h
    JMP compare1
    
ADMIN:
    xor bh,bh
    mov dl,0Dh
    mov ah,02h
    INT 21h
    mov dl,0Ah
    INT 21h
    lea dx,adselect1
    mov ah,09h
    INT 21h
    lea dx,adselect2
    INT 21h
    lea dx,adselect3
    INT 21h
compare2:
    mov ah,01h
    INT 21h
    cmp al,'1'
    JE adduser
    cmp al,'2'
    JE manpass
    cmp al,'3'
    JE EXIT
    lea dx,invopt
    mov ah,09h
    INT 21h
    jmp compare2
adduser:
    CALL useradd
    JMP start
manpass:
    mov dl,0Dh
    mov ah,02h
    INT 21h
    mov dl,0Ah
    INT 21h
    lea dx,editpass
    mov ah,09h
    INT 21h
    lea dx,delpass
    INT 21h
    mov ah,01h
    INT 21h
usersel:
    mov bl,al
    mov ah,09h
    lea dx,seluser
    INT 21h
    lea dx,username_1
    INT 21h
    mov dl,0Dh
    mov ah,02h
    INT 21h
    mov dl,0Ah
    INT 21h
    lea dx,username_2
    mov ah,09h
    INT 21h
    mov ah,01h
    INT 21h
cmpmanpass:
    cmp bl,'1'
    JE editbranch
    cmp bl,'2'
    JE deletebranch
    lea dx,invopt
    mov ah,09h
    INT 21h
    JMP manpass
editbranch:
    CALL epass
    JMP start
deletebranch:
    call dpass
    JMP start
USER:
    xor bh,bh
    mov dl,0Dh
    mov ah,02h
    INT 21h
    mov dl,0Ah
    INT 21h
    mov ah,09h
    lea dx,seluser
    INT 21h
    mov ah,09h
    lea dx,username_1
    INT 21h
    mov dl,0Dh
    mov ah,02h
    INT 21h
    mov dl,0Ah
    INT 21h
    mov ah,09h
    lea dx,username_2
    INT 21h
    mov dl,0Dh
    mov ah,02h
    INT 21h
    mov dl,0Ah
    INT 21h
    CALL authuser
GUEST:
    CALL emotiondetector
    cmp bh,'1'
    JE guestexit
    CALL printscore
    CALL emotioncomp
    mov prev_score,bl
    CALL showadvice
    lea dx,try_again
    mov ah,09h
    INT 21h
    mov ah,01h
    INT 21h
    cmp al,'1'
    JE GUEST
    JMP EXIT
guestexit:
    mov dl,0Dh
    mov ah,02h
    INT 21h
    mov dl,0Ah
    INT 21h
    lea dx,guestscore
    mov ah,09h
    INT 21h
    mov dl,bl
    add dl,30h
    mov ah,02h
    INT 21h
    
EXIT:
    mov ax, 4c00h
    int 21h    
ends

end start
