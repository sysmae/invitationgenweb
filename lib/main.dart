import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'firebase_options.dart';
import 'package:flutterweb/invitationPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: '/invitation/gdResudXNOXAGnWzzMyQ8tAfUf62/H5QdfCowjaN5mlZVRchz',
      routes: [
        GoRoute(
          path: '/invitation/:userId/:invitationId',
          builder: (context, state) {
            String userId = state.pathParameters['userId']!;
            String invitationId = state.pathParameters['invitationId']!;
            return InvitationPage(userId: userId, invitationId: invitationId);
          },
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(child: Text('Error: ${state.error}')),
      ),
    );

    return MaterialApp.router(
      routerConfig: _router,
      title: '초대장 생성 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
