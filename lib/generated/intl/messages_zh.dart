// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activity": MessageLookupByLibrary.simpleMessage("活动"),
        "announce": MessageLookupByLibrary.simpleMessage("公告"),
        "info": MessageLookupByLibrary.simpleMessage("资讯"),
        "launchGame": MessageLookupByLibrary.simpleMessage("启动"),
        "remoteFailed": MessageLookupByLibrary.simpleMessage("远程内容载入失败了。"),
        "remoteLoading": MessageLookupByLibrary.simpleMessage("请稍等，正在载入远程内容。"),
        "settings": MessageLookupByLibrary.simpleMessage("设置")
      };
}