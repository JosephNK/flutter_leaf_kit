part of lf_calendar_view;

typedef LFCalendarProviderOnCellTapped = void Function(
  List<DateTime> dates,
);

class LFCalendarProvider extends ChangeNotifier {
  final DateTime dateTime;
  final LFCalendarProviderOnCellTapped onCellTapped;

  LFCalendarProvider({
    required this.dateTime,
    required this.onCellTapped,
  }) {
    _initialize(dateTime);
  }

  List<DateTime> _selectedDateTimes = [];
  DateTime _currentDateTime = DateTime.now();

  UnmodifiableListView<DateTime> get selectedDateTimes =>
      UnmodifiableListView(_selectedDateTimes);

  DateTime get currentDateTime => _currentDateTime;

  void _initialize(DateTime dateTime) {
    _currentDateTime = dateTime;
    notifyListeners();
  }

  void setDateTime(DateTime dateTime) {
    _currentDateTime = dateTime;
    notifyListeners();
  }

  void toggle(DateTime dateTime, {bool multiple = false}) {
    if (multiple) {
      if (_selectedDateTimes.contains(dateTime)) {
        _selectedDateTimes.remove(dateTime);
      } else {
        _selectedDateTimes.add(dateTime);
      }
    } else {
      _selectedDateTimes = [];
      _selectedDateTimes.add(dateTime);
    }
    onCellTapped.call(_selectedDateTimes);
    notifyListeners();
  }

  void add(DateTime dateTime) {
    if (!_selectedDateTimes.contains(dateTime)) {
      _selectedDateTimes.add(dateTime);
    }
    notifyListeners();
  }

  void remove(DateTime dateTime) {
    if (_selectedDateTimes.contains(dateTime)) {
      _selectedDateTimes.remove(dateTime);
    }
    notifyListeners();
  }

  void removeAll() {
    _selectedDateTimes.clear();
    notifyListeners();
  }
}
