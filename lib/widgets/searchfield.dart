import 'package:cashmate/controller/provider_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Consumer<ProviderTransaction>(
        builder: (context, provider, child) {
          return Card(
            elevation: 9,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                textInputAction: TextInputAction.search,
                controller: provider.searchQueryController,
                onChanged: (value) {
                   provider.addToQueryList(value);
            provider.queryval = value;
                },
                decoration: InputDecoration(
                  hintText: 'Search..',
                  border: InputBorder.none,
                  icon: const Icon(
                    Icons.search,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                    provider.queryval = '';
                  provider.searchQueryController.clear();
                  provider.addToQueryList('');
                  FocusManager.instance.primaryFocus?.unfocus();
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}