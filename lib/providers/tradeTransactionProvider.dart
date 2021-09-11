import 'package:flutter/foundation.dart';
import 'package:bluefin/database/transactionDB.dart';
import 'package:bluefin/models/tradeTransactionModel.dart';

class TradeTransactionProvider with ChangeNotifier {
  List<TradeTransactionModel> tradeTrans = [];

  List<TradeTransactionModel> getTransactions() {
    return tradeTrans;
  }

  void initData() async {
    var db = TransactionDB();
    tradeTrans = await db.getTradeTransaction(0, "", "", "");
    notifyListeners();
  }

  void tradeFilter(
      int type, String? asset, String? startDate, String? endDate) async {
    TransactionDB db = TransactionDB();
    tradeTrans = await db.getTradeTransaction(type, asset, startDate, endDate);
    notifyListeners();
  }

  //insert a transaction into database
  void addTradeTransaction(TradeTransactionModel tradeTransactionModel) async {
    var db = TransactionDB();
    await db.insertTradeTransaction(tradeTransactionModel);
    tradeTrans = await db.getTradeTransaction(0, "", "", "");
    notifyListeners();
  }

  //delete a transaction in database
  void deleteTradeTransaction(int? id, int type) async {
    var db = TransactionDB();
    await db.deleteTransaction(id, type, "", 0);
    tradeTrans = await db.getTradeTransaction(0, "", "", "");
    notifyListeners();
  }
}
