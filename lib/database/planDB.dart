import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:dart_date/dart_date.dart';
import 'package:bluefin/models/monthlyPlanModel.dart';

class PlanDB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, "bluefin.db"));
  }

  //insert new plan (called when calculate button is onpressed)
  Future<void> insertPlan(String goalType, double goalAmount, double income,
      List<Map> rules, String deadLine) async {
    Database db = await initDB();
    String now = DateFormat('yyyy-MM-dd').format(DateTime.now());

    //add new plan
    int planID = await db.rawInsert(
        'INSERT INTO plan(goalType,amount,startDate,endDate,isPast) VALUES(?,?,?,?,?)',
        [goalType, goalAmount, now, deadLine, 0]);

    //add monthly Plan
    List monthly = [];
    DateTime start = DateTime.parse(now);
    DateTime end = DateTime.parse(deadLine);

    print(start);
    print(deadLine);
    monthly.add([start.toString(), start.endOfMonth.toString()]);
    if (start.getMonth != end.getMonth) {
      while (start.nextMonth.getMonth != end.getMonth) {
        start = start.addMonths(1);
        monthly
            .add([start.startOfMonth.toString(), start.endOfMonth.toString()]);
      }
      //print(start);
      monthly.add([end.startOfMonth.toString(), end.toString()]);
    }
    print(monthly);
    double saving = (goalAmount / monthly.length).roundToDouble();
    for (int i = 0; i < monthly.length; i++) {
      if (monthly[i][0] != monthly[i][1]) {
        int monthlyPlanID = await db.rawInsert(
            'INSERT INTO monthlyPlan(PlanID,saving,startDate,endDate,isPast,income,actualIncome,expense,actualExpense) VALUES(?,?,?,?,?,?,?,?,?)',
            [
              planID,
              saving,
              monthly[i][0],
              monthly[i][1],
              0,
              income,
              0,
              income - saving,
              0
            ]);
        //add rules
        for (int j = 0; j < rules.length; j++) {
          await db.rawInsert(
              'INSERT INTO reserve(planID,reservedType,reservedAmount,actualAmount,checked,monthlyPlanID) VALUES(?,?,?,?,?,?)',
              [
                planID,
                rules[j]['reservedType'],
                rules[j]['amount'],
                0,
                0,
                monthlyPlanID
              ]);
        }
      }
    }
  }

  Future<List<MonthlyPlanModel>> getAllMonthlyPlan() async {
    Database db = await initDB();
    List<Map<String, Object?>> datas = [];
    datas = await db
        .rawQuery('SELECT planID FROM plan ORDER BY planID DESC LIMIT 1');

    if (datas.isNotEmpty) {
      int lastestPlan = int.parse(datas[0]['planID'].toString());
      datas = await db.rawQuery(
          'SELECT * FROM monthlyPlan WHERE planID = ?', [lastestPlan]);
    }
    //print(datas);
    return datas.map((e) => MonthlyPlanModel.fromMap(e)).toList();
  }

  Future<List<Map<String, Object?>>> getReserveMonthly(
      int? monthlyPlanID) async {
    Database db = await initDB();
    List<Map<String, Object?>> reserved = await db.rawQuery(
        'SELECT * FROM reserve WHERE monthlyPlanID = ?', [monthlyPlanID]);
    return reserved;
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
}
