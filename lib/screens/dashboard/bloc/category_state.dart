part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class LoadingCategory extends CategoryState {
  final bool isBusy;
  LoadingCategory(this.isBusy);
}

class LoadedCategory extends CategoryState {
  final Map<String, dynamic>? categoryDetail;
  List<Categories>? categoryList;
  List<SubCategories>? subCategoryList;
  List<Product>? productList;

  LoadedCategory({this.categoryDetail, this.categoryList, this.subCategoryList, this.productList});
}

class FailCategory extends CategoryState {
  final String? error;
  FailCategory({this.error});
}

class LoadedSubCategory extends CategoryState {
  List<SubCategories>? subCategoryList;
  LoadedSubCategory({this.subCategoryList});
}


class SelectCategoryState extends CategoryState {
  Categories categories;

  SelectCategoryState(this.categories);
}

class GetProductState extends CategoryState {
  List<ResultProduct>? productList;

  GetProductState({this.productList});
}

class SelectProductState extends CategoryState {
  ResultProduct resultProduct;

  SelectProductState(this.resultProduct);
}