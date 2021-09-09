import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PlanDB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    //print("database: $path");
    return openDatabase(join(path, "bluefin.db"));
  }

  Future<void> insertPlan(String goalType, double goalAmount, double income,
      List<Map> rules) async {
    Database db = await initDB();
    DateTime now = DateTime.now();
    DateTime nextmonth = DateTime(now.year, now.month + 1, now.day);
    int planID = await db.rawInsert(
        'INSERT INTO plan(goalType,amount,income,startDate,endDate) VALUES(?,?,?,?,?)',
        [goalType, goalAmount, income, now.toString(), nextmonth.toString()]);

    for (int i = 0; i < rules.length; i++) {
      if (rules[i]['type'] == 'reserved') {
        await db.rawInsert(
            'INSERT INTO reserve(planID,reservedType,reservedAmount,actualAmount,checked) VALUES(?,?,?,?,?)',
            [planID, rules[i]['reservedType'], rules[i]['amount'], 0]);
      }
      // else if (rules[i]['type'] == 'spend') {
      //   await db.rawInsert(
      //       'INSERT INTO spend(planID,spendType,pricePerUnit,unit,actualUnit,actualCost) VALUES(?,?,?,?,?,?)',
      //       [
      //         planID,
      //         rules[i]['spendType'],
      //         rules[i]['price'],
      //         rules[i]['unit'],
      //         0,
      //         0,
      //         0
      //       ]);
      // }
    }
  }

  Future<List<Map<String, Object?>>> getPlan() async {
    Database db = await initDB();
    List<Map<String, Object?>> plan =
        await db.rawQuery('SELECT * FROM plan ORDER BY planID DESC LIMIT 1');
    return plan;
  }

  Future<List<Map<String, Object?>>> getReserved(int planID) async {
    Database db = await initDB();
    List<Map<String, Object?>> reserved =
        await db.rawQuery('SELECT * FROM reserve WHERE planID = ?', [planID]);
    return reserved;
  }

  // Future<List<Map<String, Object?>>> getSpend(int planID) async {
  //   Database db = await initDB();
  //   List<Map<String, Object?>> spend =
  //       await db.rawQuery('SELECT * FROM spend WHERE planID = ?', [planID]);
  //   return spend;
  // }

  Future<void> checked(int rid) async {
    Database db = await initDB();
    List<Map<String, Object?>> check =
        await db.rawQuery('SELECT checked FROM reserve WHERE rid = ?', [rid]);
    if (int.parse(check[0]['checked'].toString()) == 0) {
      await db.rawUpdate('UPDATE reserve SET checked = 1 WHERE rid = ?', [rid]);
    } else {
      await db.rawUpdate('UPDATE reserve SET checked = 0 WHERE rid = ?', [rid]);
    }
  }

  Future<double> getExpense(String startDate, String endDate) async {
    double expense = 0;
    Database db = await initDB();
    List<Map<String, Object?>> transactions = await db.rawQuery(
        'SELECT * FROM cashTransaction WHERE amount < 0 AND timestamp BETWEEN ? and ?',
        [startDate, endDate]);
    for (int i = 0; i < transactions.length; i++) {
      expense += double.parse(transactions[i]['amount'].toString());
    }
    return expense;
  }
}
