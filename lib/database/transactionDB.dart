import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bluefin/models/cashTransactionModel.dart';
import 'package:bluefin/models/tradeTransactionModel.dart';

class TransactionDB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    //print("database: $path");
    return openDatabase(join(path, "bluefin.db"));
  }

  Future<List<CashTransactionModel>> getCashTransaction() async {
    Database db = await initDB();
    List<Map<String, Object?>> datas = await db.query("cashTransaction");
    return datas.map((e) => CashTransactionModel.fromMap(e)).toList();
  }

  Future<void> insertCashTransaction(
      CashTransactionModel cashTransaction) async {
    Database db = await initDB();
    await db.insert("cashTransaction", cashTransaction.toMap());
  }

  Future<void> deleteTransaction(int? id, int transactionType) async {
    Database db = await initDB();
    if (transactionType == 0) {
      await db.delete("cashTransaction", where: "id=?", whereArgs: [id]);
      print("delete cash transaction at index $id");
    } else if (transactionType == 1) {
      await db.delete("tradeTransaction", where: "id=?", whereArgs: [id]);
      print("delete trade transaction at index $id");
    }
  }
}
