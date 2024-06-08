part of 'category_list_bloc.dart';

@immutable
abstract class CategoryListEvent {}

class CategoryWiseListEvent extends CategoryListEvent {
  final ReqCategoryListModel reqCategoryListModel;

  CategoryWiseListEvent({required this.reqCategoryListModel});
}
