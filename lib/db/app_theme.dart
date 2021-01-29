import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_demo/db/database.dart';

class MyAppTheme extends ChangeNotifier {
  static const String DARK_KEY = 'DARK_ENABLED';
  static final MyAppTheme _myAppTheme = MyAppTheme._internal();
  factory MyAppTheme() => _myAppTheme;
  MyAppTheme._internal();

  final StoreRef _store = StoreRef.main();
  final Database _db = DB().database;

  bool _darkenabled = false;
  bool get isDarkEnabled => _darkenabled;

  Future<void> init() async {
    this._darkenabled = await _store.record(DARK_KEY).get(this._db) ?? false;
  }

  Future<void> change(bool darkEnabled) async {
    this._darkenabled = darkEnabled;
    final dataSave =
        await this._store.record(DARK_KEY).put(this._db, this._darkenabled);
    notifyListeners();
    print("LOG:: theme saved $dataSave");
  }
}
