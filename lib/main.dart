import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'my_phone_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('contactsBox');
  runApp(const PhoneApp());
}


class PhoneApp extends StatelessWidget {
  const PhoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blueGrey.shade800, // Cursor color
          selectionColor: Colors.blueGrey.shade300, // Text highlight color
          selectionHandleColor: Colors.blueGrey.shade800, // Selection handle (droplet) color
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyPhoneApp(),
    );
  }
}
