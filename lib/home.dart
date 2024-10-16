import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_service.dart'; // FirebaseService 클래스 임포트
import 'firebase_options.dart'; // Firebase 옵션 파일 임포트

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Firebase 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(), // HomePage로 변경
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DocumentSnapshot? invitation; // 초대장 데이터 저장할 변수
  final String userId = 'gdResudXNOXAGnWzzMyQ8tAfUf62'; // 사용자 ID
  final String invitationId = 'H5QdfCowjaN5mlZVRchz'; // 초대장 ID
  final FirebaseService firebaseService = FirebaseService(); // FirebaseService 인스턴스 생성

  @override
  void initState() {
    super.initState();
    fetchInvitation(); // 초대장 가져오기
  }

  Future<void> fetchInvitation() async {
    DocumentSnapshot? fetchedInvitation = await firebaseService.getInvitation(userId, invitationId);

    setState(() {
      invitation = fetchedInvitation; // 초대장 데이터 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('초대장 페이지'), // 제목 변경
      ),
      body: Center(
        child: invitation == null
            ? const CircularProgressIndicator() // 로딩 중
            : ListTile(
          title: Text(invitation!['groomName'] ?? 'Groom Name'), // groomName 필드
          subtitle: Text(invitation!['brideName'] ?? 'Bride Name'), // brideName 필드
        ),
      ),
    );
  }
}
