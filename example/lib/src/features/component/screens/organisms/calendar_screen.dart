import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class CalendarScreen extends LeafScreenStatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends LeafScreenState<CalendarScreen> {
  DateTime? _selectedDate;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Calendar'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final typography = context.leafTypography;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Month Calendar',
          children: [
            ShowcaseTile(
              label: _selectedDate != null
                  ? 'Selected: ${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}'
                  : 'Tap a date to select',
              child: SizedBox(
                height: 350,
                child: LeafCalendarView(
                  defaultDate: DateTime.now(),
                  minDate: DateTime(2020),
                  maxDate: DateTime(2030),
                  onDateSelected: (date) {
                    setState(() => _selectedDate = date);
                  },
                ),
              ),
            ),
          ],
        ),
        if (_selectedDate != null)
          Center(
            child: Text(
              'Selected: ${_selectedDate!.toIso8601String().split('T').first}',
              style: typography.bodyLarge,
            ),
          ),
      ],
    );
  }
}
