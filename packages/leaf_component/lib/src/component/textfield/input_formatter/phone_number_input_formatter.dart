part of '../textfield.dart';

// https://velog.io/@tgc05074/Flutter-%ED%9C%B4%EB%8C%80%ED%8F%B0-%EB%B2%88%ED%98%B8-%EC%9E%85%EB%A0%A5%EC%8B%9C-%EC%9E%90%EB%8F%99-%ED%95%98%EC%9D%B4%ED%94%88auto-hyphen
// inputFormatters: [
//  FilteringTextInputFormatter.digitsOnly, // 숫자만!
//  PhoneNumberFormatter(), // 자동 하이픈
//  NumberLengthLimitingTextInputFormatter(13) // 13자리만 입력 받도록 하이픈 2개 + 숫자 11개
// ],

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex <= 3) {
        if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); // Add double spaces.
        }
      } else {
        if (nonZeroIndex % 7 == 0 &&
            nonZeroIndex != text.length &&
            nonZeroIndex > 4) {
          buffer.write('-');
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
