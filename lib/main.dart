import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sembast_demo/db/app_theme.dart';
import 'package:sembast_demo/db/database.dart';
import 'package:sembast_demo/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB().init();
  await MyAppTheme().init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    DB().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MyAppTheme(),
      child: Consumer<MyAppTheme>(
        builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme:
              MyAppTheme().isDarkEnabled ? ThemeData.dark() : ThemeData.light(),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
