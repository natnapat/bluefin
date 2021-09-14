class CashTransactionModel {
  int? id;
  String title;
  double amount;
  String timestamp;
  String category;
  int monthlyPlanID;

  CashTransactionModel(
      {this.id,
      required this.title,
      required this.amount,
      required this.timestamp,
      required this.category,
      required this.monthlyPlanID});

  factory CashTransactionModel.fromMap(Map<String, dynamic> json) =>
      CashTransactionModel(
          id: json["id"],
          title: json["title"],
          amount: json["amount"],
          timestamp: json["timestamp"],
          category: json["category"],
          monthlyPlanID: json["monthlyPlanID"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "amount": amount,
        "timestamp": timestamp,
        "category": category,
        "monthlyPlanID": monthlyPlanID
      };
}
