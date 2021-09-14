class AssetModel {
  int? id;
  String symbol;
  double hodl;
  int favorite;

  AssetModel({
    this.id,
    required this.symbol,
    required this.hodl,
    required this.favorite,
  });

  factory AssetModel.fromMap(Map<String, dynamic> json) => AssetModel(
      id: json["id"],
      symbol: json["symbol"],
      hodl: json["hodl"],
      favorite: json["favorite"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "symbol": symbol,
        "hodl": hodl,
        "favorite": favorite,
      };
}
