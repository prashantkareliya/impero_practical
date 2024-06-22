part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class GetCategoryEvent extends CategoryEvent {
  CategoryRequest categoryRequest;

  GetCategoryEvent(this.categoryRequest);
}


class GetSubCategoryEvent extends CategoryEvent {
  CategoryRequest categoryRequest;

  GetSubCategoryEvent(this.categoryRequest);
}

class SelectCategoryEvent extends CategoryEvent {
  Categories categories;

  SelectCategoryEvent(this.categories);
}

class GetProductEvent extends CategoryEvent {
  CategoryRequest categoryRequest;

  GetProductEvent(this.categoryRequest);
}

class SelectProductEvent extends CategoryEvent {
  ResultProduct resultProduct;

  SelectProductEvent(this.resultProduct);
}