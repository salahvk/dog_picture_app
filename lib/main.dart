import 'package:dog_picture_app/components/routes_manager.dart';
import 'package:dog_picture_app/db/hive_adapter.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("urlList");
  Hive.registerAdapter(UrlListAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog Picture App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.splashScreen,
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}
