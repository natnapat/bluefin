import 'package:bluefin/screens/transaction/widgets/categorySearch.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:bluefin/models/cashTransactionModel.dart';
import 'package:bluefin/providers/cashTransactionProvider.dart';
import 'package:bluefin/providers/planProvider.dart';
import 'package:provider/provider.dart';
import 'package:bluefin/database/planDB.dart';
import 'package:bluefin/models/monthlyPlanModel.dart';
import 'package:dart_date/dart_date.dart';
//import 'package:bluefin/functions/autoCategory.dart';

class AddCashTrans extends StatefulWidget {
  const AddCashTrans({Key? key}) : super(key: key);

  @override
  _AddCashTransState createState() => _AddCashTransState();
}

class _AddCashTransState extends State<AddCashTrans> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  var amountController = TextEditingController();
  var timestampController = TextEditingController();
  var categoryController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, PlanProvider provider, Widget? child) {
      return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Container(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
              color: Colors.white,
              child: Column(children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Focus(
                    // onFocusChange: (value) {
                    //   categoryController.text =
                    //       autoCategory(titleController.text);
                    // },
                    child: TextFormField(
                      controller: titleController,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      validator: (str) {
                        if (str == null || str.isEmpty) return "required";
                        if (str.length > 25) return "too long";
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'ex. salary, buy coffee, Mcdonald',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber))),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    cursorColor: Colors.black,
                    validator: (str) {
                      if (str == null || str.isEmpty) return "required";
                      if (str.startsWith('+') ||
                          str.startsWith('-') ||
                          str.startsWith(new RegExp(r'[0-9]'))) return null;
                      return "only +,- sign";
                    },
                    decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'ex. 3000, -200',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber))),
                  ),
                ),
                Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(primary: Colors.amber),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: DateTimePicker(
                      controller: timestampController,
                      type: DateTimePickerType.dateTime,
                      dateMask: 'dd/MM/yyyy - HH:mm',
                      use24HourFormat: true,
                      decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'ex. 2021/09/04',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber))),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                      initialEntryMode: DatePickerEntryMode.input,
                      dateLabelText: 'Date',
                      validator: (str) {
                        if (str!.isEmpty ||
                            DateTime.parse(str).isAfter(DateTime.now()))
                          return "invalid";
                        return null;
                      },
                      onChanged: (val) {
                        print(val);
                      },
                      onSaved: (val) => print(val),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    controller: categoryController,
                    showCursor: false,
                    readOnly: true,
                    validator: (str) {
                      if (str == null || str.isEmpty) return "required";
                      return null;
                    },
                    onTap: () async {
                      final result = await showSearch(
                          context: context, delegate: CategorySearch());
                      //delegate: CategorySearch(transIndex: 0));
                      categoryController.text = result!;
                    },
                    decoration: InputDecoration(
                        labelText: 'Category',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'ex. income, food, drink, utility ',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          primary: Colors.white,
                          backgroundColor: Colors.amberAccent),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var title = titleController.text;
                          var amount = amountController.text;
                          var timestamp = timestampController.text;
                          var category = categoryController.text;
                          //print(date);
                          // Provider.of<PlanProvider>(context, listen: false)
                          //     .getMonthlyPlanID(timestamp);
                          int monthID = 0;
                          PlanDB db = PlanDB();
                          List<MonthlyPlanModel> monthlyPlans =
                              await db.getAllMonthlyPlan();
                          for (int i = 0; i < monthlyPlans.length; i++) {
                            if (DateTime.parse(timestamp).isWithinRange(
                                DateTime.parse(monthlyPlans[i].startDate),
                                DateTime.parse(monthlyPlans[i].endDate))) {
                              //print(monthlyPlans[i].monthlyPlanID);
                              monthID = monthlyPlans[i].monthlyPlanID!.toInt();
                              break;
                            }
                          }
                          print(monthID);
                          CashTransactionModel statement = CashTransactionModel(
                              title: title,
                              amount: double.parse(amount),
                              timestamp: DateTime.parse(timestamp).toString(),
                              category: category,
                              monthlyPlanID: monthID);

                          var cashProvider =
                              Provider.of<CashTransactionProvider>(context,
                                  listen: false);
                          cashProvider.addCashTransaction(statement);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Add Transaction',
                        style: TextStyle(color: Colors.black),
                      )),
                )
              ]),
            ),
          ));
    });
  }
}
