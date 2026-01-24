import 'package:consultation/models/consultation_model.dart';
import 'package:consultation/routes/route_manager.dart';
import 'package:consultation/services/firestore_service.dart';
import 'package:consultation/viewmodels/auth_viewmodel.dart';
import 'package:consultation/viewmodels/consultation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    final consultations = Provider.of<ConsultationViewModel>(context)
        .getUserConsultations(auth.user?.uid ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${auth.user?.name ?? ''}'),
        actions: [
          // Profile icon in app bar - now properly handles navigation
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => _navigateToProfile(context, firestoreService),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.logout();
              Navigator.pushReplacementNamed(context, RouteManager.loginPage);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
            context, RouteManager.addConsultationPage),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Consultation>>(
        stream: consultations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final consultationsList = snapshot.data ?? [];

          if (consultationsList.isEmpty) {
            return const Center(child: Text('No consultations booked yet'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: consultationsList.length,
            itemBuilder: (context, index) {
              final consultation = consultationsList[index];
              return Card(
                child: ListTile(
                  title: Text(consultation.title),
                  subtitle: Text(
                    '${consultation.lecturer} - ${consultation.date.toString()}',
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    RouteManager.consultationDetailsPage,
                    arguments: consultation,
                  ),
                ),
              );
            },
          );
        },
      ),
       bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 1) {
            _navigateToProfile(context, firestoreService);
          }
        },
      ),
    );
  }

 Future<void> _navigateToProfile(
    BuildContext context,
    FirestoreService firestoreService,
  ) async {
    try {
      final user = await firestoreService.getCurrentUser();
      if (!mounted) return;
      
      await Navigator.pushNamed(
        context,
        RouteManager.profileDetailsPage,
        arguments: user,
      );
      
      setState(() => _currentIndex = 0);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load profile: $e')),
      );
    }
  }
}