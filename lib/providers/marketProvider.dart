import 'package:bluefin/models/assetModel.dart';
import 'package:flutter/foundation.dart';
import 'package:bluefin/database/marketDB.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketProvider with ChangeNotifier {
  List<AssetModel> assets = [];
  var supportAssetList = [];
  var cryptoDatas = [];

  List<AssetModel> getAssets() {
    return assets;
  }

  void initFavorites() async {
    MarketDB db = MarketDB();
    assets = await db.getFavorites();
    notifyListeners();
  }

  void initSpots() async {
    int i = 0, j = 0;
    MarketDB db = MarketDB();

    //get support assets list
    var response = await http.get(Uri.parse(
        'https://ggm079kc2d.execute-api.ap-southeast-1.amazonaws.com/crypto'));
    supportAssetList = jsonDecode(response.body);
    //print(supportAssetList);

    //get crypto data
    String url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=thb&ids=';
    for (i = 0; i < supportAssetList.length; i++) {
      url = url + '%2C' + supportAssetList[i]['id'];
    }
    url += '&order=market_cap_desc&per_page=100&page=1&sparkline=false';
    response = await http.get(Uri.parse(url));
    cryptoDatas = jsonDecode(response.body);
    //print(cryptoDatas);

    notifyListeners();
  }
}
