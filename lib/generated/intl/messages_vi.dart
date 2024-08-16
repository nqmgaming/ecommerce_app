// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
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
  String get localeName => 'vi';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "dontHaveAccount":
            MessageLookupByLibrary.simpleMessage("Chưa có tài khoản? "),
        "emailHint": MessageLookupByLibrary.simpleMessage("Địa chỉ email"),
        "emailRequired":
            MessageLookupByLibrary.simpleMessage("Email là bắt buộc"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Quên mật khẩu?"),
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("Địa chỉ email không hợp lệ"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "loginTitle": MessageLookupByLibrary.simpleMessage(
            "Đăng nhập\ntài khoản của bạn"),
        "orLoginWith":
            MessageLookupByLibrary.simpleMessage("Hoặc đăng nhập bằng"),
        "passwordHint": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "passwordRequired":
            MessageLookupByLibrary.simpleMessage("Mật khẩu là bắt buộc"),
        "passwordTooShort": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu phải có ít nhất 6 ký tự"),
        "pleaseFillRequired": MessageLookupByLibrary.simpleMessage(
            "Vui lòng điền vào các trường bắt buộc"),
        "signUp": MessageLookupByLibrary.simpleMessage("Đăng ký")
      };
}
