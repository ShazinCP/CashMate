import 'package:cashmate/controller/transactiondb_provider.dart';
import 'package:cashmate/model/data_model.dart';
import 'package:hive/hive.dart';

class TransactionService {
  Future<List<MoneyModel>> getAllTransactions() async {
    final transactionDB = await Hive.openBox<MoneyModel>(transactionDBName);
    return transactionDB.values.toList();
  }

  Future<void> insertTransaction(MoneyModel obj) async {
    final transactionDB = await Hive.openBox<MoneyModel>(transactionDBName);
    await transactionDB.put(obj.id, obj);
  }

  Future<void> deleteTransaction(String id) async {
    final transactionDB = await Hive.openBox<MoneyModel>(transactionDBName);
    transactionDB.delete(id);
  }

  Future<void> editTransaction(MoneyModel value) async {
    try {
      final transactionDB = await Hive.openBox<MoneyModel>(transactionDBName);
      transactionDB.put(value.id, value);
    } catch (e) {
      print('Error editing transaction: $e');
    }
  }
}
