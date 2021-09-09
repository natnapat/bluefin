import 'package:bluefin/screens/planning/widgets/calculator.dart';
import 'package:bluefin/screens/transaction/widgets/categorySearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';

class AddPlan extends StatefulWidget {
  const AddPlan({Key? key}) : super(key: key);

  @override
  _AddPlanState createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  final _formKey = GlobalKey<FormState>();

  String goalType = "Saving";
  TextEditingController goalAmount = TextEditingController();
  TextEditingController incomeAmount = TextEditingController();
  TextEditingController reservedType = TextEditingController();
  TextEditingController reservedAmount = TextEditingController();
  TextEditingController fixedCost = TextEditingController();
  TextEditingController pricePerUnit = TextEditingController();
  TextEditingController unit = TextEditingController();

  List<Map> rules = [];
  int id = 0;
  Map reservedTemp = {'type': 'reserved', 'reservedType': '', 'amount': 0};
  Map spendTemp = {'type': 'spend', 'spendType': '', 'price': 0, 'unit': 0};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'Add Plan',
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
                          items: <String>['Saving', 'DCA', 'Budget']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        width: 70,
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
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Text("Income :"),
                      ),
                      Container(
                        width: 90,
                        height: 20,
                        margin: EdgeInsets.only(left: 10, top: 20),
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
                  child: Text("Rule"),
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  children: [
                    Container(
                      child: Text("Reserved for "),
                    ),
                    Container(
                      width: 125,
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
                          //{'type': 'reserved', 'reservedType': '', 'amount': 0}
                          reservedTemp['reservedType'] = reservedType.text;
                          reservedTemp['amount'] =
                              double.parse(reservedAmount.text);
                          print(reservedTemp);
                          setState(() {
                            rules.add(reservedTemp);
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
                Row(
                  children: [
                    Container(
                      child: Text("Spend"),
                    ),
                    Container(
                      width: 120,
                      height: 30,
                      margin: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: fixedCost,
                        onTap: () async {
                          final result = await showSearch(
                              context: context, delegate: CategorySearch());
                          fixedCost.text = result!;
                        },
                        showCursor: false,
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: "Fixed cost",
                            hintStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 20,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: TextFormField(
                        controller: pricePerUnit,
                        decoration: InputDecoration(
                            hintText: "price",
                            hintStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 20,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: TextFormField(
                        controller: unit,
                        onChanged: (str) {
                          unit.text = str;
                        },
                        decoration: InputDecoration(
                            hintText: "unit",
                            hintStyle: TextStyle(fontSize: 15)),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          //{'type': 'spend', 'price': 0, 'unit': 0};
                          spendTemp['spendType'] = fixedCost.text;
                          spendTemp['price'] = double.parse(pricePerUnit.text);
                          spendTemp['unit'] = int.parse(unit.text);
                          print(spendTemp);
                          setState(() {
                            rules.add(spendTemp);
                            spendTemp = {
                              'type': 'spend',
                              'price': 0,
                              'unit': 0
                            };
                          });

                          fixedCost.text = '';
                          pricePerUnit.text = '';
                          unit.text = '';
                        },
                        icon: Icon(AntDesign.plus),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 400,
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
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
                        double expense = 0;
                        for (int i = 0; i < rules.length; i++) {
                          if (rules[i]['type'] == 'reserved') {
                            expense += rules[i]['amount'];
                          } else {
                            expense += rules[i]['price'] * rules[i]['unit'];
                          }
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
                        if (goalType == 'Saving') {
                          if (double.parse(incomeAmount.text) - expense <
                              double.parse(goalAmount.text)) {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Saving Error'),
                                      content: const Text(
                                          "Your expense doesn't match with your saving plan. Please remove some rules. "),
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
