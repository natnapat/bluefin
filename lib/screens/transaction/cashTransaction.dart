import 'package:bluefin/models/cashTransactionModel.dart';
import 'package:bluefin/providers/cashTransactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                return Text(DateFormat('dd/MM/yyyy HH:mm')
                    .format(DateTime.parse(data.timestamp))
                    .toString());
              });
        }
      },
    );
  }
}
