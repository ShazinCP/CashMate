import 'package:cashmate/controller/provider_transaction.dart';
import 'package:cashmate/controller/transactiondb_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Consumer<ProviderTransaction>(
        builder: (context, value, child) {
          return Card(
            elevation: 9,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: value.searchQueryController,
                onChanged: (query) {
                  searchResult(context, query);
                },
                decoration: InputDecoration(
                    hintText: 'Search..',
                    border: InputBorder.none,
                    icon: const Icon(
                      Icons.search,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          value.searchQueryController.clear();
                        },
                        icon: const Icon(
                          Icons.close,
                        ))),
              ),
            ),
          );
        },
      ),
    );
  }

  searchResult(BuildContext context, String query) {
    final dbProvider =
        Provider.of<TransactionDBProvider>(context, listen: false);

    debugPrint('queryprinted  $query');
    if (query.isEmpty || query == '') {
      debugPrint(query);

      dbProvider.transactionList =
         dbProvider.graphList;
    } else {
      dbProvider.transactionList = dbProvider.graphList
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(query.trim().toLowerCase()) ||
              element.explain.contains(query.trim().toLowerCase()))
          .toList();

    TransactionDBProvider().notifyListeners();

    
    // if (query.isEmpty || query == '') {
    //   dbProvider.transactionList = dbProvider.graphList;
    // } else {
    //   dbProvider.transactionList = dbProvider.graphList
    //       .where((element) =>
    //           element.name.toLowerCase().contains(query.trim().toLowerCase()))
    //       .toList();

    // }
  }
}
}