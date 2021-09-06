import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  int marketIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: GestureDetector(
                onTap: () {
                  print("search");
                },
                child: Container(
                  width: 350,
                  padding: EdgeInsets.fromLTRB(12, 5, 5, 5),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(children: [
                    Icon(
                      MaterialCommunityIcons.magnify,
                      color: Colors.grey[500],
                    ),
                    Text(
                      "Search Asset",
                      style: TextStyle(color: Colors.grey[500], fontSize: 14),
                    ),
                  ]),
                ),
              ),
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
                  marketIndex = index;
                },
                tabs: <Widget>[
                  Tab(
                    text: 'Favorite',
                  ),
                  Tab(
                    text: 'Spot',
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[Text("hello1"), Text("hello2")],
            )));
  }
}
