import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WalletDB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    //print("database: $path");
    return openDatabase(join(path, "bluefin.db"));
  }

  Future<List<Map<String, Object?>>> getMyAssets() async {
    Database db = await initDB();
    List<Map<String, Object?>> datas =
        await db.rawQuery('SELECT * FROM asset WHERE hodl > 0');
    return datas;
  }

  Future<double> getCashBalance() async {
    double cashBalance = 0;
    Database db = await initDB();
    List<Map<String, Object?>> datas =
        await db.rawQuery('SELECT amount FROM cashTransaction');

    for (int i = 0; i < datas.length; i++) {
      cashBalance += double.parse(datas[i]['amount'].toString());
    }
    return cashBalance;
  }
}
