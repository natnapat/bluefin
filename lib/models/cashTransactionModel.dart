class CashTransactionModel {
  int? id;
  String title;
  double amount;
  String timestamp;
  String category;

  CashTransactionModel(
      {this.id,
      required this.title,
      required this.amount,
      required this.timestamp,
      required this.category});

  factory CashTransactionModel.fromMap(Map<String, dynamic> json) =>
      CashTransactionModel(
          id: json["id"],
          title: json["title"],
          amount: json["amount"],
          timestamp: json["timestamp"],
          category: json["category"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "amount": amount,
        "timestamp": timestamp,
        "category": category
      };
}
