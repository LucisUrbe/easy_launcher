import "dart:convert";

import "package:easy_launcher/utils/str_obf.dart";

class UsefulKV {
  static const String _k = "O@n%!;xE]b^jO'`4(Y;>ii&6!5cQo=SEwjy'[E+Q,bon~=K7}(5@{_Y5e]c<zHs>.],V=_|5i0*bK!_(xk~=N6d_&UgEl)/bImL0#5C/'(wDcV)ZQT2%yFzj#S`9;hO[17{%D;-|Jm)Z}@i0)OW_FBO,uV&B7!pR?h<@g,3V|F#4RYo=RJO/!5MtD037U,:p7KcV]bgX#;A./E9?+ZOQ3/(OfuS>~1t)'g[5&)?1H#!/uSH'oIkVl4(sv=!5ZPYTKF#6t,+oh`!G~4zk3kG/7-!SY1}@>,r?r]|5y0V?Vj^@~BY?(g[5&)?1H#!/:kV@,;<#!)Tt`;V&Q@!";
  static const String _v = "O@n%!;>*~1_'K_x?O,}V=_=to_g'z<K7}(1,vuB6=ZDf)UiHzXgCqu462X;^CwcMZK8p{p'Qt5AWzHnI+HBpBD!+^7pTq`7KA&FCBDWzH6bWrT-/[?n%!;>*~1_'K_x?O,}V=_=to_~2>1SD.K%S`9t?e2@s#<JIK)uSS9{.G^u@5HH<GVuogZ7;4/V?{v=@RmpR8m(<kd6vptPK'CQk3us4OeamFI?3BN4r=wN0?e:e.wNI%:K,3kNL)dJS=Ta3L/{p*p;AJdm[{=b3*Qkphi6uNe:e[>R2/~w:j=l_GnnUj/jaM8LSE;.]uofSCz{^<SU%!/W,A*ilF0D5*bK!_(@?x&E;RmpRQQt)#)ryL!";

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
