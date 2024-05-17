import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';
import 'package:totalxproject/features/home/presentation/provider/get_user_provider.dart';

class Usercard extends StatelessWidget {
  const Usercard({
    super.key,
    required this.data,
    required this.index,
  });

  final UserModel data;
  final index;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetUserProvider>(builder: (context, value, _) {
      return Card(
        margin: const EdgeInsets.all(0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(data.image),
          ),
          title: Text(
            data.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            data.age.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              onPressed: () {
                value.deletelist(data.docId.toString(), index);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ),
      );
    });
  }
}
