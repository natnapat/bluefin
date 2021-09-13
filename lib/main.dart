import 'package:bluefin/providers/cashTransactionProvider.dart';
import 'package:bluefin/providers/planProvider.dart';
import 'package:bluefin/providers/tradeTransactionProvider.dart';
import 'package:bluefin/providers/walletProvider.dart';

import 'package:bluefin/screens/market/MarketScreen.dart';
import 'package:bluefin/screens/planning/PlanningScreen.dart';
import 'package:bluefin/screens/planning/calendarScreen.dart';
import 'package:bluefin/screens/transaction/TransactionScreen.dart';
import 'package:bluefin/screens/wallet/WalletScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

void main() {
  runApp(MyApp());
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            return CashTransactionProvider();
          }),
          ChangeNotifierProvider(create: (context) {
            return TradeTransactionProvider();
          }),
          ChangeNotifierProvider(create: (context) {
            return PlanProvider();
          }),
          ChangeNotifierProvider(create: (context) {
            return WalletProvider();
          })
        ],
        child: MaterialApp(
          title: "Bluefin",
          home: MyStatefulWidget(),
          theme: ThemeData(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              canvasColor: Colors.grey[200],
              bottomSheetTheme:
                  BottomSheetThemeData(backgroundColor: Colors.white)),
        ));
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedPage = 0;

  pageSelect() {
    switch (this._selectedPage) {
      case 0:
        return Text("hello");
      case 1:
        return MarketScreen();
      case 2:
        return TransactionScreen();
      case 3:
        return WalletScreen();
      case 4:
        return CalendarScreen();
      default:
        return Center(
          child: Text('No Page Found'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: pageSelect(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.home_outline),
              label: 'Overview',
            ),
            BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.chart_line),
              label: 'Markets',
            ),
            BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.update),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.wallet_outline),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.calendar_blank),
              label: 'Plan',
            ),
          ],
          currentIndex: _selectedPage,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          onTap: (int tappedIndex) {
            setState(() {
              this._selectedPage = tappedIndex;
            });
          },
        ),
      ),
    );
  }
}
