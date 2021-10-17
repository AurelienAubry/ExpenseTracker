import 'package:flutter/material.dart';

import 'database/transactions_database.dart';
import 'home.dart';
import 'models/transaction.dart';

const darkBlue = const Color(0xFF2A2B90);
const lightBlue = const Color(0xFFF0F3FD);
const darkGrey = const Color(0xFF464646);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TransactionDatabase.db.insert(Transaction(
      title: 'Electricity', description: 'State Provider', amount: 10.54, date: DateTime.utc(2021, 9, 23), id: 0));
  TransactionDatabase.db.insert(
      Transaction(title: 'SCPIE', description: 'BLALBA', amount: 1414.54, date: DateTime.utc(2021, 10, 23), id: 2));
  print(await TransactionDatabase.db.transactions());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses Tracker',
      home: HomePage(),
      theme: ThemeData(scaffoldBackgroundColor: lightBlue),
    );
  }
}
