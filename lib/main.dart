import 'package:bluefin/screens/history/historyScreen.dart';
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
    return MaterialApp(
      title: "Bluefin",
      home: MyStatefulWidget(),
      theme: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
    );
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
        return Text("hello");
      case 2:
        return HistoryScreen();
      case 3:
        return Text("hello");
      case 4:
        return Text("hello");
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
              label: 'History',
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
