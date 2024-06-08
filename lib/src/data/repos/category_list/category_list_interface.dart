import 'package:ravina_impero_practical/src/data/models/req/req_category_list_model.dart';
import 'package:ravina_impero_practical/src/data/models/res/res_category_list_model.dart';

mixin CategoryListInterface {
  Future<ResCategoryListModel?>? getCategoryList(
      ReqCategoryListModel reqCategoryListModel);
}
