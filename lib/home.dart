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
                <html lang="en">
                <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  <style>
                    * {
                      margin: 0;
                      padding: 0;
                      box-sizing: border-box;
                    }
                    body, html {
                      font-family: Arial, sans-serif;
                      margin: 0;
                      padding: 0;
                    }
                    .background-container {
                      width: 100%;
                      overflow: auto; /* Scrollable content */
                    }
                    .background-image {
                      width: 100%;
                      height: auto; /* Maintain aspect ratio */
                    }
                    .overlay {
                      position: absolute;
                      top: 50%;
                      left: 50%;
                      transform: translate(-50%, -50%);
                      color: white;
                      font-size: 24px;
                      text-align: center;
                      padding: 20px;
                      background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent background */
                      border-radius: 10px;
                    }
                  </style>
                </head>
                <body>
                  <div class="background-container">
                    <img src="https://firebasestorage.googleapis.com/v0/b/invitationgen-7eb56.appspot.com/o/bg1.png?alt=media&token=b4a9c334-fb35-49c4-a43b-cbc02aa9dc52" alt="Background Image" class="background-image">
                    <div class="overlay">
                      <h1>Groom Name: ${invitationData['groomName'] ?? 'Unknown'}</h1>
                      <h1>Bride Name: ${invitationData['brideName'] ?? 'Unknown'}</h1>
                    </div>
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
