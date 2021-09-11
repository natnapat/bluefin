import 'package:bluefin/database/planDB.dart';
import 'package:bluefin/providers/planProvider.dart';
import 'package:bluefin/screens/planning/addPlan.dart';
import 'package:bluefin/screens/transaction/addTradeTrans.dart';
import 'package:bluefin/screens/transaction/cashTransaction.dart';
import 'package:bluefin/screens/transaction/addCashTrans.dart';
import 'package:bluefin/screens/transaction/tradeTransaction.dart';
import 'package:bluefin/screens/transaction/widgets/filterModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  int transIndex = 0;

  void initState() {
    super.initState();
    Provider.of<PlanProvider>(context, listen: false).checkPlan();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, PlanProvider provider, Widget? child) {
      return DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Center(
                  child: Text(
                "Transaction",
                style: TextStyle(color: Colors.black),
              )),
              leading: IconButton(
                  onPressed: () {
                    if (provider.check == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        if (transIndex == 0) {
                          return AddCashTrans();
                        } else
                          return AddTradeTrans();
                      }));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddPlan();
                      }));
                    }
                  },
                  color: Colors.black45,
                  icon: Icon(
                    MaterialCommunityIcons.plus,
                  )),
              actions: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        context: context,
                        builder: (context) {
                          return FilterModal(transIndex: transIndex);
                        });
                  },
                  //highlightColor: Colors.transparent,
                  //splashColor: Colors.transparent,
                  color: Colors.black45,
                  icon: Icon(
                    MaterialCommunityIcons.filter_outline,
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   color: Colors.black45,
                //   icon: Icon(
                //     MaterialCommunityIcons.calendar_blank_outline,
                //   ),
                // )
              ],
              bottom: TabBar(
                unselectedLabelColor: Colors.black45,
                labelColor: Colors.black,
                indicatorColor: Colors.amber,
                indicatorSize: TabBarIndicatorSize.label,
                overlayColor:
                    MaterialStateColor.resolveWith((Set<MaterialState> states) {
                  return Colors.transparent;
                }),
                onTap: (index) {
                  transIndex = index;
                },
                tabs: <Widget>[
                  Tab(
                    text: 'Cash',
                  ),
                  Tab(
                    text: 'Trades',
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[CashTransaction(), TradeTransaction()],
            ),
          ));
    });
  }
}
