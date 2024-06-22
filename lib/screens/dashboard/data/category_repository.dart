
import 'package:impero_practical/screens/dashboard/data/category_datasource.dart';
import 'package:impero_practical/screens/dashboard/model/category_request_model.dart';
import 'package:impero_practical/screens/dashboard/model/category_response_model.dart';

import '../../../constants/constants.dart';
import '../../../constants/handle_api_error.dart';
import '../../../httpl_actions/api_result.dart';
import '../model/get_product_response.dart';

class CategoryRepository {
  CategoryRepository({required CategoryDatasource categoryDatasource})
      : _categoryDatasource = categoryDatasource;

  final CategoryDatasource _categoryDatasource;

  Future<ApiResult<CategoryResponse>> getCategory(CategoryRequest categoryRequest) async {
    try {
      final result = await _categoryDatasource.getCategory(categoryRequest: categoryRequest);

      CategoryResponse categoryResponse = CategoryResponse.fromJson(result);

      if (categoryResponse.status == ResponseStatus.success) {
        return ApiResult.success(data: categoryResponse);
      } else {
        return ApiResult.failure(error: categoryResponse.status.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }

  Future<ApiResult<CategoryResponse>> getSubCategory(CategoryRequest categoryRequest) async {
    try {
      final result = await _categoryDatasource.getCategory(categoryRequest: categoryRequest);

      CategoryResponse categoryResponse = CategoryResponse.fromJson(result);

      if (categoryResponse.status == ResponseStatus.success) {
        return ApiResult.success(data: categoryResponse);
      } else {
        return ApiResult.failure(error: categoryResponse.status.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }


  Future<ApiResult<GetProductResponse>> getProduct(CategoryRequest categoryRequest) async {
    try {
      final result = await _categoryDatasource.getProduct(categoryRequest: categoryRequest);

      GetProductResponse getProductResponse = GetProductResponse.fromJson(result);

      if (getProductResponse.status == ResponseStatus.success) {
        return ApiResult.success(data: getProductResponse);
      } else {
        return ApiResult.failure(error: getProductResponse.status.toString());
      }
    } catch (e) {
      final message = HandleAPI.handleAPIError(e);
      return ApiResult.failure(error: message);
    }
  }
}
