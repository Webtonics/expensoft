import 'package:expense_app/utils/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/database_provider.dart';
// screens
import './screens/category_screen.dart';
import './screens/expense_screen.dart';
import './screens/all_expenses.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(ChangeNotifierProvider(
    create: (_) => DatabaseProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: CategoryScreen.name,
          routes: {
            CategoryScreen.name: (_) => const CategoryScreen(),
            ExpenseScreen.name: (_) => const ExpenseScreen(),
            AllExpenses.name: (_) => const AllExpenses(),
          },
          // themeMode: ThemeMode.system,
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            primaryColor: Colors.deepPurple,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            ),
          ),
          darkTheme: ThemeData.dark(),
        );
      });
}
