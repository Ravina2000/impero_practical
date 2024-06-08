import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ravina_impero_practical/src/data/constants/api_constants.dart';
import 'package:ravina_impero_practical/src/data/helpers/api_helper.dart';
import 'package:ravina_impero_practical/src/data/models/req/req_category_list_model.dart';
import 'package:ravina_impero_practical/src/data/models/res/res_category_list_model.dart';
import 'package:ravina_impero_practical/src/data/repos/category_list/category_list_interface.dart';

class CategoryListRepo implements CategoryListInterface {
  final APIHelper _apiHelper = APIHelper();
  final http.Client httpClient = http.Client();

  @override
  Future<ResCategoryListModel?>? getCategoryList(
      ReqCategoryListModel reqCategoryListModel) async {
    try {
      final response = await _apiHelper.post(
          path: ApiConstants.categoryList,
          httpClient: httpClient,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: reqCategoryListModel.toJson());
      ResCategoryListModel? resCategoryListModel =
          ResCategoryListModel.fromJson(jsonDecode(response?.body ?? ""));
      return resCategoryListModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
