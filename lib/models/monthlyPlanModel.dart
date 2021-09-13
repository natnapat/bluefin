class MonthlyPlanModel {
  int? monthlyPlanID;
  int PlanID;
  double saving;
  String startDate;
  String endDate;
  int isPast;
  double income;
  double actualIncome;
  double expense;
  double actualExpense;

  MonthlyPlanModel(
      {this.monthlyPlanID,
      required this.PlanID,
      required this.saving,
      required this.startDate,
      required this.endDate,
      required this.isPast,
      required this.income,
      required this.actualIncome,
      required this.expense,
      required this.actualExpense});

  factory MonthlyPlanModel.fromMap(Map<String, dynamic> json) =>
      MonthlyPlanModel(
          monthlyPlanID: json["monthlyPlanID"],
          PlanID: json["PlanID"],
          saving: json["saving"],
          startDate: json["startDate"],
          endDate: json["endDate"],
          isPast: json["isPast"],
          income: json["income"],
          actualIncome: json["actualIncome"],
          expense: json["expense"],
          actualExpense: json["actualExpense"]);

  Map<String, dynamic> toMap() => {
        "monthlyPlanID": monthlyPlanID,
        "PlanID": PlanID,
        "saving": saving,
        "startDate": startDate,
        "endDate": endDate,
        "isPast": isPast,
        "income": income,
        "actualIncome": actualIncome,
        "expense": expense,
        "actualExpense": actualExpense
      };
}
