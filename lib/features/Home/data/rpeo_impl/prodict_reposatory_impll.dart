import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecomerc_app_with_admin/core/constant/string.dart';
import 'package:ecomerc_app_with_admin/core/error/failure.dart';
import 'package:ecomerc_app_with_admin/core/error/firebase_exception.dart';
import 'package:ecomerc_app_with_admin/core/helper/internt_connection.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/datasourcs/product_remot_data_sources.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/datasourcs/prudic_local_data_sources.dart';
import 'package:ecomerc_app_with_admin/features/Home/data/model/catogry_model.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/entity/product_entity.dart';
import 'package:ecomerc_app_with_admin/features/Home/domain/repo/product_reposatory.dart';

class ProdictReposatoryImpll implements ProductReposatory {
  final PrudicLocalDataSources local;
  final ProductRemotDataSources remote;

  ProdictReposatoryImpll({required this.local, required this.remote});

  // =======================Fatch Category Local or remote With Ubdate
  @override
  Future<Either<Failure, List<CatogryModel>>> getCategory() async {
    try {
      if (!await TinterneteConnction.instance.isConnected()) {
        return left(Failure(AppStrings.nowInternete));
      }
      final localUpdate = local.lastUpdate();
      final remoteUpdate = await remote.isupdate();

      if (localUpdate == null) {
        await local.changeUpdate(remoteUpdate);
      }

      if (localUpdate == remoteUpdate) {
        final localData = local.getCategoryLocal();
        if (localData != null && localData.isNotEmpty) {
          return right(localData);
        }

        final remoteData = await remote.getCatogry();
        await local.updateCategory(remoteData);
        return right(remoteData);
      }

      final remoteData = await remote.getCatogry();
      await local.updateCategory(remoteData);
      await local.changeUpdate(remoteUpdate);

      return right(remoteData);
    } catch (e) {
      return left(Failure('Error fetching categories: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getallProduct({
    required int limit,
    required int lastId,
  }) async {
    try {
      final data = await remote.getProduct(lastId: lastId, limit: limit);
      return right(data);
    } on FirebaseException catch (e) {
      return left(Failure(MyFirebaseServiceException(e.code).message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
