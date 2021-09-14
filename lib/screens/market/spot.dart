import 'package:bluefin/screens/market/assetDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bluefin/providers/marketProvider.dart';

class Spot extends StatefulWidget {
  const Spot({Key? key}) : super(key: key);

  @override
  _SpotState createState() => _SpotState();
}

class _SpotState extends State<Spot> {
  double usdt_price = 0;
  @override
  void initState() {
    super.initState();
    Provider.of<MarketProvider>(context, listen: false).initSpots();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, MarketProvider provider, Widget? child) {
      for (int i = 0; i < provider.cryptoDatas.length; i++) {
        if (provider.cryptoDatas[i]['symbol'] == 'usdt') {
          usdt_price = provider.cryptoDatas[i]['current_price'];
          break;
        }
      }
      return Column(
        children: [
          Row(children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 0, 5),
              child: Text(
                "Asset",
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
                  itemCount: provider.cryptoDatas.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssetDetail(
                              passedID: provider.cryptoDatas[index]['id'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.all(0),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(left: 15),
                              child: Image.network(
                                  provider.cryptoDatas[index]['image']),
                            ),
                            Container(
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(25, 5, 10, 0),
                                    child: Text(
                                      provider.cryptoDatas[index]['symbol']
                                          .toUpperCase(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(25, 0, 0, 10),
                                    child: Text(
                                      provider.cryptoDatas[index]['name'],
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                                  //color: Colors.green,
                                  child: Text(
                                    NumberFormat.simpleCurrency(locale: 'th')
                                        .format(provider.cryptoDatas[index]
                                            ['current_price']),
                                    style: TextStyle(
                                        color: provider.cryptoDatas[index]
                                                    ['price_change_24h'] >
                                                0
                                            ? Colors.green
                                            : Colors.redAccent,
                                        //fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                                  //color: Colors.green,
                                  child: Text(
                                    NumberFormat.simpleCurrency(locale: 'en')
                                        .format(provider.cryptoDatas[index]
                                                ['current_price'] /
                                            usdt_price),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                )
                              ],
                            )),
                            Container(
                              width: 80,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              alignment: Alignment.center,
                              color: provider.cryptoDatas[index]
                                          ['price_change_percentage_24h'] >=
                                      0
                                  ? Colors.green
                                  : Colors.redAccent,
                              child: Text(
                                provider.cryptoDatas[index]
                                            ['price_change_percentage_24h'] >=
                                        0
                                    ? "+" +
                                        provider.cryptoDatas[index]
                                                ['price_change_percentage_24h']
                                            .toStringAsFixed(2) +
                                        "%"
                                    : provider.cryptoDatas[index]
                                                ['price_change_percentage_24h']
                                            .toStringAsFixed(2) +
                                        "%",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      );
    });
  }
}
