import 'dart:convert';

class CatogryModel {
  final String name;
  final String image;
  final String parentid;
  final bool isFeatured;
  const CatogryModel({
    required this.name,
    required this.image,
    required this.parentid,
    required this.isFeatured,
  });
  factory CatogryModel.formJason(Map<String, dynamic> json) {
    return CatogryModel(
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      parentid: json["parentID"] ?? "",
      isFeatured: json['Isfeatured'] ?? false,
    );
  }

  Map<String, dynamic> tojson() {
    return {
      "name": name,
      "image": image,
      "parentID": parentid,
      "Isfeatured": isFeatured,
    };
  }
}
