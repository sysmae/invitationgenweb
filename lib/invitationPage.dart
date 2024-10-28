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
        // 데이터 로딩 중
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // 오류 발생
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        // 데이터 없음
        if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
          return const Center(child: Text('Invitation not found')); // 초대장 없음
        }

        var invitationData = snapshot.data!.data() as Map<String, dynamic>;

        // Firestore에서 가져온 모든 데이터를 변수로 저장
        String groomName = invitationData['groomName'];
        String brideName = invitationData['brideName'];
        String weddingLocation = invitationData['weddingLocation'];
        DateTime weddingDateTime = invitationData['weddingDateTime'].toDate();
        String additionalAddress = invitationData['additionalAddress'] ?? '';
        String additionalInstructions = invitationData['additionalInstructions'] ?? '';
        String groomAccountNumber = invitationData['groomAccountNumber'] ?? '';
        String brideAccountNumber = invitationData['brideAccountNumber'] ?? '';
        String groomFatherName = invitationData['groomFatherName'] ?? '';
        String groomFatherPhone = invitationData['groomFatherPhone'] ?? '';
        String groomMotherName = invitationData['groomMotherName'] ?? '';
        String groomMotherPhone = invitationData['groomMotherPhone'] ?? '';
        String brideFatherName = invitationData['brideFatherName'] ?? '';
        String brideFatherPhone = invitationData['brideFatherPhone'] ?? '';
        String brideMotherName = invitationData['brideMotherName'] ?? '';
        String brideMotherPhone = invitationData['brideMotherPhone'] ?? '';
        String bridePhone = invitationData['bridePhone'] ?? '';
        String groomPhone = invitationData['groomPhone'] ?? '';
        Timestamp createdAt = invitationData['createdAt'];
        String createdAtFormatted = createdAt.toDate().toString();

        return Scaffold(
          appBar: AppBar(
            title: Text('$groomName & $brideName'), // groomName과 brideName 표시
          ),
          body: Center(
            child: SingleChildScrollView( // 스크롤 가능하도록 변경
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 템플릿에 맞는 페이지를 표시
                  _buildTemplate(invitationData['templateId'], invitationData),
                  const SizedBox(height: 20),
                  // 모든 정보 표시
                  Text('Wedding Location: $weddingLocation'),
                  Text('Wedding Date & Time: $weddingDateTime'),
                  Text('Additional Address: $additionalAddress'),
                  Text('Additional Instructions: $additionalInstructions'),
                  Text('Groom Account Number: $groomAccountNumber'),
                  Text('Bride Account Number: $brideAccountNumber'),
                  Text('Groom Father: $groomFatherName, Phone: $groomFatherPhone'),
                  Text('Groom Mother: $groomMotherName, Phone: $groomMotherPhone'),
                  Text('Bride Father: $brideFatherName, Phone: $brideFatherPhone'),
                  Text('Bride Mother: $brideMotherName, Phone: $brideMotherPhone'),
                  Text('Bride Phone: $bridePhone'),
                  Text('Groom Phone: $groomPhone'),
                  Text('Created At: $createdAtFormatted'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 템플릿에 맞는 웹페이지 UI 생성
  Widget _buildTemplate(String? templateId, Map<String, dynamic> data) {
    if (templateId == null) {
      return const Text('Template ID is missing.');
    }

    // templateId가 Firestore에서 유효한지 확인
    switch (templateId) {
      case '1':
      // 템플릿 1에 대한 UI
        return Column(
          children: [
            Text('This is Template 1', style: TextStyle(fontSize: 24)),
            // 데이터에 따라 추가 UI 요소를 구성할 수 있음
            Text('Data: ${data.toString()}'),
          ],
        );
      case '2':
      // 템플릿 2에 대한 UI
        return Column(
          children: [
            Text('This is Template 2', style: TextStyle(fontSize: 24)),
            Text('Data: ${data.toString()}'),
          ],
        );
      case '3':
      // 템플릿 3에 대한 UI
        return Column(
          children: [
            Text('This is Template 3', style: TextStyle(fontSize: 24)),
            Text('Data: ${data.toString()}'),
          ],
        );
      default:
      // 알 수 없는 템플릿 ID 처리
        return Text('Unknown Template with data: ${data.toString()}');
    }
  }
}
