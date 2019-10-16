// Copyright 2019-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter_gallery/demo/rally/responsive.dart';

import 'colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double loginMaxWidth = Window.isDesktop(context) ? 400 : double.infinity;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const BackButtonIcon(),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Column(
            children: <Widget>[
              Responsive.onlyDesktop(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(width: 30),
                    SizedBox(
                      height: 80,
                      child: Image.asset(
                        'logo.png',
                        package: 'rally_assets',
                      ),
                    ),
                    const SizedBox(width: 30),
                    Text(
                      'Login to Rally',
                      style: Theme.of(context).textTheme.body2.copyWith(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    Text(
                      'Don\'t have an account?',
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    const SizedBox(width: 30),
                    const BorderButton(text: 'SIGN UP'),
                    const SizedBox(width: 30),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Window.isDesktop(context) ? Alignment.center : Alignment.topCenter,
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: <Widget>[
                      Responsive.onlyMobile(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 64),
                          child: SizedBox(
                            height: 160,
                            child: Image.asset(
                              'logo.png',
                              package: 'rally_assets',
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: loginMaxWidth),
                          child: TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: loginMaxWidth),
                          child: TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                          ),
                        ),
                      ),
                      Responsive.onlyMobile(
                        child: SizedBox(
                          height: 120,
                          child: Image.asset(
                            'thumb.png',
                            package: 'rally_assets',
                          ),
                        ),
                      ),
                      Responsive.onlyDesktop(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            constraints: BoxConstraints(maxWidth: loginMaxWidth),
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.check_circle_outline, color: RallyColors.buttonColor),
                                const SizedBox(width: 12),
                                const Text('Remember Me'),
                                const Expanded(child: SizedBox.shrink()),
                                const FilledButton(text: 'LOGIN'),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class BorderButton extends StatelessWidget {

  const BorderButton({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(color: RallyColors.buttonColor),
      color: RallyColors.buttonColor,
      highlightedBorderColor: RallyColors.buttonColor,
      onPressed: () {
        Navigator.pop(context);
      },
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textColor: Colors.white,
      child: Text(text),

    );
  }
}

class FilledButton extends StatelessWidget {
  const FilledButton({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Row(
        children: <Widget>[
          Icon(Icons.lock),
          const SizedBox(width: 6),
          Text(text),
        ],
      ),
      color: RallyColors.buttonColor,
    );
  }
}