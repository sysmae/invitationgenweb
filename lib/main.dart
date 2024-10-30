import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterweb/home.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'firebase_options.dart';
import 'package:flutterweb/invitationPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  usePathUrlStrategy(); // 경로 기반 URL 사용 설정
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/invitation/:userId/:invitationId',
          builder: (context, state) {
            String userId = state.pathParameters['userId']!;
            String invitationId = state.pathParameters['invitationId']!;
            return InvitationPage(userId: userId, invitationId: invitationId); // 초대장 페이지로 라우팅
          },
        ),
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomePage(); // 홈 페이지로 라우팅
            }),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(child: Text('Error: ${state.error}')), // 오류 처리
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
