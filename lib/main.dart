import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/form_screen.dart';
import 'screens/user_list_screen.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(const AidatTakipApp());
}

class AidatTakipApp extends StatelessWidget {
  const AidatTakipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'dues tracking',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dues Tracking System'),
      ),
      body: const UserListScreen(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const FormScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('New record '),
      ),
    );
  }
}
