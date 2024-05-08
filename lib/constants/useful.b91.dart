import 'dart:convert';

import 'package:easy_launcher/utils/str_obf.dart';

class UsefulKV {
  static const String _k = "O@n%!;xE]b^jO'`4(Y;>ii&6!5cQo=SEwjy'[E+Q,bon~=K7}(5@{_Y5e]c<zHs>.],V=_|5i0*bK!_(xk~=N6d_&UgEl)/bImL0#5C/'(wDcV)ZQT2%yFzj#S`9;hO[17{%D;-|Jm)Z}@i0)OW_FBO,uV&B7!pR2_{#4/juw:::LS#Sy{7!";
  static const String _v = "O@n%!;>*~1_'K_x?O,}V=_=to_g'z<K7}(1,vuB6=ZDf)UiHzXgCqu462X;^CwcMZK8p{p'Qt5AWzHnI+HBpBD!+^7pTq`7KA&FCBDWzH6bWrT-/[?n%!;>*~1_'K_x?O,}V=_=to_~2>1SD.K%S`9t?e2@s#<JIK)uSS9{.m_~9U<K7}(@?[E#]}8(";

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
    return getV(await getK(oracle));
  }
}
