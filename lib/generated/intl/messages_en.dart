// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activity": MessageLookupByLibrary.simpleMessage("Events"),
        "announce": MessageLookupByLibrary.simpleMessage("Notices"),
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "info": MessageLookupByLibrary.simpleMessage("Info"),
        "languageCodeSubtitle": MessageLookupByLibrary.simpleMessage(
            "The entries are from officially supported languages."),
        "languageCodeTitle":
            MessageLookupByLibrary.simpleMessage("Custom language code"),
        "launchGame": MessageLookupByLibrary.simpleMessage("Launch"),
        "remoteFailed": MessageLookupByLibrary.simpleMessage(
            "Failed to load remote contents."),
        "remoteLoading": MessageLookupByLibrary.simpleMessage(
            "Please wait while loading remote contents."),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "showBannersSubtitle": MessageLookupByLibrary.simpleMessage(
            "The banners are a series of images for advertisements."),
        "showBannersTitle":
            MessageLookupByLibrary.simpleMessage("Show official banners"),
        "showPostsSubtitle": MessageLookupByLibrary.simpleMessage(
            "The posts are a series of hyperlinks for activities, etc."),
        "showPostsTitle":
            MessageLookupByLibrary.simpleMessage("Show official posts")
      };
}
