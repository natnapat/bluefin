import 'package:bluefin/providers/walletProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WalletProvider>(context, listen: false).myAssetData();
    Provider.of<WalletProvider>(context, listen: false).getCashBalance();
    print(Provider.of<WalletProvider>(context, listen: false).myCryptoDatas);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, WalletProvider provider, Widget? child) {
      return Container(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              "My Wallet",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      child: Text(
                        "Equity Value",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )),
                    Expanded(
                        child: Container(
                      child: Text("Cash Balance",
                          style: TextStyle(color: Colors.grey)),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          NumberFormat.simpleCurrency(locale: 'th')
                              .format(provider.equityValue),
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          NumberFormat.simpleCurrency(locale: 'th')
                              .format(provider.cashBalance),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    "PNL Yesterday",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        provider.pnlYesterday.toStringAsFixed(2) + '%',
                        style: TextStyle(
                            fontSize: 16,
                            color: provider.pnlYesterday > 0
                                ? Colors.green
                                : Colors.redAccent),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      child: provider.pnlYesterday > 0
                          ? Icon(AntDesign.caretup,
                              size: 10, color: Colors.green)
                          : Icon(AntDesign.caretdown,
                              size: 10, color: Colors.redAccent),
                    )
                  ],
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Your Coins",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Total amount " +
                              NumberFormat.simpleCurrency(locale: 'th')
                                  .format(provider.equityValue),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: 500,
                        minHeight: 200,
                        minWidth: MediaQuery.of(context).size.width),
                    child: provider.myCryptoDatas.isEmpty
                        ? Center(
                            child: Text("No Asset"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.myCryptoDatas.length,
                            itemBuilder: (context, index) {
                              var datas = provider.myCryptoDatas;

                              return (Container(
                                height: 90,
                                child: Card(
                                    elevation: 3,
                                    child: Row(
                                      children: [
                                        Container(
                                          //color: Colors.grey,
                                          width: 40,
                                          height: 40,
                                          margin: EdgeInsets.all(10),
                                          child: Image.network(
                                              datas[index]['image']),
                                        ),
                                        Expanded(
                                          child: Container(
                                            // color: Colors.grey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20, left: 5),
                                                    child: Text(
                                                      datas[index]['name'] +
                                                          ' (' +
                                                          datas[index]['symbol']
                                                              .toString()
                                                              .toUpperCase() +
                                                          ')',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, left: 5),
                                                    child: Text(
                                                      datas[index]['hodl']
                                                          .toStringAsFixed(4),
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: 21, right: 15),
                                                    child: Text(
                                                      NumberFormat
                                                              .simpleCurrency(
                                                                  locale: 'th')
                                                          .format(datas[index]
                                                              ['ownedValue']),
                                                    )),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            datas[index][
                                                                        'price_change_percentage_24h']
                                                                    .toStringAsFixed(
                                                                        2) +
                                                                '%',
                                                            style: TextStyle(
                                                                color: datas[index]
                                                                            [
                                                                            'price_change_percentage_24h'] >
                                                                        0
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .redAccent),
                                                          )),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 15, top: 5),
                                                      child: datas[index][
                                                                  'price_change_percentage_24h'] >
                                                              0
                                                          ? Icon(
                                                              AntDesign.caretup,
                                                              size: 10,
                                                              color:
                                                                  Colors.green)
                                                          : Icon(
                                                              AntDesign
                                                                  .caretdown,
                                                              size: 10,
                                                              color: Colors
                                                                  .redAccent),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ));
                            },
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
