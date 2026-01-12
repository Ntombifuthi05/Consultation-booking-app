import 'package:consultation/models/user_model.dart';
import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  final User user;

  const ProfileDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailText(context, 'Name', user.name),
        const SizedBox(height: 16),
        _buildDetailText(context, 'Email', user.email),
        const SizedBox(height: 16),
        _buildDetailText(context, 'Phone', user.phone),
        const SizedBox(height: 16),
        _buildDetailText(context, 'Student ID', user.studentId),
      ],
    );
  }

  Widget _buildDetailText(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}