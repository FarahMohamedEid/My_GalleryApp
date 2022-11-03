class GalleryModel {

  late Data? data;
  late String status;
  late String message;

  GalleryModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null) ? Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

}

class Data{
  late List<dynamic> images;

  Data.fromJson(Map<String, dynamic> json) {
    images = json['images'].toList();
  }
}