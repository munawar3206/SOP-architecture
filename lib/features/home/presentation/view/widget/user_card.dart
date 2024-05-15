
import 'package:flutter/material.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';

class Usercard extends StatelessWidget {
  const Usercard({
    super.key,
    required this.data,
  });

  final UserModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(data.image),
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        data.name,
                        style: const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data.age.toString(),
                        style: const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
