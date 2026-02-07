import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class TextFieldScreen extends LeafScreenStatefulWidget {
  const TextFieldScreen({super.key});

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends LeafScreenState<TextFieldScreen> {
  final _basicController = LeafTextFieldController();
  final _emailController = LeafTextFieldController();
  final _passwordController = LeafTextFieldController();

  @override
  void dispose() {
    _basicController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'TextField'));
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
              child: LeafTextField(
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
              child: LeafTextField(
                controller: _emailController,
                placeHolder: 'email@example.com',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email, size: 20),
              ),
            ),
            ShowcaseTile(
              label: 'Password',
              child: LeafTextField(
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
              child: LeafTextField(
                controller: LeafTextFieldController(),
                placeHolder: 'Invalid input',
                errorText: 'This field is required',
              ),
            ),
            ShowcaseTile(
              label: 'Disabled',
              child: LeafTextField(
                controller: LeafTextFieldController(),
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
