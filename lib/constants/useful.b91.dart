import "dart:convert";

import "package:easy_launcher/utils/str_obf.dart";

class UsefulKV {
  static const String _k = "O@n%!;m*OXfQe`(6KknXii{4|4eXri)5n[bT5ia:uY(hv=K7}(wU%g**__}N:=p=/Eu!>.n+JpuDi*7Yqn4uyF!c?BYEd;,b8iG'XFCS#l(ii:')AP:FR>mE9?+ZOQ3/(O8S'/[?n%!;?/b+tj'GYE/Q,l%E1Q|4Nt``377Ve+qG%5cX)sp;K7}(on!g**__}N:=p=/Eu!>.n+pXOhoV)Z7psF-7Q,*pCKOKl4eX<Go6&,%>5i#F')AP:F*<mE9?+ZOQ3/(O8S'/[?n%!;B@_4Lt[;>Fy&o+8KG/g,,S&I(6YPbTJF.6DY(ht;K7}(Im)Z3WT]<SK;;.}(K>IHq*K4Im{FYEJS8peGgV}bLtHTi6E]~XKF1QS,juw:8@cBAW&B7!pR)Im*|4on3Ge4E&V+kiK/pX8iui8FM4!,?F_:o+!Y#;A.!)g@&ZOQ4]<SK;;.}(Hp/G^;;4vU=T(6-QC>ji3QC,&sL0_F5)s'IH,6F,juw:3?1,.@-UG5&)?1H#!/7)&leGi:o+*sV2uExS7Buid;,bMtj^9EV,_+TJM/7-!SSS~@,=Gn/;8]](!S0uz38V%(uk5Q)Z^q7Gz3o[m+sk=A'YNih;o6wjYTtK{.R]^5mG)/[?n%!;F0OX_qD0_4d_P'uD0#uY,o%jI5~b7B:I)5r+@sz=K7}(Im)Z}@i04>RQW&E~QQ3EuSDltko*uY'h5%tEoeDlHH0R(-YjBRzExjg=3;<#!)j#w1`:D=uVhZ;hk#4Ph/I6K45>nI[KLbBW|k>Fa_bTtkq*,bSTm;i6uj?B4;<#!)S8{1e;9,g(WVQt^1*bK!_(@?x&E;RmpRQQt)#)ryL!";
  static const String _v = "O@n%!;9th3j#x_PDWVeVtK{.?5kmcIU7eM`B,s[)jd<e'3eGUkmYhiXoA+htdw]GBQQkAr4upbbmA0RJCN!&1*d!Rj&ZZiO[17{%D;-|K),;<#!)J-b<H<],O@jE;hk#4P:F*<a):mhS7AN19SU%!/H]8-4uay>XOZ~#cMmHT+1n%QYdjfMa7KA2YkArlz@c3h*%cMmH8p`qUAN4hf;'*H0)uSS9{.]_~NZ1}@>,r?r]fW!/juw:=A9]s,5pTLW6/SK;;.}(Im)Z3WT]<SU%!/52hqHhSAr[?eh2DGu)uSS9{.[1q22=K7}(WBru4*9dj'p2nI<2'q'SS5()?1H#!/DVhUARe@^1juw:;GE]k?xpN0,e8eD'`Fu)uSS9{.,_W'V1(<6Y%S`9/Ko4O-T``Fc&:pQhGA=7*bK!_(c9[_*<4KAWtK{.0ccmF1MI.Q%Cil*u=7*bK!_(&-/_D;T)-(!;GANemQ)aWK/Eu!>.n+}V=_=to_<SU%!/52hqHhSAr[?eEanIv)uSS9{.^[*>}GPD4Kcm.;<##VZWD3)It7(BAk**>emTgj#Gq)uSS9{.h^V?gji<U&w@iZY5&)AP;t_F`Kk,2ntWObamGwoI/Eu!>.^[q*hS#]`(!&j0%/cuw!";

  static Future<String> whatIsK() async {
    return StrObf.decode(_k);
  }

  static Future<String> whatIsV() async {
    return StrObf.decode(_v);
  }

  static Future<String> getK(String oracle) async {
    return jsonDecode(await whatIsK())[oracle];
  }

  static Future<String> getV(String oracle) async {
    return jsonDecode(await whatIsV())[oracle];
  }

  static Future<String> get(String oracle) async {
    if (await getK("TYPE") != "B91" || await getV("TYPE") != "B91") {
      return "";
    }
    return getV(await getK(oracle));
  }
}
