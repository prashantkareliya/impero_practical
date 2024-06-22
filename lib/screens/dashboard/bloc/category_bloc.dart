import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:impero_practical/screens/dashboard/data/category_repository.dart';
import 'package:impero_practical/screens/dashboard/model/category_request_model.dart';
import 'package:meta/meta.dart';

import 'package:impero_practical/screens/dashboard/model/category_response_model.dart';

import '../model/get_product_response.dart';

part 'category_event.dart';

part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {});
    on<GetCategoryEvent>((event, emit) => getCategoryData(event, emit));
    on<GetSubCategoryEvent>((event, emit) => getSubCategoryData(event, emit));

    on<SelectCategoryEvent>((event, emit) => emit(SelectCategoryState(event.categories)));
    on<SelectProductEvent>((event, emit) => emit(SelectProductState(event.resultProduct)));

    on<GetProductEvent>((event, emit) => getProductData(event, emit));
  }

  getCategoryData(GetCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(LoadingCategory(true));
    final response = await categoryRepository.getCategory(event.categoryRequest);
    response.when(success: (success) {
      emit(LoadingCategory(false));

      emit(LoadedCategory(
          categoryDetail: success.result?.toJson(),
        categoryList: success.result?.category ?? [],
       /* subCategoryList: success.result?.category?.subCategories,
          productList: success.result?.category?.subCategories.product*/
      ));
    }, failure: (failure) {
      emit(LoadingCategory(false));
      emit(FailCategory(error: failure.toString()));
    });
  }

  getSubCategoryData(GetSubCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(LoadingCategory(true));
    final response = await categoryRepository.getSubCategory(event.categoryRequest);
    response.when(success: (success) {
      emit(LoadingCategory(false));

      emit(LoadedSubCategory(
        subCategoryList: success.result?.category?.first.subCategories ?? [],
        /* subCategoryList: success.result?.category?.subCategories,
          productList: success.result?.category?.subCategories.product*/
      ));
    }, failure: (failure) {
      emit(LoadingCategory(false));
      emit(FailCategory(error: failure.toString()));
    });
  }

  getProductData(GetProductEvent event, Emitter<CategoryState> emit) async {
    emit(LoadingCategory(true));
    final response = await categoryRepository.getProduct(event.categoryRequest);
    response.when(success: (success) {
      emit(LoadingCategory(false));

      emit(GetProductState(productList: success.result));
    }, failure: (failure) {
      emit(LoadingCategory(false));
      emit(FailCategory(error: failure.toString()));
    });
  }
}
