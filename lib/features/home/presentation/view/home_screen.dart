import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/features/add_user/presentation/view/add_user.dart';
import 'package:totalxproject/features/home/presentation/provider/get_user_provider.dart';
import 'package:totalxproject/features/home/presentation/view/widget/sort.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    // final getuserProvider = Provider.of<GetUserProvider>(context);
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
                  onPressed: () async {},
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
                          child: TextFormField(
                            controller: value.searchController,
                            onChanged: (value) {
                              // homeProvider.search(value);
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search by name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                            ),
                          ),
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
                      child: value.userlist.isEmpty
                          ? Center(
                              child: Text("No data"),
                            )
                          : ListView.separated(
                              controller: value.scrollController,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 5,
                                );
                              },
                              itemCount: value.userlist.length + 1,
                              itemBuilder: (context, index) {
                                if (index < value.userlist.length) {
                                  final data = value.userlist[index];
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
                                          padding: EdgeInsets.only(
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
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data.name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      data.age.toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                } else if (value.userlist.length ==
                                    value.fetchalluser.length) {
                                  return SizedBox();
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                }
                              },
                            ),
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
                  return AlertBoxWidget();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
