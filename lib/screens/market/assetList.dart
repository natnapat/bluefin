import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AssetList extends StatefulWidget {
  //const AssetList({Key? key}) : super(key: key);

  final String listType;
  AssetList(this.listType);

  @override
  _AssetListState createState() => _AssetListState();
}

class _AssetListState extends State<AssetList> {
  List _assetList = [];
  List dbAssetList = [];

  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    //print(path);
    return openDatabase(join(path, "bluefin.db"));
  }

  Future<void> getCyptoDB() async {
    Database db = await initDB();
    List<Map<String, Object?>> datas = [];
    if (widget.listType == "All") {
      await getCryptoPrices();
      dbAssetList = _assetList;
      return;
    } else if (widget.listType == "Hold") {
      datas =
          await db.query("Assets", columns: ["assetId"], where: "amount > 0");
      //print(datas);
    } else if (widget.listType == "Sold") {
      datas =
          await db.query("Assets", columns: ["assetId"], where: "amount <= 0");
    }
    await getCryptoPrices();
    dbAssetList = [];
    for (int i = 0; i < datas.length; i++) {
      for (int j = 0; j < _assetList.length; j++) {
        if (_assetList[j]["id"] == datas[i]["assetId"]) {
          dbAssetList.add(_assetList[j]);
        }
      }
    }
    //print(dbAssetList);
  }

  Future<void> getCryptoPrices() async {
    String _apiURL =
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=30&page=1&sparkline=false"; //url to get data
    http.Response response =
        await http.get(Uri.parse(_apiURL)); //waits for response
    setState(() {
      this._assetList =
          jsonDecode(response.body); //sets the state of our widget
      //print(_assetList); //prints the list
    });
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
      } else {
        getCyptoDB();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 0, 5),
            child: Text(
              "Name",
              style: TextStyle(color: Colors.grey),
            ),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
            child: Text(
              "Last Price",
              style: TextStyle(color: Colors.grey),
            ),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
            child: Text(
              "24h Change",
              style: TextStyle(color: Colors.grey),
            ),
          )),
        ]),
        Expanded(
          child: Container(
            child: ListView.builder(
                itemCount: dbAssetList.length,
                itemBuilder: (context, i) {
                  return Card(
                    margin: EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(25, 5, 10, 0),
                              child: Text(
                                dbAssetList[i]['symbol'].toUpperCase(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(25, 0, 0, 10),
                              child: Text(
                                dbAssetList[i]['name'],
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                              //color: Colors.green,
                              child: Text(
                                dbAssetList[i]['current_price'].toString(),
                                style: TextStyle(
                                    color:
                                        dbAssetList[i]['price_change_24h'] > 0
                                            ? Colors.green
                                            : Colors.redAccent,
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                              //color: Colors.red,
                              child: Text(
                                NumberFormat.simpleCurrency(locale: 'th')
                                    .format(
                                        dbAssetList[i]['current_price'] * 35),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        )),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.center,
                          color:
                              dbAssetList[i]['price_change_percentage_24h'] >= 0
                                  ? Colors.green
                                  : Colors.redAccent,
                          child: Text(
                            dbAssetList[i]['price_change_percentage_24h'] >= 0
                                ? "+" +
                                    dbAssetList[i]
                                            ['price_change_percentage_24h']
                                        .toStringAsFixed(2) +
                                    "%"
                                : dbAssetList[i]['price_change_percentage_24h']
                                        .toStringAsFixed(2) +
                                    "%",
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
