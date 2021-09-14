import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bluefin/models/tradeTransactionModel.dart';
import 'package:bluefin/providers/tradeTransactionProvider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class TradeTransaction extends StatefulWidget {
  const TradeTransaction({Key? key}) : super(key: key);

  @override
  _TradeTransactionState createState() => _TradeTransactionState();
}

class _TradeTransactionState extends State<TradeTransaction> {
  @override
  void initState() {
    super.initState();
    Provider.of<TradeTransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(
      builder: (context, TradeTransactionProvider provider, Widget? child) {
        var count = provider.tradeTrans.length;
        //print(count);
        if (count <= 0) {
          return Center(
            child: Text("No Trade"),
          );
        } else {
          return ListView.builder(
              itemCount: count,
              itemBuilder: (context, int index) {
                TradeTransactionModel data = provider.tradeTrans[index];
                return Dismissible(
                  key: Key(data.tradeID.toString()),
                  onDismissed: (direction) {
                    var provider = Provider.of<TradeTransactionProvider>(
                        context,
                        listen: false);
                    provider.deleteTradeTransaction(
                      data.tradeID,
                    );
                  },
                  direction: DismissDirection.endToStart,
                  background: Container(
                      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
                      color: Colors.redAccent,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            MaterialCommunityIcons.trash_can_outline,
                            color: Colors.white,
                          ))),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.tradeTitle,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 27),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (() {
                                        if (data.tradeAmount < 0)
                                          return 'Sell';
                                        else
                                          return 'Buy';
                                      }()),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: (() {
                                            if (data.tradeAmount < 0)
                                              return Colors.redAccent;
                                            else
                                              return Colors.green;
                                          }())),
                                    ),
                                    Text('Amount'),
                                    Text('Price'),
                                    Text('Total'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat('d/MM/yyyy HH:mm')
                                          .format(
                                              DateTime.parse(data.tradeDate))
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    Text(data.tradeAmount.toString()),
                                    Text(NumberFormat.simpleCurrency(
                                            locale: 'th')
                                        .format(data.tradePrice)),
                                    Text(NumberFormat.simpleCurrency(
                                            locale: 'th')
                                        .format(data.tradeTotal)),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      },
    ));
  }
}
