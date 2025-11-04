import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Address')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Manage your addresses here',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // replace with real add-address flow
                Get.snackbar('Info', 'Add address tapped');
              },
              icon: const Icon(Icons.add_location),
              label: const Text('Add Address'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    title: Text('Home'),
                    subtitle: Text('Street 123, City'),
                    leading: Icon(Icons.home),
                  ),
                  ListTile(
                    title: Text('Office'),
                    subtitle: Text('Office address here'),
                    leading: Icon(Icons.work),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
