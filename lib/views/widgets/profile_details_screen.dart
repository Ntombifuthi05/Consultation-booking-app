import 'package:consultation/models/user_model.dart';
import 'package:consultation/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_details.dart';
import 'update_button.dart';

class ProfileDetailsScreen extends StatefulWidget {
  final User user;

  const ProfileDetailsScreen({super.key, required this.user});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  late bool _isEditing;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _isEditing = false;
    _nameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final updatedUser = widget.user.copyWith(
      name: _nameController.text,
      phone: _phoneController.text,
    );

    try {
      await Provider.of<FirestoreService>(context, listen: false)
          .updateUserProfile(
            uid: updatedUser.uid,
            name: updatedUser.name,
            phone: updatedUser.phone,
          );
      setState(() => _isEditing = false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Profile' : 'My Profile'),
        actions: _isEditing
            ? [
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: _saveChanges,
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_isEditing) ...[
              const SizedBox(height: 20),
              ProfileDetails(user: widget.user),
              const SizedBox(height: 30),
              UpdateButton(
                onPressed: () => setState(() => _isEditing = true),
              ),
            ] else ...[
              _buildEditForm(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => setState(() => _isEditing = false),
                child: const Text('Cancel'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEditForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        const SizedBox(height: 16),
        TextFormField(
          initialValue: widget.user.email,
          decoration: const InputDecoration(labelText: 'Email'),
          readOnly: true,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(labelText: 'Phone'),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}