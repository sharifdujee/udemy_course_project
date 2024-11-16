import 'package:expense_tracker/screen/expenses.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp

  ]).then((fn){*/
    runApp(MaterialApp(
      darkTheme: ThemeData().copyWith(
        colorScheme: kDartColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDartColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDartColorScheme.primaryContainer),
        ),
      ),
      theme: ThemeData().copyWith(
        //scaffoldBackgroundColor: const Color.fromARGB(255, 220, 189, 252),
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
        ),
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: const ExpensesScreen(),
    ));



}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDartColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 5, 99, 125),
  brightness: Brightness.dark
);
