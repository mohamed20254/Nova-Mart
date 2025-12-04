import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerc_app_with_admin/features/orders/data/model/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OrderRemoteDs {
  Stream<List<OrderModel>> watchOrders();
}

class OrderRemoteDSImpl implements OrderRemoteDs {
  OrderRemoteDSImpl({required final FirebaseFirestore firestore})
    : _firestore = firestore;
  final FirebaseFirestore _firestore;

  @override
  Stream<List<OrderModel>> watchOrders() {
    final String userid = FirebaseAuth.instance.currentUser!.uid;
    return _firestore
        .collection("order")
        .where("user_id", isEqualTo: userid)
        .snapshots()
        .map((final query) {
          return query.docs.map((e) => OrderModel.fromMap(e.data())).toList();
        });
  }
}
