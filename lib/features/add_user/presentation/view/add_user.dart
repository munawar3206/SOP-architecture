import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/features/add_user/presentation/provider/add_user_provider.dart';
import 'package:totalxproject/features/add_user/presentation/view/widget/saved_dialogue.dart';
import 'package:totalxproject/features/add_user/repo/i_adduser_impl.dart';
import 'package:totalxproject/features/home/data/model/usermodel.dart';
import 'package:totalxproject/features/home/presentation/provider/get_user_provider.dart';
import 'package:totalxproject/general/images/appimages.dart';
import 'package:totalxproject/general/service/search.dart';
import 'package:totalxproject/general/widgets/textform_widget.dart';

class AlertBoxWidget extends StatelessWidget {
  const AlertBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final addProvider = Provider.of<AddUserProvider>(context, listen: false);
    final getProvider = Provider.of<GetUserProvider>(context, listen: false);
    return Form(
      key: formkey,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add a new user",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Stack(
                children: [
                  Consumer<AddUserProvider>(
                      builder: (context, adduserProvider, child) {
                    return CircleAvatar(
                      radius: 35,
                      backgroundImage: adduserProvider.imageUrl.isNotEmpty
                          ? FileImage(File(adduserProvider.imageUrl))
                          : AssetImage(Appimages.gallimages)
                              as ImageProvider<Object>,
                    );
                  }),
                  Positioned(
                    top: 42,
                    child: Transform.rotate(
                      angle: 3.14 / 1,
                      child: const ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: 0.4,
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Color.fromARGB(165, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 32,
                    left: 12,
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          builder: (_) {
                            return SizedBox(
                              height: 200,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      "Pick Image From",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              elevation: 20,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 0, 0, 0),
                                            ),
                                            onPressed: () async {
                                              // add imagepicker for gallery
                                              await addProvider.userimage(
                                                  ImageSource.gallery);
                                            },
                                            child: Image.asset(
                                              Appimages.logImage,
                                              height: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Gallery",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              elevation: 20,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 0, 0, 0),
                                            ),
                                            // camera image
                                            onPressed: () async {
                                              await addProvider.userimage(
                                                  ImageSource.camera);
                                            },
                                            child: Image.asset(
                                              Appimages.logImage,
                                              height: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Camera",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Name : ",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormFieldWidget(
              type: TextInputType.name,
              text: "Enter name",
              controller: addProvider.nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Age : ",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormFieldWidget(
              // inputFormatter: [TextInputType.number],
              type: TextInputType.number,
              text: "Enter Age",
              controller: addProvider.ageController,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 206, 206, 206)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color.fromARGB(255, 101, 101, 101),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Consumer<AddUserProvider>(builder: (context, value, child) {
                  return Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 49, 73, 255)),
                    child: MaterialButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) ; //validation
                        if (addProvider.imageUrl.isEmpty ||
                            addProvider.nameController.text.isEmpty ||
                            addProvider.ageController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Please Fill the Fields"),
                          ));
                          return;
                        }
                        addProvider.isLoadimg = true;
                        if (addProvider.isLoadimg) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const Savedialogue();
                            },
                          );
                        }
                        final image = await AddUserRepository()
                            .getUserProfilePicture(File(value.imageUrl));
                        await value.adduser();

                        getProvider.adduserlocal(UserModel(
                            name: value.nameController.text,
                            image: image,
                            age: int.parse(value.ageController.text),
                            search: keywordsBuilder(
                                value.nameController.text.trim())));
                        Navigator.pop(context);
                        Navigator.pop(context);
                        addProvider.isLoadimg = false;

                        addProvider.clearController();
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
