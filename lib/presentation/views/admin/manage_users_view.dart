import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageUsersView extends StatelessWidget {
  const ManageUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy users list — replace with real controller/repository later
    final users = List.generate(
      8,
      (i) => {
        'id': '${1000 + i}',
        'name': 'User ${i + 1}',
        'email': 'user${i + 1}@example.com',
        'role': i % 3 == 0 ? 'Admin' : 'Customer',
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // TODO: wire to controller to refresh users
              Get.snackbar('Info', 'Refresh clicked');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: users.isEmpty
            ? const Center(child: Text('No users found'))
            : ListView.separated(
                itemCount: users.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(user['name']!.toString().substring(5, 6)),
                    ),
                    title: Text(user['name']!.toString()),
                    subtitle: Text(user['email']!.toString()),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'view') {
                          Get.snackbar('View', 'Viewing ${user['name']}');
                        } else if (value == 'edit') {
                          Get.snackbar('Edit', 'Edit ${user['name']}');
                        } else if (value == 'delete') {
                          Get.defaultDialog(
                            title: 'Delete user',
                            middleText: 'Delete ${user['name']}?',
                            onConfirm: () {
                              Get.back();
                              Get.snackbar(
                                'Deleted',
                                '${user['name']} deleted',
                              );
                              // TODO: call delete action
                            },
                            onCancel: () => Get.back(),
                          );
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: 'view', child: Text('View')),
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                    onTap: () {
                      // navigate to user detail if exists
                      Get.snackbar('Tapped', user['name']!.toString());
                    },
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: open add user screen
          Get.snackbar('Add', 'Open add user screen');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
