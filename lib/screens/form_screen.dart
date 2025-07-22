import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedApartment = '1';
  bool _aidatPaid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Username')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty ? 'Name required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _surnameController,
                    decoration: const InputDecoration(
                      labelText: 'Surname',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty ? 'Surname required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'phone',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Flat number',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedApartment,
                    items: List.generate(20, (index) {
                      return DropdownMenuItem(
                        value: '${index + 1}',
                        child: Text('${index + 1}. Apartment'),
                      );
                    }),
                    onChanged: (value) {
                      setState(() => _selectedApartment = value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Has the dues been paid?'),
                    value: _aidatPaid,
                    onChanged: (val) => setState(() => _aidatPaid = val),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text('save'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final user = UserModel(
                            name: _nameController.text,
                            surname: _surnameController.text,
                            phone: _phoneController.text,
                            apartment: _selectedApartment,
                            isPaid: _aidatPaid,
                          );
                          Provider.of<UserProvider>(context, listen: false)
                              .addUser(user);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User added')),
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
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
