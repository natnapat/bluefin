import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AssetSearch extends SearchDelegate<String> {
  String result = "";

  Future<List> fetchAsset() async {
    var response = await http.get(Uri.parse(
        'https://6ctfptnaf3.execute-api.ap-southeast-1.amazonaws.com/crypto'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

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
    Future<List<dynamic>> assetNames = fetchAsset();

    print(assetNames);
    // suggestions = assetNames.where((name) {
    //   return name.toLowerCase().contains(query.toLowerCase());
    // });

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
    return FutureBuilder(
        future: fetchAsset(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List suggestions = snapshot.data;
            //print(suggestions.length);
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
                });
          }

          return Center(child: CircularProgressIndicator());
        });

    //   var suggestions;
    //   Future<List<dynamic>> assetNames = fetchAsset();
    //   if (transIndex == 0) {
    //     suggestions = categoryNames.where((name) {
    //       return name.toLowerCase().contains(query.toLowerCase());
    //     });
    //   } else if (transIndex == 1) {
    //     print(assetNames[0]);
    //     // suggestions = assetNames.where((name) {
    //     //   return name.toLowerCase().contains(query.toLowerCase());
    //     // });
    //   }

    //   return ListView.builder(
    //     itemCount: suggestions.length,
    //     itemBuilder: (BuildContext context, int index) {
    //       return ListTile(
    //         title: Text(
    //           suggestions.elementAt(index),
    //         ),
    //         onTap: () {
    //           query = suggestions.elementAt(index);
    //           close(context, query);
    //         },
    //       );
    //     },
    //   );
    // }
  }
}
