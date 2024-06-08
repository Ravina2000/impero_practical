import 'package:get_it/get_it.dart';
import 'package:ravina_impero_practical/src/data/bloc/category_list/category_list_bloc.dart';
import 'package:ravina_impero_practical/src/data/repos/category_list/category_list_repo.dart';

class GetItLocator {
  GetItLocator._internal();

  static final GetItLocator _instance = GetItLocator._internal();

  factory GetItLocator() => _instance;

  static final GetIt locator = GetIt.instance;

  static void setup() {
    locator.registerLazySingleton(() => CategoryListRepo());

    locator
        .registerFactory(() => CategoryListBloc(categoryListRepo: locator()));
  }
}
