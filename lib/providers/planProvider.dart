import 'package:flutter/foundation.dart';
import 'package:bluefin/database/planDB.dart';
import 'package:bluefin/models/monthlyPlanModel.dart';

class PlanProvider with ChangeNotifier {
  List<Map<String, Object?>> reserved = [];
  List<MonthlyPlanModel> monthlyPlans = [];
  double expense = 0;

  List<MonthlyPlanModel> getAllMonthlyPlan() {
    return monthlyPlans;
  }

  //get plan data
  void initData() async {
    PlanDB db = PlanDB();
    monthlyPlans = await db.getAllMonthlyPlan();
    if (monthlyPlans.isNotEmpty) {
      print(monthlyPlans);
      int planID = int.parse(monthlyPlans[0].monthlyPlanID.toString());
      //print(planID);
      reserved = await db.getReserveMonthly(planID);
      print(reserved);
      // expense = await db.getExpense(
      //     monthlyPlans[0].startDate, monthlyPlans[0].startDate);
      // print(expense);
    }
    notifyListeners();
  }

  void getReserveMonthly(int? monthlyPlanID) async {
    PlanDB db = PlanDB();
    reserved = await db.getReserveMonthly(monthlyPlanID);
    print(reserved);
  }

  //add new plan
  void addPlan(String goalType, double goalAmount, double income,
      List<Map> rules, String deadLine) async {
    var db = PlanDB();
    await db.insertPlan(goalType, goalAmount, income, rules, deadLine);
    notifyListeners();
  }

  void setChecked(int rid) async {
    PlanDB db = PlanDB();
    await db.checked(rid);
    await db.initDB();
    notifyListeners();
  }

  //check if there is a plan
  bool check = false;
  void checkPlan() async {
    PlanDB db = PlanDB();
    monthlyPlans = await db.getAllMonthlyPlan();
    if (monthlyPlans.isNotEmpty)
      check = true;
    else
      check = false;
    notifyListeners();
  }
}
