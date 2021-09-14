import 'package:bluefin/models/chartData.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChartProvider with ChangeNotifier {
  List OHLC = [];
  List<ChartData> chartData = [];
  var myCryptoDatas = [];

  void getOHLC(String assetID, int activePeriod) async {
    chartData = [];
    OHLC = [];
    String _apiURL = "https://api.coingecko.com/api/v3/coins/" +
        assetID +
        "/ohlc?vs_currency=thb&days=" +
        activePeriod.toString();
    http.Response response = await http.get(Uri.parse(_apiURL));

    OHLC = jsonDecode(response.body);

    for (int i = 0; i < OHLC.length; i++) {
      ChartData data = ChartData(
          x: DateTime.fromMillisecondsSinceEpoch(OHLC[i][0]),
          open: OHLC[i][1],
          high: OHLC[i][2],
          low: OHLC[i][3],
          close: OHLC[i][4]);
      chartData.add(data);
    }
    _apiURL =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=thb&ids=' +
            assetID;
    _apiURL += '&order=market_cap_desc&per_page=100&page=1&sparkline=false';
    response = await http.get(Uri.parse(_apiURL));
    myCryptoDatas = jsonDecode(response.body);

    print(activePeriod.toString());
    //print(myCryptoDatas[0]['name']);
    notifyListeners();
  }
}
