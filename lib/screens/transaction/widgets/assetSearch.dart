import 'package:flutter/material.dart';

class AssetSearch extends SearchDelegate<String> {
  String result = "";
  var assetNames = [
    "ADA",
    "BTC",
    "USDT",
    "ETH",
    "BNB",
    "XRP",
    "USDC",
    "DOGE",
    "DOT",
    "BUSD",
    "UNI",
    "BCH",
    "LTC",
    "SOL",
    "LINK",
    "MATIC"
  ];

  //AssetSearch(this.assetNames);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = assetNames.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            suggestions.elementAt(index),
          ),
          onTap: () {
            result = suggestions.elementAt(index);

            close(context, result);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = assetNames.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            suggestions.elementAt(index),
          ),
          onTap: () {
            query = suggestions.elementAt(index);
            close(context, query);
          },
        );
      },
    );
  }
}
