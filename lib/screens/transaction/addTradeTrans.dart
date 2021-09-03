import 'package:bluefin/screens/transaction/widgets/categorySearch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:bluefin/providers/tradeTransactionProvider.dart';
import 'package:bluefin/models/tradeTransactionModel.dart';

class AddTradeTrans extends StatefulWidget {
  const AddTradeTrans({Key? key}) : super(key: key);

  @override
  _AddTradeTransState createState() => _AddTradeTransState();
}

class _AddTradeTransState extends State<AddTradeTrans> {
  final _formKey = GlobalKey<FormState>();

  final tradeTitleController = TextEditingController();
  var tradeAmountController = TextEditingController();
  var tradePriceController = TextEditingController();
  var tradeDateController = TextEditingController();
  var tradeTotalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: tradeTitleController,
                    onTap: () async {
                      final result = await showSearch(
                          context: context,
                          delegate: CategorySearch(transIndex: 1));
                      tradeTitleController.text = result!;
                    },
                    autofocus: false,
                    readOnly: true,
                    showCursor: false,
                    validator: (str) {
                      if (str == null || str.isEmpty) return "required";
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Asset Name',
                        labelStyle: TextStyle(color: Colors.black),
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
                      controller: tradeDateController,
                      type: DateTimePickerType.dateTime,
                      dateMask: 'dd/MM/yyyy - HH:mm',
                      use24HourFormat: true,
                      decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'ex. 3000, -200',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber))),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
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
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: tradeAmountController,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      if (double.tryParse(value) != null &&
                          double.tryParse(tradePriceController.text) != null) {
                        var total = double.parse(value) *
                            double.parse(tradePriceController.text);
                        tradeTotalController.text = total.toString();
                      }
                    },
                    validator: (str) {
                      if (str == null || str.isEmpty) return "required";
                      return null;
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
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    controller: tradePriceController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      if (double.tryParse(value) != null &&
                          double.tryParse(tradeAmountController.text) != null) {
                        var total = double.parse(value) *
                            double.parse(tradeAmountController.text);
                        tradeTotalController.text = total.toString();
                      }
                    },
                    validator: (str) {
                      if (str == null || str.isEmpty) return "required";
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Price (THB)',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: '',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    controller: tradeTotalController,
                    keyboardType: TextInputType.text,
                    enabled: false,
                    autofocus: true,
                    cursorColor: Colors.black,
                    validator: (str) {
                      if (str == null || str.isEmpty) return "required";
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Total',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: '',
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var tradeTitle = tradeTitleController.text;
                          var tradeAmount = tradeAmountController.text;
                          var tradeDate = tradeDateController.text;
                          var tradePrice = tradePriceController.text;
                          var tradeTotal = tradeTotalController.text;
                          //print(date);
                          TradeTransactionModel statement =
                              TradeTransactionModel(
                                  tradeTitle: tradeTitle,
                                  tradeDate:
                                      DateTime.parse(tradeDate).toString(),
                                  tradeAmount: double.parse(tradeAmount),
                                  tradePrice: double.parse(tradePrice),
                                  tradeTotal: double.parse(tradeTotal));

                          var provider = Provider.of<TradeTransactionProvider>(
                              context,
                              listen: false);
                          provider.addTradeTransaction(statement);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Add Trade',
                        style: TextStyle(color: Colors.black),
                      )),
                )
              ],
            ),
          )),
    );
  }
}
