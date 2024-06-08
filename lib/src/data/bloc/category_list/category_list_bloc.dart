import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ravina_impero_practical/src/data/constants/api_constants.dart';
import 'package:ravina_impero_practical/src/data/models/req/req_category_list_model.dart';
import 'package:ravina_impero_practical/src/data/models/res/res_category_list_model.dart';
import 'package:ravina_impero_practical/src/data/repos/category_list/category_list_repo.dart';

part 'category_list_event.dart';

part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  final CategoryListRepo categoryListRepo;

  CategoryListBloc({required this.categoryListRepo})
      : super(CategoryListInitial()) {
    on<CategoryWiseListEvent>((event, emit) async {
      ResCategoryListModel? resCategoryListModel =
          await categoryListRepo.getCategoryList(event.reqCategoryListModel);

      if (resCategoryListModel?.status != null &&
          resCategoryListModel?.status !=
              ApiConstants.statusCodeForUnauthorizedToken &&
          resCategoryListModel?.status !=
              ApiConstants.statusCodeForBadRequest &&
          resCategoryListModel?.status !=
              ApiConstants.statusCodeForInternalServerError) {
        emit(CategoryListSuccess(resCategoryListModel: resCategoryListModel!));
      } else {
        emit(CategoryListFailed(message: resCategoryListModel?.message ?? ""));
      }
    });
  }
}
