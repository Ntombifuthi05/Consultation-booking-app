import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_services.dart';

class AdminRegistrationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Admin Email'),
                validator: (value) => 
                  value!.contains('@') ? null : 'Enter valid email',
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => 
                  value!.length >= 8 && value.contains('@')
                    ? null 
                    : '8+ chars with @ symbol',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _registerAdmin(context),
                child: const Text('Register Admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _registerAdmin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await Provider.of<AuthService>(context, listen: false).registerAdmin(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Admin registered successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}')),
        );
      }
    }
  }
}