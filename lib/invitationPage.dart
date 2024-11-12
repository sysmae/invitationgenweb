import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutterweb/kakaoMap.dart'; //안씀
import 'firebase_service.dart';
import 'package:intl/intl.dart';
import 'home.dart';
import 'home2.dart';
import 'home3.dart';


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
        String locationPhoneNumber = invitationData['locationPhoneNumber'] ?? '';  // 추가된 변수
        Timestamp createdAt = invitationData['createdAt'];
        String locationUrl = invitationData['locationUrl'] ?? '';      // 카카오 지도 url
        String kakaoRoadUrl = invitationData['kakaoRoadUrl'] ?? '';    // 카카오 내비 url
        String naverRoadUrl = invitationData['naverRoadUrl'] ?? '';    // 네이버 지도 url
        final formattedDateTime = DateFormat('yyyy-MM-dd HH시 mm분').format(weddingDateTime);//날짜 시간 분만 출력
        final weddingDate = "'${DateFormat('yyyy-MM-dd').format(weddingDateTime)}'";//달력 날짜
        final weddingHours = "'${DateFormat('HH').format(weddingDateTime)}'";//달력 시간
        final weddingMinutes = "'${DateFormat('mm').format(weddingDateTime)}'";//달력 분
        String createdAtFormatted = createdAt.toDate().toString();

        return Scaffold(

          body: _buildTemplate(templateId, invitationData),


        );
      },
    );
  }

  // // 초대장 상세 정보 표시 위젯
  // Widget _buildInvitationDetails({
  //   required String weddingLocation,
  //   required DateTime weddingDateTime,
  //   required String additionalAddress,
  //   required String additionalInstructions,
  //   required String groomAccountNumber,
  //   required String brideAccountNumber,
  // }) {
  //   return Column(
  //     children: [
  //       Text('Wedding Location: $weddingLocation', style: TextStyle(color: Colors.white)),
  //       Text('Wedding Date & Time: ${weddingDateTime.toLocal()}', style: TextStyle(color: Colors.white)),
  //       Text('Additional Address: $additionalAddress', style: TextStyle(color: Colors.white)),
  //       Text('Additional Instructions: $additionalInstructions', style: TextStyle(color: Colors.white)),
  //       Text('Groom Account Number: $groomAccountNumber', style: TextStyle(color: Colors.white)),
  //       Text('Bride Account Number: $brideAccountNumber', style: TextStyle(color: Colors.white)),
  //     ],
  //   );
  // }

  Widget _buildTemplate(String? templateId, Map<String, dynamic> data) {
    if (templateId == null) {
      return const Text('Template ID is missing.');
    }

    switch (templateId) {
      case '1':
        return HomePage(data: data);
      case '2':
        return HomePage2(data: data);
      case '3':
        return HomePage3(data: data);
      default:
        return Text('Unknown Template with data: ${data.toString()}', style: TextStyle(color: Colors.white));
    }
  }
}
