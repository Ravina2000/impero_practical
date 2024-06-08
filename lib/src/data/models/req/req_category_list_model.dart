class ReqCategoryListModel {
  String? CategoryId;
  String? DeviceManufacturer;
  String? DeviceModel;
  String? DeviceToken;
  String? PageIndex;

  ReqCategoryListModel(
      {this.CategoryId, this.DeviceManufacturer, this.DeviceModel, this.DeviceToken, this.PageIndex});

  ReqCategoryListModel.fromJson(Map<String, dynamic> json) {
    CategoryId = json['CategoryId'];
    DeviceManufacturer = json['DeviceManufacturer'];
    DeviceModel = json['DeviceModel'];
    DeviceToken = json['DeviceToken'];
    PageIndex = json['PageIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CategoryId'] = CategoryId;
    data['DeviceManufacturer'] = DeviceManufacturer;
    data['DeviceModel'] = DeviceModel;
    data['DeviceToken'] = DeviceToken;
    data['PageIndex'] = PageIndex;
    return data;
  }
}