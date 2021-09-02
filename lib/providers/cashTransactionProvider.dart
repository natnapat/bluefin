import 'package:flutter/foundation.dart';
import 'package:bluefin/database/transactionDB.dart';
import 'package:bluefin/models/cashTransactionModel.dart';

class CashTransactionProvider with ChangeNotifier {
  List<CashTransactionModel> cashTrans = [];

  List<CashTransactionModel> getTransactions() {
    return cashTrans;
  }

  void initData() async {
    var db = TransactionDB();
    cashTrans = await db.getCashTransaction(0, "", "", "");
    notifyListeners();
  }

  void cashFilter(
      int type, String? category, String? startDate, String? endDate) async {
    TransactionDB db = TransactionDB();
    cashTrans = await db.getCashTransaction(type, category, startDate, endDate);
    notifyListeners();
  }

  //insert a transaction into database
  void addCashTransaction(CashTransactionModel cashTransactionModel) async {
    var db = TransactionDB();
    await db.insertCashTransaction(cashTransactionModel);
    cashTrans = await db.getCashTransaction(0, "", "", "");
    notifyListeners();
  }

  //delete a transaction in database
  void deleteCashTransaction(int? id) async {
    var db = TransactionDB();
    await db.deleteTransaction(id, 0);
    cashTrans = await db.getCashTransaction(0, "", "", "");
    notifyListeners();
  }
}
