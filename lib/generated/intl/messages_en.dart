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

  static String m0(url) => "Failed to launch ${url}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "dark": MessageLookupByLibrary.simpleMessage("Dark"),
        "description": MessageLookupByLibrary.simpleMessage(
            "This app is a GitHub Repository Search API wrapper.\n\nFor yumemi codecheck."),
        "errorNoInternet":
            MessageLookupByLibrary.simpleMessage("No internet connection"),
        "errorServiceUnavailable": MessageLookupByLibrary.simpleMessage(
            "GitHub service is temporarily unavailable"),
        "errorUnexpected":
            MessageLookupByLibrary.simpleMessage("Unexpected error occurred"),
        "errorValidation": MessageLookupByLibrary.simpleMessage(
            "Validation failed, or the endpoint has been spammed."),
        "failedLaunch": m0,
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "light": MessageLookupByLibrary.simpleMessage("Light"),
        "noResults": MessageLookupByLibrary.simpleMessage("No results found"),
        "searchPlaceholder":
            MessageLookupByLibrary.simpleMessage("Search Repositories"),
        "system": MessageLookupByLibrary.simpleMessage("System"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "title": MessageLookupByLibrary.simpleMessage("Github Repos Search")
      };
}
