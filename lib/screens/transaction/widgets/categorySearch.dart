import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class CategorySearch extends SearchDelegate<String> {
  // CategorySearch({
  //   @required this.transIndex,
  // });

  //final transIndex;
  String result = "";

  var categoryNames = [
    "Income",
    "Housing",
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

    suggestions = categoryNames.where((name) {
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
    final suggestions = categoryNames.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          tileColor: Colors.white,
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
