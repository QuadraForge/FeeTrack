import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context).users;

    if (users.isEmpty) {
      return const Center(
        child: Text(
          'No registered user found.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];

        return Dismissible(
          key: Key(user.name + user.apartment + index.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.redAccent,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) {
            Provider.of<UserProvider>(context, listen: false).removeUser(index);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User deleted')),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: user.isPaid ? Colors.green : Colors.red,
                child: Icon(
                  user.isPaid ? Icons.check : Icons.close,
                  color: Colors.white,
                ),
              ),
              title: Text('${user.name} ${user.surname}'),
              subtitle: Text('Apartment: ${user.apartment}  •  phone: ${user.phone}'),
              trailing: Text(
                user.isPaid ? 'Paid' : 'Not Paid',
                style: TextStyle(
                  color: user.isPaid ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
