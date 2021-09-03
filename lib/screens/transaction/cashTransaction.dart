import 'package:bluefin/models/cashTransactionModel.dart';
import 'package:bluefin/providers/cashTransactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';

class CashTransaction extends StatefulWidget {
  const CashTransaction({Key? key}) : super(key: key);

  @override
  _CashTransactionState createState() => _CashTransactionState();
}

class _CashTransactionState extends State<CashTransaction> {
  @override
  void initState() {
    super.initState();
    Provider.of<CashTransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, CashTransactionProvider provider, Widget? child) {
        int count = provider.cashTrans.length;
        if (count <= 0) {
          return Center(
            child: Text("No Transaction"),
          );
        } else {
          return ListView.builder(
              itemCount: count,
              itemBuilder: (context, int dataIndex) {
                CashTransactionModel data = provider.cashTrans[dataIndex];
                return Dismissible(
                  key: Key(data.id.toString()),
                  onDismissed: (direction) {
                    var provider = Provider.of<CashTransactionProvider>(context,
                        listen: false);
                    provider.deleteCashTransaction(data.id, 0);
                  },
                  direction: DismissDirection.endToStart,
                  background: Container(
                      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
                      color: Colors.redAccent,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            MaterialCommunityIcons.filter_outline,
                          ))),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      margin: EdgeInsets.all(0),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Text(
                                      data.title,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  )),
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      NumberFormat.simpleCurrency(locale: 'th')
                                          .format(data.amount),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                          child: Text(
                                    DateFormat('dd-MM-yyyy HH:mm')
                                        .format(DateTime.parse(data.timestamp)),
                                    style: TextStyle(color: Colors.black45),
                                  ))),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(right: 4),
                                    width: 8.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: data.amount > 0
                                          ? Colors.green
                                          : Colors.redAccent,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(data.category,
                                        style:
                                            TextStyle(color: Colors.black45)),
                                  )
                                ],
                              )
                            ],
                          ))),
                );
              });
        }
      },
    );
  }
}
