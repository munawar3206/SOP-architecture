import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/features/search/presentation/provider/search_provider.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, searchprovider, child) {
        return TextFormField(
          autofocus: true,
          controller: searchprovider.searchController,
          onChanged: (value) {
            EasyDebounce.debounce(
                'my-debouncer', // <-- An ID for this particular debouncer
                const Duration(milliseconds: 500), // <-- The debounce duration
                () {
              if (value.isNotEmpty) {
                //search-----------
                searchprovider.clearData();

                searchprovider.getSearchUsers();
                 
              } else {
                searchprovider.clearData();
              
              }
            } // <-- The target method
                );
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "Search by name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
          ),
        );
      },
    );
  }
}
