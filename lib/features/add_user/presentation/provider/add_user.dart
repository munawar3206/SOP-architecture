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

  Future<void> uploadImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
    );
    if (image != null) {
      imageUrl = image.path;
    }
    notifyListeners();
  }

// add users
  Future<void> adduser() async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final image = await addUserRepository.getUserProfilePicture(File(imageUrl));

    final userdata = UserModel(name: name, age: age, image: image);
    addUserRepository.addUsers(userdata);
    notifyListeners();
  }

  // add images

  Future<void> userimage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageUrl = image.path;
    }
    notifyListeners();
  }
}
