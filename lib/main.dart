import 'package:cashmate/controller/bottombar_provider.dart';
import 'package:cashmate/controller/login_provider.dart';
import 'package:cashmate/controller/settings_provider.dart';
import 'package:cashmate/controller/statistics_provider.dart';
import 'package:cashmate/controller/transaction_provider.dart';
import 'package:cashmate/services/transactionDB.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:cashmate/widgets/splash_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => StatisticsProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CashMate',
        home: ScreenSplash(),
      ),
    );
  }
}
