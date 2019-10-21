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

import 'package:flutter_gallery/demo/rally/tabs/accounts.dart';
import 'package:flutter_gallery/demo/rally/tabs/bills.dart';
import 'package:flutter_gallery/demo/rally/tabs/budgets.dart';
import 'package:flutter_gallery/demo/rally/tabs/overview.dart';
import 'package:flutter_gallery/demo/rally/tabs/settings.dart';

import 'responsive.dart';

const int tabCount = 5;
const int turnsToRotateRight = 1;
const int turnsToRotateLeft = 3;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabCount, vsync: this)
     ..addListener(() {
      setState(() { });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final TabBar tabBar = TabBar(
      // Setting isScrollable to true prevents the tabs from being
      // wrapped in [Expanded] widgets, which allows for more
      // flexible sizes and size animations among tabs.
      isScrollable: true,
      labelPadding: EdgeInsets.zero,
      tabs: _buildTabs(theme),
      controller: _tabController,
      // This hides the tab indicator.
      indicatorColor: Colors.transparent,
    );
    return Scaffold(
      body: SafeArea(
        child: Theme(
          // This theme effectively removes the default visual touch
          // feedback for tapping a tab, which is replaced with a custom
          // animation.
          data: theme.copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Responsive(
            mobile: Column(
              children: <Widget>[
                tabBar,
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: _buildTabViews(),
                  ),
                ),
              ],
            ),
            desktop: Row(
              children: <Widget>[
                Container(
                  width: 150,
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 80,
                        child: Image.asset(
                          'logo.png',
                          package: 'rally_assets',
                        ),
                      ),
                      const SizedBox(height: 24),
                      RotatedBox(
                        quarterTurns: turnsToRotateRight,
                        child: tabBar,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RotatedBox(
                    quarterTurns: turnsToRotateRight,
                    child: TabBarView(
                      controller: _tabController,
                      children: _buildDesktopTabViews(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs(ThemeData theme) {
    return <Widget>[
      _buildTab(theme, Icons.pie_chart, 'OVERVIEW', 0),
      _buildTab(theme, Icons.attach_money, 'ACCOUNTS', 1),
      _buildTab(theme, Icons.money_off, 'BILLS', 2),
      _buildTab(theme, Icons.table_chart, 'BUDGETS', 3),
      _buildTab(theme, Icons.settings, 'SETTINGS', 4),
    ];
  }

  List<Widget> _buildTabViews() {
    return <Widget>[
      OverviewView(),
      AccountsView(),
      BillsView(),
      BudgetsView(),
      SettingsView(),
    ];
  }

  List<Widget> _buildDesktopTabViews() {
    // We rotate the content so that we can swipe vertically.
    return <Widget>[
      RotatedBox(quarterTurns: turnsToRotateLeft, child: OverviewView()),
      RotatedBox(quarterTurns: turnsToRotateLeft, child: AccountsView()),
      RotatedBox(quarterTurns: turnsToRotateLeft, child: BillsView()),
      RotatedBox(quarterTurns: turnsToRotateLeft, child: BudgetsView()),
      RotatedBox(quarterTurns: turnsToRotateLeft, child: SettingsView()),
    ];
  }

  Widget _buildTab(
    ThemeData theme,
    IconData iconData,
    String title,
    int index,
  ) {
    return _RallyTab(
      theme.textTheme.button,
      Icon(iconData),
      title,
      _tabController.index == index,
    );
  }

}

class _RallyTab extends StatefulWidget {
  _RallyTab(this.style, this.icon, String title, this.isExpanded) : titleText = Text(title, style: style);

  final TextStyle style;
  final Text titleText;
  final Icon icon;
  final bool isExpanded;

  @override
  _RallyTabState createState() => _RallyTabState();
}

class _RallyTabState extends State<_RallyTab>
    with SingleTickerProviderStateMixin {
  Animation<double> _titleSizeAnimation;
  Animation<double> _titleFadeAnimation;
  Animation<double> _iconFadeAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _titleSizeAnimation = _controller.view;
    _titleFadeAnimation = _controller.drive(CurveTween(curve: Curves.easeOut));
    _iconFadeAnimation = _controller.drive(Tween<double>(begin: 0.6, end: 1));
    if (widget.isExpanded) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(_RallyTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    // For desktops we have a vertical tab.
    if (Window.isDesktop(context)) {
      return RotatedBox(
        quarterTurns: turnsToRotateLeft,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 36),
            FadeTransition(
              child: widget.icon,
              opacity: _iconFadeAnimation,
            ),
            const SizedBox(height: 12),
            FadeTransition(
              child: SizeTransition(
                child: Center(child: widget.titleText),
                axis: Axis.vertical,
                axisAlignment: -1,
                sizeFactor: _titleSizeAnimation,
              ),
              opacity: _titleFadeAnimation,
            ),
          ],
        ),
      );
    }

    // Calculate the width of each unexpanded tab by counting the number of
    // units and dividing it into the screen width. Each unexpanded tab is 1
    // unit, and there is always 1 expanded tab which is 1 unit + any extra
    // space determined by the multiplier.
    final double width = MediaQuery.of(context).size.width;
    const double expandedTitleWidthMultiplier = 2;
    final double unitWidth = width / (tabCount + expandedTitleWidthMultiplier);

    return SizedBox(
      height: 56,
      child: Row(
        children: <Widget>[
          FadeTransition(
            child: SizedBox(
              width: unitWidth,
              child: widget.icon,
            ),
            opacity: _iconFadeAnimation,
          ),
          FadeTransition(
            child: SizeTransition(
              child: SizedBox(
                width: unitWidth * expandedTitleWidthMultiplier,
                child: Center(child: widget.titleText),
              ),
              axis: Axis.horizontal,
              axisAlignment: -1,
              sizeFactor: _titleSizeAnimation,
            ),
            opacity: _titleFadeAnimation,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}