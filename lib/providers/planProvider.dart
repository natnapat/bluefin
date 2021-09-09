import 'package:flutter/foundation.dart';
import 'package:bluefin/database/planDB.dart';

class PlanProvider with ChangeNotifier {
  void addPlan(String goalType, double goalAmount, double income,
      List<Map> rules) async {
    var db = PlanDB();
    await db.insertPlan(goalType, goalAmount, income, rules);
    notifyListeners();
  }

  List<Map<String, Object?>> reserved = [];
  //List<Map<String, Object?>> spend = [];
  List<Map<String, Object?>> plan = [];
  double expense = 0;
  void initData() async {
    PlanDB db = PlanDB();
    plan = await db.getPlan();
    int planID = int.parse(plan[0]['planID'].toString());
    print(planID);
    reserved = await db.getReserved(planID);
    //spend = await db.getSpend(planID);
    print(reserved);
    //print(spend);
    expense = await db.getExpense(
        plan[0]['startDate'].toString(), plan[0]['endDate'].toString());
    print(expense);
    notifyListeners();
  }

  void setChecked(int rid) async {
    PlanDB db = PlanDB();
    await db.checked(rid);
    await db.initDB();
    notifyListeners();
  }
}
