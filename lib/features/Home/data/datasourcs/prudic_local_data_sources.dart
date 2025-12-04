import 'package:ecomerc_app_with_admin/core/constant/string.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/model/catogry_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class PrudicLocalDataSources {
  List<CatogryModel>? getCategoryLocal();
  Future<void> updateCategory(final List<CatogryModel> categors);
  String? lastUpdate();
  Future<void> changeUpdate(final String lastUbdate);
}

class PrudicLocalDataSourcesIpml implements PrudicLocalDataSources {
  const PrudicLocalDataSourcesIpml(final Box box) : _box = box;
  final Box _box;
  @override
  List<CatogryModel>? getCategoryLocal() {
    final List data = _box.get(AppStrings.category);
    final List<CatogryModel> categors = data
        .map((final e) => CatogryModel.formJason(Map<String, dynamic>.from(e)))
        .toList();
    return categors;
  }

  //====================================Update Category
  @override
  Future<void> updateCategory(final List<CatogryModel> categors) async {
    final newList = categors.map((final e) => e.tojson()).toList();
    await _box.put(AppStrings.category, newList);
  }

  //===========================Last Update
  @override
  String? lastUpdate() {
    return _box.get("lastupdate");
  }

  //=================================Chang Update
  @override
  Future<void> changeUpdate(final String lastUbdate) async {
    _box.put("lastupdate", lastUbdate);
  }
}
