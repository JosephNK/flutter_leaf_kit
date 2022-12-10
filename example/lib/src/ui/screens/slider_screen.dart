import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class SliderScreen extends ScreenStatefulWidget {
  final String title;

  const SliderScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends ScreenState<SliderScreen> {
  double _sliderValue = 0.0;
  RangeValues _rangeSliderValues = const RangeValues(0.3, 0.7);

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Widget? buildScreen(BuildContext context) {
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return LFAppBar(
      title: LFAppBarTitle(text: widget.title),
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DSSlider(
          value: _sliderValue,
          min: 0,
          max: 10,
          divisions: 10,
          onChanged: (value) {
            setState(() {
              _sliderValue = value;
            });
          },
        ),
        const SizedBox(height: 50.0),
        DSRangeSlider(
          values: _rangeSliderValues,
          min: 0,
          max: 10,
          divisions: 10,
          onChanged: (value) {
            setState(() {
              _rangeSliderValues = value;
            });
          },
        ),
      ],
    );
  }
}
