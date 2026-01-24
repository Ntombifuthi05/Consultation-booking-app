import 'package:consultation/views/widgets/profile_details.dart';
import 'package:consultation/views/widgets/profile_details_screen.dart';
import 'package:consultation/views/widgets/profile_image.dart';
import 'package:consultation/views/widgets/update_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    _userFuture = Provider.of<FirestoreService>(context, listen: false)
        .getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          final user = snapshot.data!;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ProfileImage(image: user.image),
                const SizedBox(height: 20),
                ProfileDetails(user: user),
                const SizedBox(height: 30),
                UpdateButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileDetailsScreen(user: user),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}