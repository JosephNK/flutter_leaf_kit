import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class PickerScreen extends LFScreenStatefulWidgetV2 {
  const PickerScreen({super.key});

  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends LFScreenStateV2<PickerScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Picker'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Date Picker',
          children: [
            ShowcaseTile(
              label: 'Expandable date picker',
              child: LFDatePickerV2(
                label: const Text('Select Date'),
                icon: const Icon(Icons.calendar_today),
                initialDate: _selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                onChanged: (date) {
                  setState(() => _selectedDate = date);
                },
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Time Picker',
          children: [
            ShowcaseTile(
              label: 'Expandable time picker',
              child: LFTimePickerV2(
                label: const Text('Select Time'),
                icon: const Icon(Icons.access_time),
                initialTime: _selectedTime,
                onChanged: (time) {
                  setState(() => _selectedTime = time);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
