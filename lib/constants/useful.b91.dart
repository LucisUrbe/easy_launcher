import "dart:convert";

import "package:easy_launcher/utils/str_obf.dart";

class UsefulKV {
  static const String _k = "O@n%!;b)OX5ij^(6q[7BMj-Q+4?WT`.6vjg=pGF@[4Oih;K7}(wU%g**__}N:=p=/Eu!>.*eTl4ipW]b^q)Ij5.QUXnIb;g,Hm7GtEyjUXIHrW#)AP:FR>mE9?+ZOQ3/(O8S'/[?n%!;6RC,:p^^-7.hIT?kh))Z!YxF_FJbw=uD|EC,,o#<K7}(on!g**__}N:=p=/Eu!>.oXS>jiyFN4QpC'j6<e?B/Ig:<b,oK'8F{4IB#l`;#)AP:F*<mE9?+ZOQ3/(O8S'/[?n%!;Z:)ZLm,u3EP4tTuDf)?bZj5I#4gV,leGs*}bzU%<K7}(Im)Z3WT]<SK;;.}(y'8KgVC,;pBRH6]_q'{Ic:K4Km7GC5J4KT.IuF>4juw:8@cBAW&B7!pRok<@+-Jm!Gd5)hIT.Il)'Y!Y1u_4!5y=UHd;&,.S#;A.!)g@&ZOQ4]<SK;;.}(TlIH#6}b4VATzE3`^XpGrE#c(h2R3E~XzTSJH0|4juw:3?1,.@-UG5&)?1H#!/XhITpGYKK4HmM%i6p.CTJFKK]bKtO'j6]PQTgEJ07-!SSS~@,=Gn/;8]](!Sf^YE+hzTdG7QLblg9%j6`1RpoIF0?baqeitED/tTtK{.R]^5mG)/[?n%!;O/+-8pZ2)5tjnX5ih)]bzQa;>4l.i=gE3Ql4nnz=K7}(Im)Z}@i04>RQW&E~QQ!GY1(U4i}4+-+S5uz3,h(puD7QN+Ot>RH6'hHp(;<#!)j#w1`:D=uVhZ;hk#4P!;_4VP#leG'5.4jTpkI5Ikm+ki~EV,gXF%!5ZhP'4;<#!)S8{1e;9,g(WVQt^1*bK!_(oU=ui6Y1lTii+5l4ESq;!GC]H'UHb;cXam3G!52)&S`9RsN.'ONj(/[?n%!;^KLb#lui#4),.l.IOK`X?sI%-7:ew=:Ig:)Zftj=K7}(rms]0Lia(7RQW&E~P#>4;V0ppGtEV,xqK'uE9)ST4ip)S,Zj}ie4M4QB';<#!)s2V^PD.K#&1*d!Q<%E/%+4)sJRd5]_Pp3k'5)Z+oNR9EujUX-I,6cXDSU%!/8:%lER|/i*)Pw:wFVPQT?FO/]b^qn=i6^_GBMjsVDYxUD'uED&Fl_J#]`(t6s%RDTE}VuPx/i*)Pw:x3P4y=3kEA.4Jmp;8F%Y8'kiO/;4STh29F~4'(JH#]`(K.n<9?~{;)jZ**H0*bK!_(gnf^!5[hrTuiQK|4+oI^XF`_y'!G*6WYiTniI5^P#S`9iP80@*{vn=P)g(.;8]](!Sz=8FCShk/G:@l4QTQ0`4u[m+uD`;b+~XGRN612STtK{.]./lzvn=P)g(.;8]](!Sz1:?F)-(!;+W_+:1!?#";
  static const String _v = "O@n%!;9th3j#x_PDWVeVtK{.?5kmcIU7eM`B,s[)jd<e'3eGUkmYhiXoA+htdw]GBQQkAr4upbbmA0RJCN!&1*d!Rj&ZZiO[17{%D;-|K),;<#!)J-b<H<],O@jE;hk#4P:F*<a):mhS7AN19SU%!/H]8-4uay>XOZ~#cMmHT+1n%QYdjfMa7KA2YkArlz@c3h*%cMmH8p`qUAN4hf;'*H0)uSS9{.]_~NZ1}@>,r?r]fW!/juw:=A9]s,5pTLW6/SK;;.}(Im)Z3WT]<SU%!/52hqHhSAr[?eh2DGu)uSS9{.[1q22=K7}(WBru4*9dj'p2nI<2'q'SS5()?1H#!/DVhUARe@^1juw:;GE]k?xpN0,e8eD'`Fu)uSS9{.,_W'V1(<6Y%S`9/Ko4O-T``Fc&:pQhGA=7*bK!_(c9[_*<4KAWtK{.0ccmF1MI.Q%Cil*u=7*bK!_(&-/_D;T)-(!;GANemQ)aWK/Eu!>.n+}V=_=to_<SU%!/52hqHhSAr[?eEanIv)uSS9{.^[*>}GPD4Kcm.;<##VZWD3)It7(BAk**>emTgj#Gq)uSS9{.h^V?gji<U&w@iZY5&)AP;t_F`Kk,2ntWObamGwoI/Eu!>.iJg(&g9t%)AP#i:EK|gX6;8]](!SxGy?W7uo&Z#]`(L[7>TJB|gX6;8]](!SxGF5|{xU.;<#!)(aV^TDNK%&1*d!#SnURyp.:SU%!/X:&ltia0i*)Pw:N>fPuo^X~/N.9SU%!/%'Gqcljz?bIbRQW&E~P#N=wPkm4U)z`[84#;A.t9LY*s`z25dfW2-I/Eu!>.t9[)aSNLI^9&tR(/`~P#jH^1vo8pc0.4ISK;;.}(n()GNLI^9&tR(/`~!;dGj{*,Drk*(6*bK!_(@?x&E;RmpRQQt)#)ryL!";

  static String whatIsK() {
    return StrObf.decode(_k);
  }

  static String whatIsV() {
    return StrObf.decode(_v);
  }

  static String getK(String oracle) {
    return jsonDecode(whatIsK())[oracle];
  }

  static String getV(String oracle) {
    return jsonDecode(whatIsV())[oracle];
  }

  static String get(String oracle) {
    if (getK("TYPE") != "B91" || getV("TYPE") != "B91") {
      return "";
    }
    return getV(getK(oracle));
  }
}
