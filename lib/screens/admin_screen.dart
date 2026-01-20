import 'package:flutter/material.dart';
import 'package:flutter_auth_app/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var users = <RxMap<String, dynamic>>[
      {'name': 'User 1', 'email': 'user1@test.com', 'role': 'user'}.obs,
      {'name': 'User 2', 'email': 'user2@test.com', 'role': 'user'}.obs,
      {'name': 'Admin 1', 'email': 'admin1@test.com', 'role': 'admin'}.obs,
    ];

    return Scaffold(
      appBar: CustomAppBar(title: 'Admin Dashboard'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User List (Mocked)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];

                  return Obx(() {
                    final isAdmin = user['role'] == 'admin';

                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: Icon(
                          isAdmin ? Icons.admin_panel_settings : Icons.person,
                          color: isAdmin ? Colors.orange : Colors.blue,
                        ),
                        title: Text(user['name']),
                        subtitle: Text(
                          'Role: ${user['role'].toString().toUpperCase()}',
                          style: TextStyle(
                            color: isAdmin ? Colors.orange : Colors.blue,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.change_circle_outlined),
                          tooltip: 'Change Role',
                          onPressed: () {
                            user['role'] = isAdmin ? 'user' : 'admin';

                            Get.snackbar(
                              'Role Updated',
                              '${user['name']} is now ${user['role'].toString().toUpperCase()}',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.black87,
                              colorText: Colors.white,
                              margin: const EdgeInsets.all(12),
                              duration: const Duration(seconds: 2),
                            );
                          },
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
