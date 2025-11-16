import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerc_app_with_admin/core/constant/string.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/model/catogry_model.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/model/product_model.dart';

abstract class ProductRemotDataSources {
  Future<List<CatogryModel>> getCatogry();
  Future<String> isupdate();
  Future<List<ProductModel>> getProduct({
    required final int limit,
    required int lastId,
  });
}

class ProductRemotDataSourcesImpl extends ProductRemotDataSources {
  final FirebaseFirestore _firestore;
  ProductRemotDataSourcesImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;
  //--------------------------------get Category
  @override
  Future<List<CatogryModel>> getCatogry() async {
    final data = await _firestore.collection(AppStrings.category).get();
    final docs = data.docs;
    List<CatogryModel> catogryModels = docs
        .map((doc) => CatogryModel.formJason(doc.data()))
        .toList();
    return catogryModels;
  }

  //=======================================Chekc update
  @override
  Future<String> isupdate() async {
    final datadocs = await _firestore
        .collection("meta")
        .doc(AppStrings.category)
        .get();
    final doc = datadocs.data();
    if (doc == null) {
      throw Exception(" the varible isuodate in firestore  null");
    }

    return doc["update"];
  }

  @override
  Future<List<ProductModel>> getProduct({
    required int limit,
    required int lastId,
  }) async {
    final query = _firestore
        .collection("products")
        .orderBy("id")
        .limit(limit)
        .startAfter([lastId]);

    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) {
      return <ProductModel>[];
    }
    return snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
  }
}
