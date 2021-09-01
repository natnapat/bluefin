import 'package:bluefin/providers/cashTransactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        return Text("hello cash transactions");
      },
    );
  }
}
