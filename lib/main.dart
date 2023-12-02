import 'package:cashmate/services/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/widgets/splash_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart';

const saveKeyName = 'User logged in';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(MoneyModelAdapter().typeId)) {
    Hive.registerAdapter(MoneyModelAdapter());
  }

  await Hive.openBox<MoneyModel>(transactionDBName);

  runApp(const MyApp());
  TransactionDB().getAllTransactions();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CashMate',
      home: ScreenSplash(),
    );
  }
}
