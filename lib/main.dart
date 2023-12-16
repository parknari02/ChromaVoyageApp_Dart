import 'package:chromavoyage_client/screens/create_group_screen.dart';
import 'package:chromavoyage_client/widgets/AddLocationWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/map_screen.dart';
import 'models/group.dart';
import 'screens/initial_page.dart';
import 'widgets/MyProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => MyProvider(),
        child: InitialPage(),
      ),
    );
  }
}




