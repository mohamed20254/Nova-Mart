import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CheckoutRemoteDataSources {
  Future<OrderModel> sendorder(final OrderModel order);
}

class CheckoutRemoteDataSourcesImpl implements CheckoutRemoteDataSources {
  CheckoutRemoteDataSourcesImpl({required final FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;
  @override
  Future<OrderModel> sendorder(final OrderModel order) async {
    final OrderModel neworder = order.copyWith(
      userId: FirebaseAuth.instance.currentUser!.uid,
    );
    final String orderid = neworder.orderId;
    final existingOrder = await _firestore
        .collection("order")
        .where("order_id", isEqualTo: orderid)
        .get();

    if (existingOrder.docs.isNotEmpty) {
      throw Exception("order is alredy exists");
    }
    final request = await _firestore.collection("order").add(neworder.toMap());
    final response = await request.get();
    return OrderModel.fromMap(response.data()!);
  }
}
