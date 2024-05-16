import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/features/home/presentation/view/widget/user_card.dart';
import 'package:totalxproject/features/search/presentation/provider/search_provider.dart';
import 'package:totalxproject/features/search/presentation/view/search_form.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(169, 255, 255, 255),
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              "Search Page",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            automaticallyImplyLeading: false,
            leading:
                Consumer<SearchProvider>(builder: (context, searchProvider, _) {
              return IconButton(
                  onPressed: () {
                    searchProvider.searchController.clear();
                    searchProvider.userlist.clear();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back));
            }),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SearchForm(),
                const SizedBox(
                  height: 10,
                ),
                //call userlist for  search
                Consumer<SearchProvider>(builder: (context, value, _) {
                  return value.isLoading
                      ? const Center(
                          child: CupertinoActivityIndicator(
                          color: Colors.red,
                        ))
                      : value.userlist.isEmpty
                          ? Expanded(
                              child: Center(
                                  child: Text(
                                value.searchController.text.isEmpty
                                    ? "Search users..."
                                    : "No data",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            )
                          : Expanded(
                              child: ListView.separated(
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
                                        Usercard(data: data),
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
                            );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
