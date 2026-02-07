import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class TextFieldScreen extends LFScreenStatefulWidgetV2 {
  const TextFieldScreen({super.key});

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends LFScreenStateV2<TextFieldScreen> {
  final _basicController = LFTextFieldControllerV2();
  final _emailController = LFTextFieldControllerV2();
  final _passwordController = LFTextFieldControllerV2();

  @override
  void dispose() {
    _basicController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'TextField'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Basic TextField',
          children: [
            ShowcaseTile(
              label: 'Default',
              child: LFTextFieldV2(
                controller: _basicController,
                placeHolder: 'Enter text...',
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Input Types',
          children: [
            ShowcaseTile(
              label: 'Email',
              child: LFTextFieldV2(
                controller: _emailController,
                placeHolder: 'email@example.com',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email, size: 20),
              ),
            ),
            ShowcaseTile(
              label: 'Password',
              child: LFTextFieldV2(
                controller: _passwordController,
                placeHolder: 'Password',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock, size: 20),
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'States',
          children: [
            ShowcaseTile(
              label: 'With error',
              child: LFTextFieldV2(
                controller: LFTextFieldControllerV2(),
                placeHolder: 'Invalid input',
                errorText: 'This field is required',
              ),
            ),
            ShowcaseTile(
              label: 'Disabled',
              child: LFTextFieldV2(
                controller: LFTextFieldControllerV2(),
                placeHolder: 'Disabled field',
                disabled: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
