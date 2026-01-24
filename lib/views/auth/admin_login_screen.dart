import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/route_manager.dart';
import '../../services/auth_services.dart';

class AdminLoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Admin Login')),
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
                  value!.length >= 8 ? null : 'Minimum 8 characters',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _loginAdmin(context),
                child: const Text('Login as Admin'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteManager.adminRegistration);
                },
                child: const Text('Register as Admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginAdmin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await Provider.of<AuthService>(context, listen: false).login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        
        // Verify admin role after login
        final isAdmin = await Provider.of<AuthService>(context, listen: false)
          .isCurrentUserAdmin();
        
        if (isAdmin) {
          Navigator.pushReplacementNamed(context, RouteManager.adminDashboard);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Not an admin account')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.toString()}')),
        );
      }
    }
  }
}