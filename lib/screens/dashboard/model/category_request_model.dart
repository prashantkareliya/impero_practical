class CategoryRequest {
  int? categoryId;
  String? deviceManufacturer;
  String? deviceModel;
  String? deviceToken;
  int? pageIndex;
  int? SubCategoryId;

  CategoryRequest(
      {this.categoryId,
        this.deviceManufacturer,
        this.deviceModel,
        this.deviceToken,
        this.pageIndex,
        this.SubCategoryId});

  CategoryRequest.fromJson(Map<String, dynamic> json) {
    categoryId = json['CategoryId'];
    deviceManufacturer = json['DeviceManufacturer'];
    deviceModel = json['DeviceModel'];
    deviceToken = json['DeviceToken'];
    pageIndex = json['PageIndex'];
    SubCategoryId = json['SubCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoryId'] = this.categoryId;
    data['DeviceManufacturer'] = this.deviceManufacturer;
    data['DeviceModel'] = this.deviceModel;
    data['DeviceToken'] = this.deviceToken;
    data['PageIndex'] = this.pageIndex;
    data['SubCategoryId'] = this.SubCategoryId;
    return data;
  }

  Map<String, dynamic> toSubCategoryJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['CategoryId'] = this.categoryId;
    data['PageIndex'] = this.pageIndex;
    return data;
  }

  Map<String, dynamic> toProductJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['SubCategoryId'] = this.categoryId;
    data['PageIndex'] = this.pageIndex;
    return data;
  }
}