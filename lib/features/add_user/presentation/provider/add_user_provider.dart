import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';

import 'package:totalxproject/features/add_user/repo/i_adduser_impl.dart';

class AddUserProvider extends ChangeNotifier {
  AddUserRepository addUserRepository = AddUserRepository();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String imageUrl = "";
  bool isLoadimg = true;
// add users
  Future<void> adduser() async {
    try {
      isLoadimg = true;

      final name = nameController.text.trim();
      final age = ageController.text.trim();
      final image =
          await addUserRepository.getUserProfilePicture(File(imageUrl));

      final userdata = UserModel(
          name: name, age: int.parse(ageController.text), image: image);

      await addUserRepository.addUsers(userdata);
      isLoadimg = false;
      notifyListeners();
    } catch (e) {
      print("Error occurred: $e");
      isLoadimg = false;
      notifyListeners();
    }
  }

  // add images

  Future<void> userimage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageUrl = image.path;
      log(imageUrl);
      notifyListeners();
    }
  }
}
