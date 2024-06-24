import 'dart:convert';

class StrObf {
  static const String _baseAlphabet = ""
      "!#%&'()*+,-./0123456789:;<=>?@"
      "ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`"
      "abcdefghijklmnopqrstuvwxyz{|}~";
// all printable chars without $ \ "

  static String encode(String input) {
    List<int> source = utf8.encode(input);
    List<int> output = [];
    int b = 0;
    int n = 0;
    int v = 0;

    for (int i = 0; i < source.length; ++i) {
      b |= (source[i] & 255) << n;
      n += 8;

      if (n > 13) {
        v = b & 8191;

        if (v > 88) {
          b >>= 13;
          n -= 13;
        } else {
          v = b & 16383;
          b >>= 14;
          n -= 14;
        }

        output.add(_baseAlphabet.codeUnitAt(v % 91));
        output.add(_baseAlphabet.codeUnitAt(v ~/ 91));
      }
    }

    if (n != 0) {
      output.add(_baseAlphabet.codeUnitAt(b % 91));
      if (n > 7 || b > 90) {
        output.add(_baseAlphabet.codeUnitAt(b ~/ 91));
      }
    }

    return String.fromCharCodes(output);
  }

  static String decode(String inputString) {
    List<int> input = inputString.codeUnits;
    int v = -1;
    int b = 0;
    int n = 0;
    List<int> output = [];

    for (int i = 0; i < input.length; ++i) {
      int d = _baseAlphabet.indexOf(String.fromCharCode(input[i]));
      if (d == -1) continue;

      if (v < 0) {
        v = d;
      } else {
        v += d * 91;
        b |= v << n;
        n += (v & 8191) > 88 ? 13 : 14;
        do {
          output.add(b & 255);
          b >>= 8;
          n -= 8;
        } while (n > 7);
        v = -1;
      }
    }

    if (v != -1) output.add((b | v << n) & 255);

    return utf8.decode(output);
  }
}
