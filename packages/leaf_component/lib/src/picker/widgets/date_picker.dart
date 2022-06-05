part of leaf_picker_component;

class LeafDatePicker {
  static Future<void> showDate(
    BuildContext context, {
    DateTime? selectedDate,
    bool isUseFuture = true,
    ValueChanged<String>? onChange,
    ValueChanged<String>? onConfirm,
  }) async {
    DatePicker.showDatePicker(
      context,
      minDateTime: DateTime(1800),
      maxDateTime: isUseFuture ? DateTime(2200) : DateTime.now(),
      initialDateTime: selectedDate,
      dateFormat: 'yyyy-MM-dd',
      pickerTheme: const DateTimePickerTheme(
        showTitle: true,
      ),
      pickerMode: DateTimePickerMode.date,
      onChange: (dateTime, List<int> index) {
        final result = DateFormat('yyyy-MM-dd').format(dateTime);
        onChange?.call(result);
      },
      onConfirm: (dateTime, List<int> index) {
        final result = DateFormat('yyyy-MM-dd').format(dateTime);
        onConfirm?.call(result);
      },
    );
  }

  static Future<void> showDateTime(
    BuildContext context, {
    DateTime? selectedDate,
    bool isUseFuture = true,
    ValueChanged<String>? onChange,
    ValueChanged<String>? onConfirm,
  }) async {
    DatePicker.showDatePicker(
      context,
      minDateTime: DateTime(1800),
      maxDateTime: isUseFuture ? DateTime(2200) : DateTime.now(),
      initialDateTime: selectedDate,
      dateFormat: 'yyyy-MM-dd HH:mm',
      pickerTheme: const DateTimePickerTheme(
        showTitle: true,
      ),
      pickerMode: DateTimePickerMode.datetime,
      onChange: (dateTime, List<int> index) {
        final result = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
        onChange?.call(result);
      },
      onConfirm: (dateTime, List<int> index) {
        final result = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
        onConfirm?.call(result);
      },
    );
  }
}
