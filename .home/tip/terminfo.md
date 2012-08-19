### Terminfo

- for xterm-color on solaris 

    wget http://www.catb.org/~esr/terminfo/termtypes.ti.gz -O - | gzip -dc > termtypes.ti;
    tic -o ~/ termtypes.ti

- for screen-256color

      cat > 256.ti
      screen-256color|VT 100/ANSI X3.64 virtual terminal,
        am, km, mir, msgr, xenl,
        cols#80, it#8, lines#24, colors#256, pairs#32767,
        bel=^G, blink=\E[5m, bold=\E[1m, cbt=\E[Z,
        clear=\E[H\E[J, cr=\r, csr=\E[%i%p1%d;%p2%dr,
        cub=\E[%p1%dD, cub1=\b, cud=\E[%p1%dB, cud1=\n,
        cuf=\E[%p1%dC, cuf1=\E[C, cup=\E[%i%p1%d;%p2%dH,
        cuu=\E[%p1%dA, cuu1=\EM, dch=\E[%p1%dP, dch1=\E[P,
        dl=\E[%p1%dM, dl1=\E[M, ed=\E[J, el=\E[K, el1=\E[1K,
        enacs=\E(B\E)0, home=\E[H,
        ht=\t, hts=\EH, ich=\E[%p1%d@, il=\E[%p1%dL, il1=\E[L,
        ind=\n, is2=\E)0, kcub1=\EOD, kcud1=\EOB,
        kcuf1=\EOC, kcuu1=\EOA, kdch1=\E[3~, kf1=\EOP,
        kf10=\E[21~, kf11=\E[23~, kf12=\E[24~, kf2=\EOQ,
        kf3=\EOR, kf4=\EOS, kf5=\E[15~, kf6=\E[17~,
        kf7=\E[18~, kf8=\E[19~, kf9=\E[20~, khome=\E[1~, kend=\E[4~,
        kich1=\E[2~, knp=\E[6~, kpp=\E[5~, nel=\EE,
        rc=\E8, rev=\E[7m, ri=\EM, rmcup=\E[?1049l, rmir=\E[4l,
        rmkx=\E[?1l\E>, rmso=\E[23m, rmul=\E[24m, rs2=\Ec, sc=\E7,
        sgr0=\E[m, smcup=\E[?1049h, smir=\E[4h, smkx=\E[?1h\E=,
        smso=\E[3m, smul=\E[4m, tbc=\E[3g, smacs=^N, rmacs=^O, flash=\Eg, 
        civis=\E[?25l, cnorm=\E[34h\E[?25h, cvvis=\E[34l,
        op=\E[39;49m, setab=\E[48;5;%p1%dm, setaf=\E[38;5;%p1%dm,
        acsc=``aaffggjjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~..--++\054\054hhII00,
     ^D
     tic -o ~/ 256.ti

### [ref][mail]
  
/etc/terminfo/s/screen.xterm-256color
screen.xterm-256color|VT 100/ANSI X3.64 virtual terminal, 
        am, bce, ccc, km, mir, msgr, npc, xenl, 
        colors#256, cols#80, it#8, lines#24, pairs#256, 
        
acsc=++\,\,--..00II``aaffgghhjjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~, 
        bel=^G, blink=\E[5m, bold=\E[1m, cbt=\E[Z, civis=\E[?25l, 
        clear=\E[H\E[J, cnorm=\E[34h\E[?25h, cr=^M, 
        csr=\E[%i%p1%d;%p2%dr, cub=\E[%p1%dD, cub1=^H, 
        cud=\E[%p1%dB, cud1=^J, cuf=\E[%p1%dC, cuf1=\E[C, 
        cup=\E[%i%p1%d;%p2%dH, cuu=\E[%p1%dA, cuu1=\EM, 
        cvvis=\E[34l, dch=\E[%p1%dP, dch1=\E[P, dl=\E[%p1%dM, 
        dl1=\E[M, ed=\E[J, el=\E[K, flash=\Eg, home=\E[H, ht=^I, 
        hts=\EH, ich=\E[%p1%d@, il=\E[%p1%dL, il1=\E[L, ind=^J, 
        indn=\E[%p1%dS, 
        
initc=\E]4;%p1%d;rgb\:%p2%{255}%*%{1000}%/%2.2X/%p3%{255}%*%{1000}%/%2.2X/%p4%{255}%*%{1000}%/%2.2X\E\\,
 
        invis=\E[8m, is2=\E)0, kDC=\E[3;2~, kEND=\E[1;2F, 
        kHOM=\E[1;2H, kIC=\E[2;2~, kLFT=\E[1;2D, kNXT=\E[6;2~, 
        kPRV=\E[5;2~, kRIT=\E[1;2C, kb2=\EOE, kbeg=\E[1~, kbs=^?, 
        kcbt=\E[Z, kcub1=\EOD, kcud1=\EOB, kcuf1=\EOC, kcuu1=\EOA, 
        kdch1=\E[3~, kend=\E[4~, kf0=\E[10~, kf1=\EOP, kf10=\E[21~, 
        kf11=\E[23~, kf12=\E[24~, kf13=\EO2P, kf14=\EO2Q, 
        kf15=\EO2R, kf16=\EO2S, kf17=\E[15;2~, kf18=\E[17;2~, 
        kf19=\E[18;2~, kf2=\EOQ, kf20=\E[19;2~, kf21=\E[20;2~, 
        kf22=\E[21;2~, kf23=\E[23;2~, kf24=\E[24;2~, kf25=\EO5P, 
        kf26=\EO5Q, kf27=\EO5R, kf28=\EO5S, kf29=\E[15;5~, 
        kf3=\EOR, kf30=\E[17;5~, kf31=\E[18;5~, kf32=\E[19;5~, 
        kf33=\E[20;5~, kf34=\E[21;5~, kf35=\E[23;5~, 
        kf36=\E[24;5~, kf37=\EO6P, kf38=\EO6Q, kf39=\EO6R, 
        kf4=\EOS, kf40=\EO6S, kf41=\E[15;6~, kf42=\E[17;6~, 
        kf43=\E[18;6~, kf44=\E[19;6~, kf45=\E[20;6~, 
        kf46=\E[21;6~, kf47=\E[23;6~, kf48=\E[24;6~, kf49=\EO3P, 
        kf5=\E[15~, kf50=\EO3Q, kf51=\EO3R, kf52=\EO3S, 
        kf53=\E[15;3~, kf54=\E[17;3~, kf55=\E[18;3~, 
        kf56=\E[19;3~, kf57=\E[20;3~, kf58=\E[21;3~, 
        kf59=\E[23;3~, kf6=\E[17~, kf60=\E[24;3~, kf61=\EO4P, 
        kf62=\EO4Q, kf63=\EO4R, kf7=\E[18~, kf8=\E[19~, kf9=\E[20~, 
        khome=\E[1~, kich1=\E[2~, kmous=\E[M, knp=\E[6~, kpp=\E[5~, 
        mc0=\E[i, mc4=\E[4i, mc5=\E[5i, op=\E[39;49m, rc=\E8, 
        rev=\E[7m, ri=\EM, rin=\E[%p1%dT, rmacs=\E(B, rmam=\E[?7l, 
        rmcup=\E[?1049l, rmir=\E[4l, rmkx=\E[?1l\E>, rmso=\E[23m, 
        rmul=\E[24m, rs1=\Ec, rs2=\E[!p\E[?3;4l\E[4l\E>, sc=\E7, 
        setab=\E[48;5;%p1%dm, setaf=\E[38;5;%p1%dm, 
        setb=\E[48;5;%p1%dm, setf=\E[38;5;%p1%dm, 
        
sgr=\E[0%?%p6%t;1%;%?%p2%t;4%;%?%p1%p3%|%t;7%;%?%p4%t;5%;%?%p7%t;8%;m%?%p9%t\E(0%e\E(B%;,
 
        sgr0=\E[m\E(B, smacs=\E(0, smam=\E[?7h, smcup=\E[?1049h, 
        smir=\E[4h, smkx=\E[?1h\E=, smso=\E[3m, smul=\E[4m, 
        tbc=\E[3g, u6=\E[%i%d;%dR, u7=\E[6n, u8=\E[?1;2c, u9=\E[c, 
        vpa=\E[%i%p1%dd, 

[mail]: http://lists.gnu.org/archive/html/screen-users/2006-05/msg00029.html