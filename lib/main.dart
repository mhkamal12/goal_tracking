import 'package:flutter/material.dart';
import 'package:goal_tracker/provider/ThemeProvider.dart';
import 'package:goal_tracker/theme/theme.dart';
import 'package:goal_tracker/utility/Helper.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) {
        return ThemeProvider();
      },
      child: const MyApp()));
}

// Function to initialize the database
Future<void> initializeDatabase() async {
  // Get the database path
  String path = await getDbPath();

  // Check if the database exists
  bool exists = await databaseExists(path);
  if (!exists) {
    // If the database doesn't exist, create it
    print("Creating new database...");
    await openDatabase(path, version: 1, onCreate: (db, version) {
      // Create the table
      return db.execute(
        'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT , priority INTEGER, date TEXT, progress INTEGER)',
      );
    });
    print("Database created!");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<ThemeProvider>(context, listen: false)
            .getThemeFromSharedPref(),
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            themeMode:
                Provider.of<ThemeProvider>(context, listen: true).isDarkMode
                    ? ThemeMode.dark
                    : ThemeMode.light,
            theme: lightThemeData(),
            darkTheme: darkThemeData(),
            home: const HomeScreen(),
          );
        });
  }
}
