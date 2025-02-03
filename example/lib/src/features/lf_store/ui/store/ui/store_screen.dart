import 'package:example/src/common/widget_tile.dart';
import 'package:example/src/models/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class StoreScreen extends ScreenStatefulWidget {
  final String title;

  const StoreScreen({
    super.key,
    required this.title,
  });

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends ScreenState<StoreScreen> {
  String _catchOriginalString = 'None';
  String _catchErrorValueExceptionString = 'None';

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
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WidgetTile(
              title: 'Test UIModel',
              child: Column(
                children: [
                  LFButton(
                    text: 'Test',
                    onTap: () {
                      const person = Person(
                        payload: '1',
                        name: 'John Doe',
                        age: 30,
                      );
                      debugPrint('person: ${person.toString()}');
                    },
                  ),
                ],
              ),
            ),
            WidgetTile(
              title: 'Test UIModelV2',
              child: Column(
                children: [
                  LFButton(
                    text: 'Test',
                    onTap: () {
                      const person = PersonV2(
                        payload: '1',
                        name: 'John Doe',
                        age: 30,
                      );
                      debugPrint('person: ${person.toString()}');
                    },
                  ),
                ],
              ),
            ),
            WidgetTile(
              title: 'Test ErrorValue',
              child: Column(
                children: [
                  LFButton(
                    text: 'Test',
                    onTap: () {
                      try {
                        const errorValue = ErrorValue(
                          statusCode: kDefaultStatusCode,
                          errorCode: 'E001',
                          errorMessage: 'Error Message',
                        );
                        throw ErrorValueException(errorValue);
                      } catch (e) {
                        debugPrint('catch (original): ${e.toString()}');
                        setState(() {
                          _catchOriginalString = e.toString();
                        });
                        if (e is ErrorValueException) {
                          final errorValue = e.value;
                          debugPrint(
                              'catch (errorValue): ${errorValue.toString()}');
                          setState(() {
                            _catchErrorValueExceptionString =
                                errorValue.toString();
                          });
                        }
                      } finally {
                        debugPrint('Finally');
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const LFText('catch (original):'),
                        LFText(_catchOriginalString),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const LFText('catch (errorValue):'),
                        LFText(_catchErrorValueExceptionString),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
