import 'package:flutter/foundation.dart';
import 'package:bluefin/database/walletDB.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WalletProvider with ChangeNotifier {
  var myCryptoDatas = [];
  double cashBalance = 0;
  double equityValue = 0;
  double equityValueYesterday = 0;
  double pnlYesterday = 0;
  double bitcoinPrice = 0;

  void myAssetData() async {
    int i = 0, j = 0;
    WalletDB db = WalletDB();
    List<Map<String, Object?>> assets = [];
    assets = await db.getMyAssets();
    //print(assets);
    if (assets.isNotEmpty) {
      var response = await http.get(Uri.parse(
          'https://ggm079kc2d.execute-api.ap-southeast-1.amazonaws.com/crypto'));
      final cryptoID = jsonDecode(response.body);

      List idsToFetch = [];

      for (i = 0; i < assets.length; i++) {
        for (j = 0; j < cryptoID.length; j++) {
          if (assets[i]['symbol'].toString().toUpperCase() ==
              cryptoID[j]['symbol']) {
            //print(cryptoID[j]['id']);
            idsToFetch.add(cryptoID[j]['id']);
          }
        }
      }
      //print(idsToFetch);

      String url =
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=thb&ids=';
      for (i = 0; i < idsToFetch.length; i++) {
        url = url + '%2C' + idsToFetch[i];
      }
      url += '&order=market_cap_desc&per_page=100&page=1&sparkline=false';
      //print(url);
      response = await http.get(Uri.parse(url));
      myCryptoDatas = jsonDecode(response.body);
      //print(myCryptoDatas);

      equityValue = 0;
      equityValueYesterday = 0;
      pnlYesterday = 0;
      for (i = 0; i < myCryptoDatas.length; i++) {
        for (j = 0; j < assets.length; j++) {
          if (myCryptoDatas[i]['symbol'] == assets[j]['symbol']) {
            //print(assets[j]['symbol']);
            myCryptoDatas[i]['hodl'] = assets[j]['hodl'];
            myCryptoDatas[i]['ownedValue'] =
                myCryptoDatas[i]['current_price'].toDouble() *
                    assets[j]['hodl'];
            equityValueYesterday += (myCryptoDatas[i]['current_price'] -
                    myCryptoDatas[i]['price_change_24h']) *
                assets[j]['hodl'];
            //print(assets[j]['hodl']);
            //print(myCryptoDatas[i]['price_change_24h']);
          }
        }
        equityValue += myCryptoDatas[i]['ownedValue'];
      }
      //print(equityValue);
      //print(equityValueYesterday);
      pnlYesterday = (equityValue - equityValueYesterday) / equityValue * 100;
      //print(cashBalance);
      notifyListeners();
    } else {
      print("assets empty");
    }
  }

  void getCashBalance() async {
    WalletDB db = WalletDB();
    cashBalance = await db.getCashBalance();
  }
}
