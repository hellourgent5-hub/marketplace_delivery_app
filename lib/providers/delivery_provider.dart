import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryProvider extends ChangeNotifier {
  final CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('orders');

  List<Map<String, dynamic>> orders = [];

  DeliveryProvider() {
    fetchAssignedOrders();
  }

  void fetchAssignedOrders() {
    ordersCollection
        .where('deliveryManAssigned', isEqualTo: true) // or deliveryManId
        .snapshots()
        .listen((snapshot) {
      orders = snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
      notifyListeners();
    });
  }

  Future<void> updateStatus(String orderId, String status) async {
    await ordersCollection.doc(orderId).update({'status': status});
  }
}

