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
          controller: searchprovider.searchController,
          onChanged: (value) {
            // homeProvider.search(value);
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
