import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast_demo/db/app_theme.dart';
import 'package:sembast_demo/db/user_store.dart';
import 'package:sembast_demo/models/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<User> _users = [];

  _load() async {
    final Finder finder = Finder(
      sortOrders: [
        SortOrder('age', false),
      ],
    );
    this._users = await UserStore().find(
      finder: finder,
    );
    setState(() {});
  }

  _add() async {
    User user = User.fake();
    await UserStore().add(user);
    setState(() => this._users.add(user));
  }

  _delete() async {
    final Finder finder = Finder(
        /*filter: Filter.greaterThan('age', 40),*/
        );
    final int count = await UserStore().delete(finder: finder);
    final SnackBar snackBar = SnackBar(
      content: Text('$count users deleted'),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    _load();
  }

  _deleteUser(User user) async {
    final Finder finder = Finder(
      filter: Filter.byKey(user.id),
    );
    final int count = await UserStore().delete(finder: finder);
    final SnackBar snackBar = SnackBar(
      content: Text('User ${user.name} deleted'),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    _load();
  }

  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          Switch(
              value: MyAppTheme().isDarkEnabled,
              onChanged: (enabled) => MyAppTheme().change(enabled))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_users[index].name),
            subtitle: Text(
              'age: ${_users[index].age}, email: ${_users[index].email}',
              maxLines: 2,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteUser(_users[index]),
            ),
          );
        },
        itemCount: _users.length,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _load,
            heroTag: 'reload',
            child: Icon(
              Icons.repeat,
              color: Colors.black,
            ),
            backgroundColor: Colors.blue[200],
          ),
          SizedBox(width: 15),
          FloatingActionButton(
            onPressed: _delete,
            heroTag: 'clear',
            child: Icon(
              Icons.clear_all,
              color: Colors.black,
            ),
            backgroundColor: Colors.redAccent,
          ),
          SizedBox(width: 15),
          FloatingActionButton(
            onPressed: _add,
            heroTag: 'add',
            child: Icon(
              Icons.person_add,
              color: Colors.black,
            ),
            backgroundColor: Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}
