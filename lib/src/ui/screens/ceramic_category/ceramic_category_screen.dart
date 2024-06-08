import 'package:flutter/material.dart';
import 'package:ravina_impero_practical/src/data/bloc/category_list/category_list_bloc.dart';
import 'package:ravina_impero_practical/src/data/models/req/req_category_list_model.dart';
import 'package:ravina_impero_practical/src/data/models/res/res_category_list_model.dart';
import 'package:ravina_impero_practical/src/locator/get_it_locator.dart';

class CeramicCategoryScreen extends StatefulWidget {
  const CeramicCategoryScreen({super.key});

  @override
  State<CeramicCategoryScreen> createState() => _CeramicCategoryScreenState();
}

class _CeramicCategoryScreenState extends State<CeramicCategoryScreen> {
  CategoryListBloc categoryListBloc = GetItLocator.locator<CategoryListBloc>();

  List<Category> categoryList = [];
  List<SubCategories> subCategoryList = [];
  bool isLoading = true, isSubCategoryLoaded = false;
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _setupListener();
    _blocRequestAdd();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _blocRequestAdd() async {
    categoryListBloc.add(
      CategoryWiseListEvent(
        reqCategoryListModel: ReqCategoryListModel(
            CategoryId: "56",
            DeviceManufacturer: "Google",
            DeviceModel: "Android SDK built for x86",
            DeviceToken: "",
            PageIndex: currentPage.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            subCategoryList.length,
            (i) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (subCategoryList[i].name!)
                      .split(RegExp(r'\s+'))
                      .first
                      .toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategoryList[i].product!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final Product productData =
                          subCategoryList[i].product![index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    productData.imageName ?? "",
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0, vertical: 3.0),
                                  margin: const EdgeInsets.only(
                                      top: 5.0, left: 5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.blue[300]),
                                  child: Text(
                                    productData.priceCode ?? "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              (productData.name!)
                                  .split(RegExp(r'\s+'))
                                  .first
                                  .toUpperCase(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setupListener() {
    categoryListBloc.stream.listen((state) {
      if (state is CategoryListSuccess) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }

        List<SubCategories> newSubCategoryList = [];

        categoryList = state.resCategoryListModel.result?.category ?? [];

        // Extract subcategories from each category
        for (var category in categoryList) {
          if (category.subCategories != null) {
            newSubCategoryList.addAll(category.subCategories ?? []);
          }
        }

        // Append new data only if there are subcategories available
        if (newSubCategoryList.isNotEmpty) {
          setState(() {
            isSubCategoryLoaded = true;
            subCategoryList.addAll(newSubCategoryList); // Append new data
          });
        }
      } else if (state is CategoryListFailed) {
        print(state.message);
      }
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // Reached the end of the list
      currentPage++; // Increment page index
      _blocRequestAdd(); // Fetch more data
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    categoryList.clear();
    subCategoryList.clear();
  }
}
