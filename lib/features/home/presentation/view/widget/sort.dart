import 'package:flutter/material.dart';

class Sort extends StatelessWidget {
  const Sort({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            groupValue: "All",
            onChanged: (value) {
              // homeProvider.filterItems(value!);
            }),
        RadioListTile<String>(
            value: "Younger",
            title: const Text("Younger"),
            groupValue: "All",
            onChanged: (value) {
              // homeProvider.filterItems(value!);
            }),
        RadioListTile<String>(
            value: "Elder",
            title: const Text("Elder"),
            groupValue: "All",
            onChanged: (value) {
              // homeProvider.filterItems(value!);
            }),
      ],
    );
  }
}
