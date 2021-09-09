import 'package:bluefin/providers/planProvider.dart';
import 'package:bluefin/screens/planning/addPlan.dart';
import 'package:bluefin/screens/transaction/addCashTrans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({Key? key}) : super(key: key);

  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  void initState() {
    super.initState();
    Provider.of<PlanProvider>(context, listen: false).initData();
  }

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, PlanProvider provider, Widget? child) {
      return Container(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Monthly Plan",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddPlan();
                  }));
                },
                icon: Icon(AntDesign.plus),
                color: Colors.black,
              )
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Card(
                      child: SizedBox(
                          width: 360,
                          height: 130,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(left: 20, top: 10),
                                        child: Text(
                                          provider.plan[0]['goalType']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(left: 20, top: 10),
                                        child: Text(
                                            provider.plan[0]['amount']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w300)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 20, top: 10),
                                            child: Text(
                                              "Income :",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 16),
                                            ))),
                                    Expanded(
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(left: 20, top: 10),
                                        child: Text(
                                          provider.plan[0]['income'].toString(),
                                          style: TextStyle(
                                              //color: Colors.redAccent,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 20, top: 10),
                                            child: Text(
                                              "Expense :",
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 16),
                                            ))),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text(
                                        (provider.expense * -1).toString(),
                                        style: TextStyle(
                                            //color: Colors.redAccent,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 5, top: 10, right: 60),
                                      child: Text(
                                        '/ ' +
                                            (double.parse(provider.plan[0]
                                                            ['income']
                                                        .toString()) -
                                                    double.parse(provider
                                                        .plan[0]['amount']
                                                        .toString()))
                                                .toString(),
                                        style: TextStyle(
                                            //color: Colors.redAccent,
                                            fontSize: 16),
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
                                      DateFormat('dd-MM-yyyy').format(
                                          DateTime.parse(provider.plan[0]
                                                  ['startDate']
                                              .toString())),
                                      style: TextStyle(color: Colors.black45),
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
                                      DateFormat('dd-MM-yyyy').format(
                                          DateTime.parse(provider.plan[0]
                                                  ['endDate']
                                              .toString())),
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ),
                                ])
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Card(
                    child: SizedBox(
                      width: 360,
                      height: 520,
                      child: Container(
                        child: ListView.builder(
                          itemCount: provider.reserved.length,
                          itemBuilder: (context, index) {
                            if (provider.reserved[index]['checked']
                                    .toString() ==
                                '0')
                              checked = false;
                            else
                              checked = true;
                            return ListTile(
                              leading: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () {
                                    var provider = Provider.of<PlanProvider>(
                                        context,
                                        listen: false);
                                    provider.setChecked(int.parse(provider
                                        .reserved[index]['rid']
                                        .toString()));
                                    setState(() {
                                      provider.initData();
                                    });
                                  },
                                  icon: Icon(
                                    AntDesign.checkcircle,
                                    color: checked == true
                                        ? Colors.green
                                        : Colors.grey,
                                    size: 20,
                                  )),
                              title: Text(provider.reserved[index]
                                      ['reservedType']
                                  .toString()),
                              trailing: Text(provider.reserved[index]
                                          ['reservedAmount']
                                      .toString() +
                                  '     ' +
                                  provider.reserved[index]['reservedType']
                                      .toString()),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
