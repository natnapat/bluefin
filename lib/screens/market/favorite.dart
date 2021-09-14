import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bluefin/providers/marketProvider.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  void initState() {
    super.initState();
    Provider.of<MarketProvider>(context, listen: false).initFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, MarketProvider provider, Widget? child) {
      return Container(
        child: Column(
          children: [
            ListView.builder(
              itemCount: provider.assets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(provider.assets[index].symbol),
                );
              },
            )
          ],
        ),
      );
    });
  }
}
