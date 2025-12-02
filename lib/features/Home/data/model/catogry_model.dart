class CatogryModel {
  factory CatogryModel.formJason(final Map<String, dynamic> json) {
    return CatogryModel(
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      parentid: json["parentID"] ?? "",
      isFeatured: json['Isfeatured'] ?? false,
    );
  }
  const CatogryModel({
    required this.name,
    required this.image,
    required this.parentid,
    required this.isFeatured,
  });
  final String name;
  final String image;
  final String parentid;
  final bool isFeatured;

  Map<String, dynamic> tojson() {
    return {
      "name": name,
      "image": image,
      "parentID": parentid,
      "Isfeatured": isFeatured,
    };
  }
}
