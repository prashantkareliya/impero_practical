

import 'package:impero_practical/screens/dashboard/model/category_request_model.dart';

import '../../../constants/constants.dart';
import '../../../httpl_actions/app_http.dart';

class CategoryDatasource extends HttpActions {

  Future<dynamic> getCategory({required CategoryRequest categoryRequest}) async {
    final response = await postMethod(ApiEndPoint.dashBoard,
        data: categoryRequest.toJson());
    print("Category List $response");
    return response;
  }

  Future<dynamic> getSubCategory({required CategoryRequest categoryRequest}) async {
    final response = await postMethod(ApiEndPoint.dashBoard,
        data: categoryRequest.toSubCategoryJson());
    print("Sub Category List $response");
    return response;
  }

  Future<dynamic> getProduct({required CategoryRequest categoryRequest}) async {
    final response = await postMethod(ApiEndPoint.productList,
        data: categoryRequest.toProductJson());
    print("Product List List $response");
    return response;
  }
}