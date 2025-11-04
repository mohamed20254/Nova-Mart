import 'package:ecomerc_app_with_admin/core/constant/string.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/model/catogry_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class PrudicLocalDataSources {
  List<CatogryModel>? getCategoryLocal();
  Future<void> updateCategory(List<CatogryModel> categors);
  String? lastUpdate();
  Future<void> changeUpdate(final String lastUbdate);
}

class PrudicLocalDataSourcesIpml implements PrudicLocalDataSources {
  final Box _box;
  const PrudicLocalDataSourcesIpml(final Box box) : _box = box;
  @override
  List<CatogryModel>? getCategoryLocal() {
    final List data = _box.get(AppStrings.category);
    List<CatogryModel>? categors = data
        .map((e) => CatogryModel.formJason(Map<String, dynamic>.from(e)))
        .toList();
    return categors;
  }

  //====================================Update Category
  @override
  Future<void> updateCategory(List<CatogryModel> categors) async {
    final newList = categors.map((e) => e.tojson()).toList();
    await _box.put(AppStrings.category, newList);
  }

  //===========================Last Update
  @override
  String? lastUpdate() {
    return _box.get("lastupdate");
  }

  //=================================Chang Update
  @override
  Future<void> changeUpdate(String lastUbdate) async {
    _box.put("lastupdate", lastUbdate);
  }
}
