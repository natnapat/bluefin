import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Center(
                child: Text(
              "History",
              style: TextStyle(color: Colors.black),
            )),
            leading: IconButton(
                onPressed: () {},
                color: Colors.black45,
                icon: Icon(
                  MaterialCommunityIcons.plus,
                )),
            actions: [
              IconButton(
                onPressed: () {},
                //highlightColor: Colors.transparent,
                //splashColor: Colors.transparent,
                color: Colors.black45,
                icon: Icon(
                  MaterialCommunityIcons.filter_outline,
                ),
              ),
              IconButton(
                onPressed: () {},
                color: Colors.black45,
                icon: Icon(
                  MaterialCommunityIcons.calendar_blank_outline,
                ),
              )
            ],
            bottom: TabBar(
              unselectedLabelColor: Colors.black45,
              labelColor: Colors.black,
              indicatorColor: Colors.amber,
              indicatorSize: TabBarIndicatorSize.label,
              overlayColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return Colors.transparent;
              }),
              onTap: (index) {
                index = index;
              },
              tabs: <Widget>[
                Tab(
                  text: 'Cash',
                ),
                Tab(
                  text: 'Trades',
                )
              ],
            ),
          ),
        ));
  }
}
