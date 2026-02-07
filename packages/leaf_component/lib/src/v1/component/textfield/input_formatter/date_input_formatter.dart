part of '../textfield.dart';

// inputFormatters: [
//  FilteringTextInputFormatter.digitsOnly, // 숫자만!
//  DateFormatter(), // 자동 하이픈
// ],

@Deprecated('V1 component deprecated. Use V2 components instead.')
class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    // 숫자만 허용
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    // 최대 8자리까지만 허용 (YYYYMMDD)
    if (text.length > 8) {
      text = text.substring(0, 8);
    }

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    var buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);

      // YYYY- 형식 (4자리 년도 후 하이픈)
      if (i == 3 && text.length > 4) {
        buffer.write('-');
      }
      // YYYY-MM- 형식 (6자리 후 하이픈)
      else if (i == 5 && text.length > 6) {
        buffer.write('-');
      }
    }

    var formattedText = buffer.toString();

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
