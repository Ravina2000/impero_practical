import 'package:flutter/material.dart';
import 'package:ravina_impero_practical/src/data/bloc/category_list/category_list_bloc.dart';
import 'package:ravina_impero_practical/src/data/constants/app_strings.dart';
import 'package:ravina_impero_practical/src/data/models/req/req_category_list_model.dart';
import 'package:ravina_impero_practical/src/data/models/res/res_category_list_model.dart';
import 'package:ravina_impero_practical/src/locator/get_it_locator.dart';
import 'package:ravina_impero_practical/src/ui/screens/ceramic_category/ceramic_category_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  CategoryListBloc categoryListBloc = GetItLocator.locator<CategoryListBloc>();

  List<Category> categoryList = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _blocRequestAdd();
    _setupListener();
  }

  Future<void> _blocRequestAdd() async {
    categoryListBloc.add(
      CategoryWiseListEvent(
        reqCategoryListModel: ReqCategoryListModel(
            CategoryId: "0",
            DeviceManufacturer: "Google",
            DeviceModel: "Android SDK built for x86",
            DeviceToken: "",
            PageIndex: "1"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: categoryList.length,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: const Center(
                  child: Text(
                AppStrings.impero,
                style: TextStyle(color: Colors.white),
              )),
              actions: const [
                Icon(
                  Icons.filter_alt,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ],
              bottom: isLoading
                  ? null
                  : TabBar(
                      isScrollable: true,
                      padding: EdgeInsets.zero,
                      tabs: categoryList
                          .map((Category category) => Tab(
                                child: Text(
                                  category.name ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ))
                          .toList(),
                      labelStyle: const TextStyle(color: Colors.black),
                      unselectedLabelStyle: const TextStyle(color: Colors.grey),
                      indicatorColor: Colors.blue,
                    ),
            ),
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: categoryList.asMap().entries.map((entry) {
                      int index = entry.key;
                      Category category = entry.value;

                      if (index == 1) {
                        return const CeramicCategoryScreen();
                      } else {
                        return Center(
                          child: Text('${category.name} Category'),
                        );
                      }
                    }).toList(),
                  ),
          ),
        ),
      ),
    );
  }

  void _setupListener() {
    categoryListBloc.stream.listen((state) {
      if (state is CategoryListSuccess) {
        setState(() {
          isLoading = false;
        });
        categoryList = state.resCategoryListModel.result?.category ?? [];
      } else if (state is CategoryListFailed) {
        print(state.message);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    categoryList.clear();
  }
}
