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
import 'package:flutter_gallery/demo/rally/adaptive/adaptive_layout.dart';

import 'package:flutter_gallery/demo/rally/data.dart';
import 'package:flutter_gallery/demo/rally/finance.dart';
import 'package:flutter_gallery/demo/rally/charts/pie_chart.dart';

import '../colors.dart';

/// A page that shows a summary of accounts.
class AccountsView extends StatelessWidget {
  final List<AccountData> items = DummyDataService.getAccountDataList();

  @override
  Widget build(BuildContext context) {
    final double balanceTotal = sumAccountDataPrimaryAmount(items);
    final Widget view = FinancialEntityView(
      heroLabel: 'Total',
      heroAmount: balanceTotal,
      segments: buildSegmentsFromAccountItems(items),
      wholeAmount: balanceTotal,
      financialEntityCards: buildAccountDataListViews(items),
    );
    return AdaptiveLayout(
      mobile: view,
      desktop: Row(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: view,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: RallyColors.inputBackground,
            ),
          ),
        ],
      ),
    );
  }
}
