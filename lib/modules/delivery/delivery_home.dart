import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/delivery_provider.dart';

class DeliveryHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deliveryProvider = Provider.of<DeliveryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Delivery Dashboard')),
      body: ListView.builder(
        itemCount: deliveryProvider.orders.length,
        itemBuilder: (_, index) {
          final order = deliveryProvider.orders[index];
          return ListTile(
            title: Text('Order ID: ${order['id']}'),
            subtitle: Text('Status: ${order['status']}'),
            trailing: ElevatedButton(
              child: Text('Mark Delivered'),
              onPressed: () {
                deliveryProvider.updateStatus(order['id'], 'Delivered');
              },
            ),
          );
        },
      ),
    );
  }
}

