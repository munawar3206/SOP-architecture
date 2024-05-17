import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/features/add_user/presentation/view/add_user.dart';
import 'package:totalxproject/features/auth/presentation/view/loginscreen/login_screen.dart';
import 'package:totalxproject/features/home/presentation/provider/get_user_provider.dart';
import 'package:totalxproject/features/home/presentation/view/widget/user_card.dart';

import 'package:totalxproject/features/search/presentation/view/search_page.dart';
import 'package:totalxproject/features/home/presentation/view/widget/sort.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                  tooltip: "Logout",
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.redAccent,
                  ))
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 233, 233, 233),
          body: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Consumer<GetUserProvider>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchScreen(),
                                    ));
                              },
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 5, top: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            (Icons.search),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text("Search Your User")
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return const SizedBox(
                                  height: 200,
                                  child: Sort(),
                                );
                              },
                            );
                          },
                          icon: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.filter_list_sharp,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "User Lists",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: (value.isLoading)
                          ? const Center(
                              child: CupertinoActivityIndicator(
                                color: Colors.red,
                              ),
                            )
                          : value.userlist.isEmpty
                              ? const Center(
                                  child: Text("No users"),
                                )
                              : ListView.separated(
                                  controller: value.scrollController,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 5,
                                    );
                                  },
                                  itemCount: value.userlist.length,
                                  itemBuilder: (context, index) {
                                    final data = value.userlist[index];
                                    return Column(
                                      children: [
                                        Usercard(
                                          data: data,
                                          index: index,
                                        ),
                                        if (index ==
                                                value.userlist.length - 1 &&
                                            value.isMoreDataLoading)
                                          const Padding(
                                            padding: EdgeInsets.all(10),
                                            child: CupertinoActivityIndicator(
                                              color: Colors.red,
                                            ),
                                          )
                                      ],
                                    );
                                  }),
                    )
                  ],
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AlertBoxWidget();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
