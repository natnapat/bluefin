import 'package:bluefin/screens/transaction/widgets/categorySearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bluefin/providers/cashTransactionProvider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({Key? key}) : super(key: key);

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController categoryFilterController = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  int dateRangeType = 0;
  int filterType = 0;
  Color allButtonColor = Colors.amber;
  Color incomeButtonColor = Colors.transparent;
  Color expenseButtonColor = Colors.transparent;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  "Transaction Filter",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              child: Text(
                "Type",
                style: TextStyle(fontSize: 18, color: Colors.black38),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: allButtonColor,
                            splashFactory: NoSplash.splashFactory),
                        autofocus: false,
                        onPressed: () {
                          setState(() {
                            filterType = 0;
                            allButtonColor = Colors.amber;
                            incomeButtonColor = Colors.transparent;
                            expenseButtonColor = Colors.transparent;
                            print("select all");
                          });
                        },
                        child: Text("All",
                            style: TextStyle(
                                color: filterType == 0
                                    ? Colors.white
                                    : Colors.black))),
                  )),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: incomeButtonColor,
                            splashFactory: NoSplash.splashFactory),
                        onPressed: () {
                          setState(() {
                            filterType = 1;
                            allButtonColor = Colors.transparent;
                            incomeButtonColor = Colors.amber;
                            expenseButtonColor = Colors.transparent;
                            print("select income");
                          });
                        },
                        child: Text("Income",
                            style: TextStyle(
                                color: filterType == 1
                                    ? Colors.white
                                    : Colors.black))),
                  )),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: expenseButtonColor,
                            splashFactory: NoSplash.splashFactory),
                        onPressed: () {
                          setState(() {
                            filterType = 2;
                            allButtonColor = Colors.transparent;
                            incomeButtonColor = Colors.transparent;
                            expenseButtonColor = Colors.amber;
                            print("select expense");
                          });
                        },
                        child: Text(
                          "Expense",
                          style: TextStyle(
                              color: filterType == 2
                                  ? Colors.white
                                  : Colors.black),
                        )),
                  )),
                ],
              ),
            ),
            Container(
              child: TextFormField(
                controller: categoryFilterController,
                onTap: () async {
                  final result = await showSearch(
                      context: context, delegate: CategorySearch());
                  categoryFilterController.text = result!;
                },
                showCursor: false,
                readOnly: true,
                //keyboardType: TextInputType.text,
                //cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Category",
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: startDate,
                      showCursor: false,
                      readOnly: true,
                      onTap: () async {
                        setState(() {
                          dateRangeType = 0;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "start date",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: endDate,
                      showCursor: false,
                      readOnly: true,
                      onTap: () async {
                        setState(() {
                          dateRangeType = 1;
                        });
                      },
                      validator: (str) {
                        if (startDate.text.isNotEmpty) {
                          if (DateTime.parse(str!)
                              .isBefore(DateTime.parse(startDate.text)))
                            return "invalid";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "end date",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Container(
              height: 150,
              child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  maximumDate: DateTime(date.year, date.month, date.day + 1),
                  onDateTimeChanged: (val) {
                    setState(() {
                      if (dateRangeType == 0)
                        startDate.text = val.toString();
                      else
                        endDate.text = val.toString();
                    });
                  }),
            ),
            Container(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          primary: Colors.white,
                          backgroundColor: Colors.amberAccent),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("filtered");
                          var provider = Provider.of<CashTransactionProvider>(
                              context,
                              listen: false);
                          provider.cashFilter(
                              filterType,
                              categoryFilterController.text,
                              startDate.text,
                              endDate.text);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Filter',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
