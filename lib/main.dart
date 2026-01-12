import 'package:consultation/routes/route_manager.dart';
import 'package:consultation/services/auth_services.dart';
import 'package:consultation/services/firestore_service.dart';
import 'package:consultation/viewmodels/auth_viewmodel.dart';
import 'package:consultation/viewmodels/consultation_view_model.dart';
import 'package:consultation/viewmodels/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyClMwvWVS1631CxUyiOhGE3O43fQGXRg-Q",
  authDomain: "consultation-a8d3c.firebaseapp.com",
  projectId: "consultation-a8d3c",
  storageBucket: "consultation-a8d3c.firebasestorage.app",
  messagingSenderId: "1062511445718",
  appId: "1:1062511445718:web:52a5e66f268c81122bab77",
  measurementId: "G-QF3VMNBRTT"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ConsultationViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        Provider(create: (_) => FirestoreService()), 
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthViewModel>(context, listen: false).checkAuthState();
    });

    return MaterialApp(
      title: 'Consultation Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
      initialRoute: RouteManager.loginPage,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}