import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bluefin/models/cashTransactionModel.dart';
import 'package:bluefin/models/tradeTransactionModel.dart';

class TransactionDB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    print("database: $path");
    return openDatabase(join(path, "bluefin.db"));
  }

  Future<List<CashTransactionModel>> getCashTransaction(
      int type, String? category, String? startDate, String? endDate) async {
    Database db = await initDB();
    List<Map<String, Object?>> datas = [];

    print(type);
    print(category);
    print(startDate);

    if (type == 0) {
      if (category == "") {
        if (startDate == "") {
          print("hello null");
          datas = await db.query("cashTransaction");
        } else {
          datas = await db.rawQuery(
              'SELECT * FROM cashTransaction WHERE timestamp BETWEEN ? and ?',
              [startDate, endDate]);
        }
      } else {
        datas = await db.rawQuery(
            'SELECT * FROM cashTransaction WHERE category = ?', [category]);
      }
    } else if (type == 1) {
      if (category == "") {
        if (startDate == "") {
          datas = await db
              .rawQuery('SELECT * FROM cashTransaction WHERE amount > ?', [0]);
        } else {
          datas = await db.rawQuery(
              'SELECT * FROM cashTransaction WHERE amount > 0 AND timestamp BETWEEN ? and ?',
              [startDate, endDate]);
        }
      } else {
        datas = await db.rawQuery(
            'SELECT * FROM cashTransaction WHERE amount > 0 AND category = ?',
            [category]);
      }
    } else if (type == 2) {
      if (category == "") {
        if (startDate == "") {
          datas = await db
              .rawQuery('SELECT * FROM cashTransaction WHERE amount < ?', [0]);
        } else {
          datas = await db.rawQuery(
              'SELECT * FROM cashTransaction WHERE amount < 0 AND timestamp BETWEEN ? and ?',
              [startDate, endDate]);
        }
      } else {
        datas = await db.rawQuery(
            'SELECT * FROM cashTransaction WHERE amount < 0 AND category = ?',
            [category]);
      }
    }
    //print(datas);
    return datas.map((e) => CashTransactionModel.fromMap(e)).toList();
  }

  Future<List<TradeTransactionModel>> getTradeTransaction(
      int type, String? asset, String? startDate, String? endDate) async {
    Database db = await initDB();
    List<Map<String, Object?>> datas = [];

    print(type);
    print(asset);
    print(startDate);

    if (type == 0) {
      if (asset == "") {
        if (startDate == "") {
          print("hello null");
          datas = await db.query("tradeTransaction");
        } else {
          datas = await db.rawQuery(
              'SELECT * FROM tradeTransaction WHERE tradeDate BETWEEN ? and ?',
              [startDate, endDate]);
        }
      } else {
        datas = await db.rawQuery(
            'SELECT * FROM tradeTransaction WHERE tradeTitle = ?', [asset]);
      }
    } else if (type == 1) {
      if (asset == "") {
        if (startDate == "") {
          datas = await db.rawQuery(
              'SELECT * FROM tradeTransaction WHERE tradeAmount > ?', [0]);
        } else {
          datas = await db.rawQuery(
              'SELECT * FROM tradeTransaction WHERE tradeAmount > 0 AND tradeDate BETWEEN ? and ?',
              [startDate, endDate]);
        }
      } else {
        datas = await db.rawQuery(
            'SELECT * FROM tradeTransaction WHERE tradeAmount > 0 AND tradeTitle = ?',
            [asset]);
      }
    } else if (type == 2) {
      if (asset == "") {
        if (startDate == "") {
          datas = await db.rawQuery(
              'SELECT * FROM tradeTransaction WHERE tradeAmount < ?', [0]);
        } else {
          datas = await db.rawQuery(
              'SELECT * FROM tradeTransaction WHERE tradeAmount < 0 AND tradeDate BETWEEN ? and ?',
              [startDate, endDate]);
        }
      } else {
        datas = await db.rawQuery(
            'SELECT * FROM tradeTransaction WHERE tradeAmount < 0 AND tradeTitle = ?',
            [asset]);
      }
    }
    //print(datas);
    return datas.map((e) => TradeTransactionModel.fromMap(e)).toList();
  }

  Future<void> insertCashTransaction(
      CashTransactionModel cashTransaction) async {
    Database db = await initDB();
    await db.insert("cashTransaction", cashTransaction.toMap());
  }

  Future<void> insertTradeTransaction(
      TradeTransactionModel tradeTransaction) async {
    Database db = await initDB();
    await db.insert("tradeTransaction", tradeTransaction.toMap());
  }

  Future<void> deleteTransaction(int? id, int transactionType) async {
    Database db = await initDB();
    if (transactionType == 0) {
      await db.delete("cashTransaction", where: "id=?", whereArgs: [id]);
      print("delete cash transaction at index $id");
    } else if (transactionType == 1) {
      await db.delete("tradeTransaction", where: "tradeID=?", whereArgs: [id]);
      print("delete trade transaction at index $id");
    }
  }
}
