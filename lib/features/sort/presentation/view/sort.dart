import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/features/sort/presentation/provider/sort_provider.dart';

class Sort extends StatelessWidget {
  const Sort({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SortProvider>(builder: (context, sortProvider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Text(
              "Sort",
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          RadioListTile<String>(
              value: "All",
              title: const Text("All"),
              groupValue: sortProvider.selectedvalue,
              onChanged: (value) {
                sortProvider.sortUser(value!);
               
              }),
          RadioListTile<String>(
              value: "Younger",
              title: const Text("Younger"),
              groupValue: sortProvider.selectedvalue,
              onChanged: (value) {
                sortProvider.sortUser(value!);
              }),
          RadioListTile<String>(
              value: "Elder",
              title: const Text("Elder"),
              groupValue: sortProvider.selectedvalue,
              onChanged: (value) {
             sortProvider.sortUser(value!);
              }),
        ],
      );
    });
  }
}
