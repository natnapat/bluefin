import 'package:flutter/material.dart';

class CategorySearch extends SearchDelegate<String> {
  CategorySearch({
    @required this.transIndex,
  });

  final transIndex;
  String result = "";

  var categoryNames = [
    "Income",
    "Foods/Drink/Groceries",
    "Salary",
    "Dining/Meal",
    "Transportation",
    "Entertainment",
    "Fashion/Cosmetic",
    "Book",
    "Fuel",
    "Travel",
    "Car Maintenance",
    "Health Care",
    "Electricity/Water",
    "Phone/Internet",
    "Others"
  ];

  var assetNames = [
    "BTC",
    "ETH",
    "ADA",
    "BNB",
    "USDT",
    "XRP",
    "SOL",
    "DOGE",
    "DOT",
    "USDC"
  ];

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
    var suggestions;
    if (transIndex == 0) {
      suggestions = categoryNames.where((name) {
        return name.toLowerCase().contains(query.toLowerCase());
      });
    } else if (transIndex == 1) {
      suggestions = assetNames.where((name) {
        return name.toLowerCase().contains(query.toLowerCase());
      });
    }

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
    var suggestions;
    if (transIndex == 0) {
      suggestions = categoryNames.where((name) {
        return name.toLowerCase().contains(query.toLowerCase());
      });
    } else if (transIndex == 1) {
      suggestions = assetNames.where((name) {
        return name.toLowerCase().contains(query.toLowerCase());
      });
    }

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
