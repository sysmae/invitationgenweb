import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'firebase_service.dart';

class HomePage extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();
  final String userId = 'KYWLzRYrpaW9LqQGucsDHGK8cih1'; // 실제 Firestore에서 사용되는 userId
  final String invitationId = 'phNnoBTnm4gIupnfpA6X'; // 실제 Firestore에서 사용되는 invitationId

  HomePage({super.key});

  Future<Map<String, dynamic>> _getInvitationData() async {
    DocumentSnapshot? invitationSnapshot = await firebaseService.getInvitation(userId, invitationId);

    if (invitationSnapshot != null && invitationSnapshot.exists) {
      return invitationSnapshot.data() as Map<String, dynamic>; // 전체 데이터 반환
    }

    throw Exception('No Data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTML Overlay with InAppWebView'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getInvitationData(), // 전체 데이터를 가져오는 Future 함수 호출
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // 로딩 중일 때 표시
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // 에러 발생 시 표시
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No Data')); // 데이터가 없을 때 표시
          }

          var invitationData = snapshot.data!; // 가져온 초대장 데이터

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

          // HTML 콘텐츠를 InAppWebView로 렌더링
          return InAppWebView(
            initialData: InAppWebViewInitialData(
              data: '''
                <!DOCTYPE html>
                  <html lang="ko">
                  <head>
                      <meta charset="UTF-8">
                      <meta name="viewport" content="width=device-width, initial-scale=1.0">
                      <title>이미지 보기</title>
                      <link rel="preconnect" href="https://fonts.googleapis.com">
                      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                      <link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
                      <style>
                          .nanum-myeongjo-regular {
                          font-family: "Nanum Myeongjo", serif;
                          font-weight: 400;
                          font-style: normal;
                          }
                      </style>
                  </head>
                  <body background="https://firebasestorage.googleapis.com/v0/b/invitationgen-7eb56.appspot.com/o/background.png?alt=media&token=71f07a58-b285-4130-bab2-00f7d8bb3919" style="height: 3000px;">
                      <h1 style="font-family: Nanum Myeongjo; text-align: center; margin-top: 100px; font-size: 30px; font-weight: 500;"><br>저희 결혼합니다</h1>
                      <div style="text-align: center; position: relative;">
                          <img src="https://firebasestorage.googleapis.com/v0/b/invitationgen-7eb56.appspot.com/o/character.png?alt=media&token=683c3711-fd7e-49d7-846d-0f0e9f6ffa2a" width="300" style="margin-top: 10px;">
                      </div>
                      <div>
                          <p style="font-family: Nanum Myeongjo; text-align: center; font-weight: 550; margin-top: 30px;">두 마음이 하나가 되는날<br>존중하며살겠습니다</p>
                      </div>
                      <div style="display: flex; gap: 20px; font-family: Nanum Myeongjo; font-weight: 500; text-align: center; justify-content: center;">
                          <p >신부<br><span style="font-size: 20px; font-weight: 650;">${invitationData['brideName'] ?? 'Unknown'}</span></p>
                          <p style="margin-top: 20px; font-size: 35px; font-weight: 550;"> & </p>
                          <p >신랑<br><span style="font-size: 20px; font-weight: 650;">${invitationData['groomName'] ?? 'Unknown'}</span></p>
                      </div>
                      <div style="height: 50px; background-color:blanchedalmond; display: flex; align-items: center; justify-content: center; color: rgb(0, 0, 0); font-family: Nanum Myeongjo;">
                          <p>${invitationData['weddingDateTime'].toDate()}</p>
                      </div>
                      
                      
                  </body>
                  </html>

              ''',
            ),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useOnLoadResource: true,
                javaScriptEnabled: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
