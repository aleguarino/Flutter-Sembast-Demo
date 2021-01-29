import 'package:sembast/sembast.dart';
import 'package:sembast_demo/db/database.dart';
import 'package:sembast_demo/models/user.dart';

class UserStore {
  static const String USER_STORE_KEY = 'users';
  static final UserStore _userStore = UserStore._internal();
  factory UserStore() => _userStore;
  UserStore._internal();

  final Database _db = DB().database;
  final StoreRef<String, Map> _store = StoreRef<String, Map>(USER_STORE_KEY);

  Future<List<User>> find({Finder finder}) async {
    List<RecordSnapshot<String, Map>> snapshots =
        await this._store.find(_db, finder: finder);

    return snapshots
        .map((RecordSnapshot<String, Map> snap) => User.fromJson(snap.value))
        .toList();
  }

  Future<void> add(User user) async {
    await this._store.record(user.id).put(this._db, user.toJson());
  }

  Future<int> delete({Finder finder}) async {
    return await this._store.delete(this._db, finder: finder);
  }
}
