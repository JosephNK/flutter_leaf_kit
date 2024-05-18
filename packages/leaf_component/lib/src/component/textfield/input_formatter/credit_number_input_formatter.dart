part of '../textfield.dart';

// inputFormatters: [
//  FilteringTextInputFormatter.digitsOnly, // 숫자만!
//  CreditCardNumberFormatter(), // 자동 공백
//  NumberLengthLimitingTextInputFormatter(19) // 19자리만 입력 받도록 공백 3개 + 숫자 16개
// ],

class CreditCardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(' ', '');

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); // Add a space.
      }
    }

    var formattedText = buffer.toString();
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
