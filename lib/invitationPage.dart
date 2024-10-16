import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase_service.dart'; // FirebaseService 클래스 임포트

class InvitationPage extends StatelessWidget {
  final String userId; // 사용자 ID
  final String invitationId; // 초대장 ID
  final FirebaseService firebaseService = FirebaseService(); // FirebaseService 인스턴스 생성

  InvitationPage({Key? key, required this.userId, required this.invitationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot?>(
      future: firebaseService.getInvitation(userId, invitationId), // FirebaseService를 통해 초대장 데이터 가져오기
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // 로딩 중
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // 오류 표시
        }
        if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
          return const Center(child: Text('Invitation not found')); // 초대장 없음
        }

        var invitationData = snapshot.data!.data() as Map<String, dynamic>;

        // Firestore에서 가져온 데이터를 기반으로 웹 페이지 생성
        return Scaffold(
          appBar: AppBar(
            title: Text('${invitationData['groomName']} & ${invitationData['brideName']}'), // groomName과 brideName 표시
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Wedding Date: ${invitationData['weddingDate'] ?? 'N/A'}'), // weddingDate 표시
                Text('Location: ${invitationData['location'] ?? 'N/A'}'), // location 표시
                // 템플릿에 맞는 페이지를 표시
                _buildTemplate(invitationData['templateId'], invitationData),
              ],
            ),
          ),
        );
      },
    );
  }

  // 템플릿에 맞는 웹페이지 UI 생성
  Widget _buildTemplate(String? templateId, Map<String, dynamic> data) {
    if (templateId == null) return const Text('Template ID is missing.');

    switch (templateId) {
      case 'template1':
        return Text('This is Template 1 with data: ${data.toString()}');
      case 'template2':
        return Text('This is Template 2 with data: ${data.toString()}');
      default:
        return Text('Unknown Template with data: ${data.toString()}');
    }
  }
}
