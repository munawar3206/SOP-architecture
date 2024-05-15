
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/features/home/presentation/provider/get_user_provider.dart';
import 'package:totalxproject/general/core/enum.dart';

class Sort extends StatelessWidget {
  const Sort({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserProvider>(builder: (context, sortProvider, child) {
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
          RadioListTile(
              value: AgeType.all,
              title: const Text("All"),
              groupValue: sortProvider.selectvalue,
              onChanged: (value) {
                sortProvider.clearData();
                sortProvider.changevalue(AgeType.all);
                sortProvider.getUser(AgeType.all);
                Navigator.pop(context);
              }),
          RadioListTile(
              value: AgeType.younger,
              title: const Text("Younger"),
              groupValue: sortProvider.selectvalue,
              onChanged: (value) {
                sortProvider.clearData();
                sortProvider.changevalue(AgeType.younger);
                sortProvider.getUser(AgeType.younger);
                Navigator.pop(context);
              }),
          RadioListTile(
              value: AgeType.elder,
              title: const Text("Elder"),
              groupValue: sortProvider.selectvalue,
              onChanged: (value) {
                sortProvider.clearData();
                sortProvider.changevalue(AgeType.elder);
                sortProvider.getUser(AgeType.elder);
                Navigator.pop(context);
              }),
        ],
      );
    });
  }
}
