import 'package:bluefin/screens/planning/addPlan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:bluefin/providers/planProvider.dart';
import 'package:provider/provider.dart';
import 'package:dart_date/dart_date.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int? activeMonth = 0;
  int monthIndex = 0;
  //List<Map<String, Object?>> reserved = [];

  void initState() {
    super.initState();
    Provider.of<PlanProvider>(context, listen: false).initData();
    activeMonth = Provider.of<PlanProvider>(context, listen: false)
        .monthlyPlans[0]
        .monthlyPlanID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Consumer(builder: (context, PlanProvider provider, Widget? child) {
      //print(provider.plan);
      if (provider.monthlyPlans.isEmpty) {
        return AddPlan();
      } else {
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
                              "Monthly Expense",
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
                          children: List.generate(provider.monthlyPlans.length,
                              (index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    monthIndex = index;
                                    activeMonth = provider
                                        .monthlyPlans[index].monthlyPlanID;
                                    Provider.of<PlanProvider>(context,
                                            listen: false)
                                        .getReserveMonthly(activeMonth);
                                  });
                                  print(provider.reserved);
                                  print(activeMonth);
                                },
                                child: Container(
                                  width: (size.width - 40) / 7,
                                  child: Column(
                                    children: [
                                      Text(DateFormat('MMM').format(
                                          DateTime.parse(provider
                                              .monthlyPlans[index].startDate
                                              .toString()))),
                                      SizedBox(height: 10),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: activeMonth ==
                                                    provider.monthlyPlans[index]
                                                        .monthlyPlanID
                                                ? Colors.blue
                                                : Colors.transparent,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: activeMonth ==
                                                        provider
                                                            .monthlyPlans[index]
                                                            .monthlyPlanID
                                                    ? Colors.blue
                                                    : Colors.black
                                                        .withOpacity(0.1))),
                                        child: Center(
                                            child: Text(
                                          DateTime.parse(provider
                                                  .monthlyPlans[index].startDate
                                                  .toString())
                                              .getDaysInMonth
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: activeMonth ==
                                                      provider
                                                          .monthlyPlans[index]
                                                          .monthlyPlanID
                                                  ? Colors.white
                                                  : Colors.black),
                                        )),
                                      ),
                                    ],
                                  ),
                                ));
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: Card(
                    elevation: 2,
                    child: SizedBox(
                        width: 360,
                        height: 140,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    //color: Colors.red,
                                    margin: EdgeInsets.only(left: 20, top: 10),
                                    child: Text(
                                      'Saving : ' +
                                          (provider.monthlyPlans[monthIndex]
                                                      .actualIncome -
                                                  provider
                                                      .monthlyPlans[monthIndex]
                                                      .actualExpense)
                                              .toStringAsFixed(2) +
                                          ' / ' +
                                          provider
                                              .monthlyPlans[monthIndex].saving
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text(
                                        "Income :",
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 16),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(left: 20, top: 10),
                                    child: Text(
                                      provider.monthlyPlans[monthIndex]
                                              .actualIncome
                                              .toStringAsFixed(2) +
                                          ' / ' +
                                          provider
                                              .monthlyPlans[monthIndex].income
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                          //color: Colors.redAccent,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text(
                                        "Expense :",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 16),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(left: 20, top: 10),
                                    child: Text(
                                      (provider.monthlyPlans[monthIndex]
                                                      .actualExpense *
                                                  -1)
                                              .toStringAsFixed(2) +
                                          ' / ' +
                                          (provider.monthlyPlans[monthIndex]
                                                      .expense *
                                                  -1)
                                              .toStringAsFixed(2),
                                    ),
                                  ),
                                ],
                              ),
                              Row(children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    "Start:",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    DateFormat('yyyy-MM-dd').format(
                                        DateTime.parse(provider
                                            .monthlyPlans[monthIndex]
                                            .startDate)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    "End:",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, top: 10),
                                  child: Text(
                                    DateFormat('yyyy-MM-dd').format(
                                        DateTime.parse(provider
                                            .monthlyPlans[monthIndex].endDate)),
                                  ),
                                ),
                              ])
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
