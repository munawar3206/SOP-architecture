import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';
import 'package:totalxproject/features/add_user/repo/i_adduser_impl.dart';
import 'package:totalxproject/general/service/search.dart';
import 'package:totalxproject/general/service/showmessage.dart';

class AddUserProvider extends ChangeNotifier {
  AddUserRepository addUserRepository = AddUserRepository(); //service
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String imageUrl = "";
  bool isLoadimg = true;
  //add user
  Future<void> adduser() async {
    isLoadimg = true; //when save 

    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final image = await addUserRepository.getUserProfilePicture(File(imageUrl));

    final userdata = UserModel(
        search: keywordsBuilder(name),
        name: name,
        age: int.parse(age),
        image: image);

    final data = await addUserRepository.addUsers(userdata);
    data.fold(
      (l) {
        if (l == "Failed! Try again") {
          showMessage(l);
        }
      },
      (r) {
        if (r == "Added Successfully") {
          showMessage(r);
        }
      },
    );

    isLoadimg = false;
    notifyListeners();
  }

  //clear data from controller
  void clearController() {
    nameController.clear();
    ageController.clear();
    imageUrl = '';
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
