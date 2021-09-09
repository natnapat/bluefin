import 'package:bluefin/screens/planning/addPlan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int activeDay = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3)
            ]),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 60, bottom: 25, right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text(
                          "Daily Expense",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddPlan();
                            }));
                          },
                          color: Colors.black45,
                          icon: Icon(
                            AntDesign.plus,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(30, (index) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                activeDay = index;
                              });
                              print(index);
                            },
                            child: Container(
                              width: (size.width - 40) / 7,
                              child: Column(
                                children: [
                                  Text(DateFormat('E').format(DateTime.now())),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: activeDay == index
                                            ? Colors.blue
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: activeDay == index
                                                ? Colors.blue
                                                : Colors.black
                                                    .withOpacity(0.1))),
                                    child: Center(
                                      child: Text(
                                        DateFormat('dd').format(DateTime.now()),
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: activeDay == index
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ));
                      }),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
