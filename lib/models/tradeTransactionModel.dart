class TradeTransactionModel {
  int? tradeID;
  String tradeTitle;
  double tradeAmount;
  String tradeDate;
  double tradePrice;
  double tradeTotal;

  TradeTransactionModel(
      {this.tradeID,
      required this.tradeTitle,
      required this.tradeAmount,
      required this.tradeDate,
      required this.tradePrice,
      required this.tradeTotal});

  factory TradeTransactionModel.fromMap(Map<String, dynamic> json) =>
      TradeTransactionModel(
          tradeID: json['tradeID'],
          tradeTitle: json["tradeTitle"],
          tradeAmount: json["tradeAmount"],
          tradeDate: json["tradeDate"],
          tradePrice: json["tradePrice"],
          tradeTotal: json["tradeTotal"]);

  Map<String, dynamic> toMap() => {
        "tradeID": tradeID,
        "tradeTitle": tradeTitle,
        "tradeDate": tradeDate,
        "tradeAmount": tradeAmount,
        "tradePrice": tradePrice,
        "tradeTotal": tradeTotal
      };
}
