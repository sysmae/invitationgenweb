import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterweb/kakaoMap.dart';
import 'firebase_service.dart';

class InvitationPage extends StatelessWidget {
  final String userId;
  final String invitationId;
  final FirebaseService firebaseService = FirebaseService();

  InvitationPage({Key? key, required this.userId, required this.invitationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot?>(
      future: firebaseService.getInvitation(userId, invitationId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
          return const Center(child: Text('Invitation not found'));
        }

        var invitationData = snapshot.data!.data() as Map<String, dynamic>;

        // Firestore에서 가져온 모든 데이터를 변수로 저장
        String templateId = invitationData['templateId'] ?? '';
        String groomName = invitationData['groomName'] ?? '';
        String brideName = invitationData['brideName'] ?? '';
        String weddingLocation = invitationData['weddingLocation'] ?? '';
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
        String locationX = invitationData['locationX'] ?? '';          // 추가된 변수
        String locationY = invitationData['locationY'] ?? '';          // 추가된 변수
        String locationId = invitationData['locationId'] ?? '';        // 추가된 변수
        String locationName = invitationData['locationName'] ?? '';    // 추가된 변수
        String locationUrl = invitationData['locationUrl'] ?? '';      // 추가된 변수
        String locationPhoneNumber = invitationData['locationPhoneNumber'] ?? '';  // 추가된 변수
        Timestamp createdAt = invitationData['createdAt'];
        String createdAtFormatted = createdAt.toDate().toString();


        return Scaffold(
          appBar: AppBar(
            title: Text('$groomName & $brideName'),
          ),
          body: Center(
            child: Stack(
              children: [
                // 초대장 배경 이미지
                Image.asset(
                  'assets/bg1.png', // 초대장 배경 이미지 경로
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height, // 화면 높이에 맞추기
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      // 템플릿에 맞는 페이지를 표시
                      _buildTemplate(templateId, invitationData),
                      const SizedBox(height: 20),
                      // 모든 정보 표시
                      _buildInvitationDetails(
                        weddingLocation: weddingLocation,
                        weddingDateTime: weddingDateTime,
                        additionalAddress: additionalAddress,
                        additionalInstructions: additionalInstructions,
                        groomAccountNumber: groomAccountNumber,
                        brideAccountNumber: brideAccountNumber,
                      ),
                      const SizedBox(height: 20),
                      // KakaoMap 위젯 추가
                      KakaoMap(x: locationX, y: locationY),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 초대장 상세 정보 표시 위젯
  Widget _buildInvitationDetails({
    required String weddingLocation,
    required DateTime weddingDateTime,
    required String additionalAddress,
    required String additionalInstructions,
    required String groomAccountNumber,
    required String brideAccountNumber,
  }) {
    return Column(
      children: [
        Text('Wedding Location: $weddingLocation', style: TextStyle(color: Colors.white)),
        Text('Wedding Date & Time: ${weddingDateTime.toLocal()}', style: TextStyle(color: Colors.white)),
        Text('Additional Address: $additionalAddress', style: TextStyle(color: Colors.white)),
        Text('Additional Instructions: $additionalInstructions', style: TextStyle(color: Colors.white)),
        Text('Groom Account Number: $groomAccountNumber', style: TextStyle(color: Colors.white)),
        Text('Bride Account Number: $brideAccountNumber', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildTemplate(String? templateId, Map<String, dynamic> data) {
    if (templateId == null) {
      return const Text('Template ID is missing.');
    }

    switch (templateId) {
      case '1':
        return Column(
          children: [
            Text('This is Template 1', style: TextStyle(fontSize: 24, color: Colors.white)),
            Text('Data: ${data.toString()}', style: TextStyle(color: Colors.white)),
          ],
        );
      case '2':
        return Column(
          children: [
            Text('This is Template 2', style: TextStyle(fontSize: 24, color: Colors.white)),
            Text('Data: ${data.toString()}', style: TextStyle(color: Colors.white)),
          ],
        );
      case '3':
        return Column(
          children: [
            Text('This is Template 3', style: TextStyle(fontSize: 24, color: Colors.white)),
            Text('Data: ${data.toString()}', style: TextStyle(color: Colors.white)),
          ],
        );
      default:
        return Text('Unknown Template with data: ${data.toString()}', style: TextStyle(color: Colors.white));
    }
  }
}
