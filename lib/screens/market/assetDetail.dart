import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bluefin/providers/chartProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:bluefin/models/chartData.dart';

class AssetDetail extends StatefulWidget {
  final String passedID;
  AssetDetail({
    required this.passedID,
  });

  @override
  _AssetDetailState createState() => _AssetDetailState(assetID: this.passedID);
}

class _AssetDetailState extends State<AssetDetail> {
  String assetID;
  _AssetDetailState({required this.assetID});

  int activePeriod = 1;
  //List<ChartData> chartData = [];
  late TrackballBehavior _trackballBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  @override
  void initState() {
    super.initState();
    Provider.of<ChartProvider>(context, listen: false)
        .getOHLC(this.assetID, this.activePeriod);
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    _zoomPanBehavior =
        ZoomPanBehavior(enablePinching: true, enablePanning: true);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Consumer(builder: (context, ChartProvider provider, Widget? child) {
      //print(provider.chartData[0].open);
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            '${assetID[0].toUpperCase()}${assetID.substring(1)}',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1 " +
                                  provider.myCryptoDatas[0]['symbol']
                                      .toString()
                                      .toUpperCase() +
                                  " / THB",
                              style: themeData.textTheme.caption,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              NumberFormat.simpleCurrency(locale: 'th').format(
                                  provider.myCryptoDatas[0]['current_price']),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26.0,
                              ),
                            ),
                            Text(
                              provider.myCryptoDatas[0]
                                          ['price_change_percentage_24h']
                                      .toString() +
                                  '%',
                              style: TextStyle(
                                color: provider.myCryptoDatas[0]
                                            ['price_change_percentage_24h'] >
                                        0
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "All Time High",
                                style: themeData.textTheme.caption,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                NumberFormat.simpleCurrency(locale: 'th')
                                    .format(provider.myCryptoDatas[0]['ath']),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                provider.myCryptoDatas[0]
                                            ['ath_change_percentage']
                                        .toString() +
                                    '%',
                                style: TextStyle(
                                  color: provider.myCryptoDatas[0]
                                              ['ath_change_percentage'] >
                                          0
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 40, top: 20),
                    child: Row(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              activePeriod = 1;
                              provider.getOHLC(assetID, activePeriod);
                            });
                          },
                          child: const Text('1D'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              activePeriod = 7;
                              provider.getOHLC(assetID, activePeriod);
                            });
                          },
                          child: const Text('1W'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              activePeriod = 30;
                              provider.getOHLC(assetID, activePeriod);
                            });
                          },
                          child: const Text('1M'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              activePeriod = 90;
                              provider.getOHLC(assetID, activePeriod);
                            });
                          },
                          child: const Text('3M'),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: () {
                            setState(() {
                              activePeriod = 365;
                              provider.getOHLC(assetID, activePeriod);
                            });
                          },
                          child: const Text('1Y'),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: SfCartesianChart(
                    trackballBehavior: _trackballBehavior,
                    zoomPanBehavior: _zoomPanBehavior,
                    series: <CandleSeries>[
                      CandleSeries<ChartData, DateTime>(
                          dataSource: provider.chartData,
                          xValueMapper: (ChartData sales, _) => sales.x,
                          lowValueMapper: (ChartData sales, _) => sales.low,
                          highValueMapper: (ChartData sales, _) => sales.high,
                          openValueMapper: (ChartData sales, _) => sales.open,
                          closeValueMapper: (ChartData sales, _) => sales.close)
                    ],
                    primaryXAxis: DateTimeAxis(),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                // Container(
                //   height: 90,
                //   margin: EdgeInsets.symmetric(horizontal: 16.0),
                //   width: double.infinity,
                //   color: Color.fromRGBO(55, 66, 92, 0.4),
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 16.0,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Text(
                //               "Your BTC balance",
                //               style: themeData.textTheme.caption,
                //             ),
                //             SizedBox(
                //               height: 8.0,
                //             ),
                //             Text(
                //               "0.00692133 BTC",
                //               style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 18.0,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             "USD",
                //             style: themeData.textTheme.caption,
                //           ),
                //           SizedBox(
                //             height: 8.0,
                //           ),
                //           Text(
                //             "\$23.35",
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 18.0,
                //             ),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
