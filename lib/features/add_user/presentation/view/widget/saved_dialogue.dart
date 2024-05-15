import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Savedialogue extends StatelessWidget {
  const Savedialogue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24,
              width: 24, 
              child: CupertinoActivityIndicator(),
            ),
            SizedBox(height: 10),
            Text(
              "Saving your data...",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
