import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:dart_date/dart_date.dart';
import 'package:bluefin/models/assetModel.dart';

class MarketDB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, "bluefin.db"));
  }

  Future<List<AssetModel>> getFavorites() async {
    Database db = await initDB();
    List<Map<String, Object?>> datas = [];
    datas = await db.rawQuery('SELECT * FROM asset WHERE favorite = ?', [1]);
    //print(datas);
    return datas.map((e) => AssetModel.fromMap(e)).toList();
  }

  Future<List<AssetModel>> getSpots() async {
    Database db = await initDB();
    List<Map<String, Object?>> datas = [];
    datas = await db.rawQuery('SELECT * FROM asset', [1]);
    //print(datas);
    return datas.map((e) => AssetModel.fromMap(e)).toList();
  }
}
