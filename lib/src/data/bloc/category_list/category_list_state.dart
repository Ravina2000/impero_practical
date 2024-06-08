part of 'category_list_bloc.dart';

@immutable
abstract class CategoryListState {}

class CategoryListInitial extends CategoryListState {}

class CategoryListSuccess extends CategoryListState {
  final ResCategoryListModel resCategoryListModel;

  CategoryListSuccess({required this.resCategoryListModel});
}

class CategoryListFailed extends CategoryListState {
  final String message;

  CategoryListFailed({required this.message});
}

