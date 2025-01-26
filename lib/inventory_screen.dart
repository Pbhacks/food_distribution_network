import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Management'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual inventory items
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Product ${index + 1}'),
              subtitle: Text('Quantity: ${(index + 1) * 10}'),
              trailing:
                  Text('Exp: 2024-${(index % 12) + 1}-${(index % 28) + 1}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add new inventory item
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
