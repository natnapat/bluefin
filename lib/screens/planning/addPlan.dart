import 'package:bluefin/providers/planProvider.dart';
import 'package:bluefin/screens/planning/calendarScreen.dart';
import 'package:bluefin/screens/planning/widgets/calculator.dart';
import 'package:bluefin/screens/planning/widgets/deadLineBottomSheet.dart';
import 'package:bluefin/screens/transaction/widgets/categorySearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddPlan extends StatefulWidget {
  const AddPlan({Key? key}) : super(key: key);

  @override
  _AddPlanState createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  final _formKey = GlobalKey<FormState>();

  String goalType = "Saving";
  TextEditingController goalAmount = TextEditingController();
  TextEditingController deadLine = TextEditingController();
  TextEditingController incomeAmount = TextEditingController();
  TextEditingController reservedType = TextEditingController();
  TextEditingController reservedAmount = TextEditingController();
  TextEditingController fixedCost = TextEditingController();
  TextEditingController pricePerUnit = TextEditingController();
  TextEditingController unit = TextEditingController();

  List<Map> rules = [];
  int id = 0;
  Map reservedTemp = {'type': 'reserved', 'reservedType': '', 'amount': 0};
  //Map spendTemp = {'type': 'spend', 'spendType': '', 'price': 0, 'unit': 0};

  bool leapYear(int year) {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
  }

  // void initState() {
  //   super.initState();
  //   deadLine.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Add Monthly Plan',
              style: TextStyle(color: Colors.black),
            ),
            actions: [Calculator()],
          ),
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Text("Goal :"),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: DropdownButton<String>(
                          value: goalType,
                          icon: const Icon(AntDesign.arrowdown),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.blue),
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              goalType = newValue!;
                            });
                          },
                          items: <String>['Saving', 'DCA']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 20,
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: TextFormField(
                          controller: goalAmount,
                          decoration: InputDecoration(
                              hintText: "amount",
                              hintStyle: TextStyle(fontSize: 15)),
                        ),
                      )
                    ],
                  ),
                ),

                //Dead Line Row
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 0, top: 10),
                      child: Text("Deadline :"),
                    ),
                    Container(
                      width: 100,
                      height: 20,
                      margin: EdgeInsets.only(left: 10, top: 15),
                      child: TextFormField(
                        controller: deadLine,
                        showCursor: false,
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: "deadline date",
                            hintStyle: TextStyle(fontSize: 15)),
                        onTap: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              context: context,
                              builder: (context) {
                                return DeadLineBottomSheet();
                              }).then((value) {
                            setState(() {
                              if (value != null)
                                deadLine.text =
                                    DateFormat('yyyy-MM-dd').format(value);
                              //print(deadLine.text);
                            });
                          });
                        },
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(deadLine.text.isNotEmpty
                            ? DateTime.parse(deadLine.text)
                                    .difference(DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day))
                                    .inDays
                                    .toString() +
                                ' days left'
                            : '0')),
                  ],
                ),
                // Container(
                //     child: TextButton(onPressed: () {}, child: Text("hello"))),
                //Income Row
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Text("Income :"),
                      ),
                      Container(
                        width: 120,
                        height: 20,
                        margin: EdgeInsets.only(left: 10, top: 25),
                        child: TextFormField(
                          controller: incomeAmount,
                          decoration: InputDecoration(
                              hintText: "amount",
                              hintStyle: TextStyle(fontSize: 15)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text("per month"),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text("Rule (per month)"),
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  children: [
                    Container(
                      child: Text("Reserve:"),
                    ),
                    Container(
                      width: 160,
                      height: 30,
                      margin: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: reservedType,
                        onTap: () async {
                          final result = await showSearch(
                              context: context, delegate: CategorySearch());
                          reservedType.text = result!;
                          print(reservedType.text);
                        },
                        showCursor: false,
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: "Fixed cost",
                            hintStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 20,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: TextFormField(
                        controller: reservedAmount,
                        decoration: InputDecoration(
                            hintText: "amount",
                            hintStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          //print(reservedTemp);
                          reservedTemp['reservedType'] = reservedType.text;
                          reservedTemp['amount'] =
                              double.parse(reservedAmount.text);

                          bool isDuplicateType = false;
                          setState(() {
                            if (reservedTemp['reservedType'] != "Income" &&
                                reservedTemp['reservedType'] != "Salary" &&
                                reservedTemp['amount'] > 0) {
                              for (int i = 0; i < rules.length; i++) {
                                if (rules[i]['reservedType'] ==
                                    reservedTemp['reservedType']) {
                                  isDuplicateType = true;
                                  rules[i]['amount'] += reservedTemp['amount'];
                                  break;
                                }
                              }

                              if (isDuplicateType == false)
                                rules.add(reservedTemp);
                            }
                            reservedTemp = {
                              'type': 'reserved',
                              'reservedType': '',
                              'amount': 0
                            };
                          });

                          print('Reserved type = ${reservedType.text}');
                          print('Reserved Amount = ${reservedAmount.text}');
                          reservedAmount.text = '';
                          reservedType.text = '';
                        },
                        icon: Icon(AntDesign.plus),
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 400,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.withOpacity(0.2))),
                  child: Container(
                    child: ListView.builder(
                      itemCount: rules.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(rules[index]['type'] == 'reserved'
                              ? rules[index]['reservedType'] +
                                  ' ' +
                                  NumberFormat.simpleCurrency(
                                          locale: 'th', decimalDigits: 1)
                                      .format(rules[index]['amount']) +
                                  '/month'
                              : rules[index]['spendType'] +
                                  ' ' +
                                  NumberFormat.simpleCurrency(
                                          locale: 'th', decimalDigits: 1)
                                      .format(rules[index]['price']) +
                                  '/unit' +
                                  ' ' +
                                  rules[index]['unit'].toString() +
                                  ' ' +
                                  'units/day'),
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  rules.removeAt(index);
                                });
                              },
                              icon: Icon(AntDesign.close)),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 140),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          primary: Colors.white,
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        if (goalAmount.text.isEmpty ||
                            deadLine.text.isEmpty ||
                            incomeAmount.text.isEmpty ||
                            rules.isEmpty) {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Saving Error'),
                                    content: const Text("Fill every blank."),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Close'),
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                    ],
                                  ));
                        } else {
                          double expense = 0;
                          for (int i = 0; i < rules.length; i++) {
                            expense += rules[i]['amount'];
                          }
                          print("income = ${incomeAmount.text}");
                          print("expense = ${expense}");
                          if (expense > double.parse(incomeAmount.text)) {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Expense > Income'),
                                      content: const Text(
                                          'Please remove some rule from your spending plan'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Close'),
                                          child: const Text(
                                            'Close',
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                        ),
                                      ],
                                    ));
                          }
                          // else if (double.parse(incomeAmount.text) - expense <
                          //     double.parse(goalAmount.text)) {
                          //   showDialog<String>(
                          //       context: context,
                          //       builder: (BuildContext context) => AlertDialog(
                          //             title: const Text('Saving Error'),
                          //             content: const Text(
                          //                 "Your expense doesn't match with your saving plan. Please remove some rules. "),
                          //             actions: <Widget>[
                          //               TextButton(
                          //                 onPressed: () =>
                          //                     Navigator.pop(context, 'Close'),
                          //                 child: const Text(
                          //                   'Close',
                          //                   style: TextStyle(
                          //                       color: Colors.redAccent),
                          //                 ),
                          //               ),
                          //             ],
                          //           ));
                          // }
                          else {
                            var provider = Provider.of<PlanProvider>(context,
                                listen: false);
                            provider.addPlan(
                                goalType,
                                double.parse(goalAmount.text),
                                double.parse(incomeAmount.text),
                                rules,
                                deadLine.text);
                            print("insert plan");
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CalendarScreen();
                            }));
                          }
                        }
                      },
                      child: Text(
                        'Calculate',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          )),
    );
  }
}
