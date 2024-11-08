import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart'; //DateFormat 사용하기 위한 라이브러리
import 'firebase_service.dart';
import 'kakaoMap.dart';

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
          String locationPhoneNumber = invitationData['locationPhoneNumber'] ?? '';  // 추가된 변수
          Timestamp createdAt = invitationData['createdAt'];

          String locationUrl = invitationData['locationUrl'] ?? '';      // 카카오 지도 url
          String kakaoRoadUrl = invitationData['kakaoRoadUrl'] ?? '';    // 카카오 내비 url
          String naverRoadUrl = invitationData['naverRoadUrl'] ?? '';    // 네이버 지도 url
          final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(weddingDateTime); //시간 분만 출력


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
                  <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c7f14517962ce3117e2ec63ae4cd7d54&libraries=services"></script>
                  <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
                  <title>이미지 보기</title>
                  <link rel="preconnect" href="https://fonts.googleapis.com">
                  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                  <link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
                  <link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
                  <style>
                  
              
                  
                      .nanum-myeongjo-regular {
                      font-family: "Nanum Myeongjo", serif;
                      font-weight: 400;
                      font-style: normal;
                      }
              
                      .yeon-sung-regular {
                      font-family: "Yeon Sung", system-ui;
                      font-weight: 400;
                      font-style: normal;
                      }
              
                      .fading-box {
                      padding: 10px 20px;
                      background-color: #FAE1D0; 
                      text-align: center;
                      font-size: 24px;
                      font-family: "Yeon Sung";
                      color: #000; 
                      box-shadow: 0 0 50px rgba(255, 255, 255, 0.2);
                      border-radius: 10px; 
                      margin-left: 35%;
                      margin-right: 35%;
                      }
              
                      .groombutton {
                      background-color: #87CEEB; /* 라이트 블루 색상 */
                      color: white;
                      font-size: 24px;
                      padding: 8px 12px; /* 버튼 안쪽 여백 */
                      border-radius: 20px;
                      text-decoration: none;
                      }
              
                      .bridgebutton {
                      background-color: #ffdc92; /* 라이트 블루 색상 */
                      color: white;
                      font-size: 24px;
                      padding: 8px 12px; /* 버튼 안쪽 여백 */
                      border-radius: 20px;
                      text-decoration: none;
                      }
              
              
                      .container {
                      display: flex;
                      justify-content: center; /* 수평 가운데 정렬 */
                      align-items: center; /* 수직 가운데 정렬 */
                      gap: 8px; /* 두 텍스트 간격 */
                      font-family: Arial, sans-serif;
                       }

                      .buttons {
                          box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                          display: flex;
                          justify-content: space-around;
                          margin-left: 15%;
                          margin-right: 15%;
                          background-color: #fff;
                          padding: 15px;
                      }
              
                      .button {
                          text-align: center;
                          font-size: 12px;
                          color: #333;
                          text-decoration: none;
                      }
                      
                      .locationText {
                          text-align: center;
                          font-size: 20px;
                          color: #333;
                          text-decoration: none;
                      }
              
                      .button img {
                          width: 40px;
                          height: 40px;
                          margin-bottom: 4px;
                      }
                      
                      .map-container {
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        width: 100%;
                        }
                  
                    #map {
                      width: 70%;
                      height: 300px;
                      background-color: #fff;

                    }
                    
                   .contact-container {
                      display: flex;
                      align-items: center;
                      justify-content: space-between;
                      padding: 15px;
                      background-color: #fff;
                      border-top-left-radius: 15px;
                      border-top-right-radius: 15px;
                      width: 563px;
                      box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                      font-family: Nanum Myeongjo; 
                      font-size: 25px;
                      margin-left:15%;
                      margin-top: 10%;
                    }
                
                    .contact-info {
                      font-family: Arial, sans-serif;
                      color: #333;
                    }
                
                    .contact-info h3 {
                      margin: 0;
                      font-size: 18px;
                      font-weight: bold;
                    }
                
                    .contact-info p {
                      margin: 5px 0;
                      color: #888;
                      font-size: 14px;
                    }
                
                    .contact-icon {
                      width: 40px;
                      height: 40px;
                      border-radius: 50%;
                      display: flex;
                      align-items: center;
                      justify-content: center;
                    }
                
                    .contact-icon img {
                      width: 40px;
                      height: 40px;
                    }

              
              
                  </style>
              </head>
              <body background="https://firebasestorage.googleapis.com/v0/b/invitationgen-7eb56.appspot.com/o/background.png?alt=media&token=71f07a58-b285-4130-bab2-00f7d8bb3919" style="height: 4000px;">
                  <h1 style="font-family: Yeon Sung; text-align: center; margin-top: 100px; font-size: 50px; font-weight: 500;"><br>저희 결혼합니다</h1>
                  <div style="text-align: center; position: relative;">
                      <img src="https://firebasestorage.googleapis.com/v0/b/invitationgen-7eb56.appspot.com/o/character.png?alt=media&token=683c3711-fd7e-49d7-846d-0f0e9f6ffa2a" width="300" style="margin-top: 10px;">
                  </div>
                  <div>
                      <p style="font-family: Yeon Sung; text-align: center; font-weight: 550; margin-top: 30px; font-size: 30px;">두 마음이 하나가 되는날<br>존중하며 살겠습니다</p>
                  </div>
                  <div style="display: flex; gap: 50px; font-family: Yeon Sung; font-weight: 500; text-align: center; justify-content: center; ">
                      <p style="font-size: 20px;">신부<br><span style="font-size: 30px; font-weight: 500;">${groomName}</span></p>
                      <p style="margin-top: 30px; font-size: 50px; font-weight: 550;"> & </p>
                      <p style="font-size: 20px;">신랑<br><span style="font-size: 30px; font-weight: 500;">${brideName}</span></p>
                  </div>
                  <div class = "fading-box">
                      ${formattedDateTime}
                  </div>
                      
              
                  <div style="text-align: center; font-family: Nanum Myeongjo; font-size: 25px; margin-top: 20%;">
                      <p style="margin: 0;">초대합니다</p>
                      <hr style="width: 20%; margin: 5px auto 0; border: none; border-top: 2px solid #999;">
                    </div>
                    
                    <div>
                      <p style="font-family: Yeon Sung; text-align: center; margin-top: 20px; font-size: 30px; font-weight: 500;"><br>저희 두 사람의 결혼식에 모시고자 합니다 <br><br> 먼 길 힘드시겠지만, 꼭 참석하여 그동안 쌓아온<br>인생의 경험과 강인함을 저희와 공유해 주시길 부탁드립니다
                  <br>여러분들의 가르침을 따라 올바르게 앞을 향해 나아가겠습니다.<br><br>함께하시어 행복을 더해주시길 기대합니다</p>
                    </div>
              
                  <div style="display: flex; gap: 20%; font-family: Nanum Myeongjo; font-weight: 500; text-align: center; justify-content: center; margin-top: 5%;">
                      <p style="font-size: 40px;"><span style="color: #8b8b8b;">신랑&nbsp</span> ${groomName}<br><span style="font-size: 30px; font-weight: 500;"> ${groomPhone}</span></p>
                      <p style="font-size: 40px;"><span style="color: #8b8b8b;">신부&nbsp</span> ${brideName}<br><span style="font-size: 30px; font-weight: 500;">${bridePhone}</span></p>
                  </div>
                  
                  
              
                  <div style="text-align: center; font-family: Nanum Myeongjo; font-size: 25px; margin-top: 15%;">
                      <p style="margin: 0;">혼주 연락처</p>
                      <hr style="width: 20%; margin: 5px auto 0; border: none; border-top: 2px solid #999;">
                  </div>
                  
                  <div style="display: flex; gap: 30%; font-size: 30px; font-family: Nanum Myeongjo; font-weight: 600; text-align: center; justify-content: center; margin-top: 5%;">
                      <p style="color: #87CEEB;">신랑 측</p>
                      <p style="color: #ffdc92;">신부 측</p>
                  </div>
              
                  <div style="display: flex; gap: 20%; font-family: Nanum Myeongjo; font-weight: 500; text-align: center; justify-content: center; ">
                      <p ><span style="font-size: 30px; color: #8b8b8b;">아버지&nbsp</span> <span style="font-size: 40px; color: #000000;">&nbsp ${groomFatherName} </span>
                          <br><span style="font-size: 30px; font-weight: 500;">${groomFatherPhone}</span>
                          <br><br><br><br><br><span style="font-size: 30px; color: #8b8b8b;">어머니&nbsp</span> <span style="font-size: 40px; color: #000000;">&nbsp ${groomMotherName} </span>
                          <br><span style="font-size: 30px; font-weight: 500;">${groomMotherPhone}</span></p>
                      <p ><span style="font-size: 30px; color: #8b8b8b;">아버지&nbsp</span> <span style="font-size: 40px; color: #000000;">&nbsp${brideFatherName}</span>
                          <br><span style="font-size: 30px; font-weight: 500;">${brideFatherPhone}</span>
                          <br><br><br><br><br><span style="font-size: 30px; color: #8b8b8b;">어머니&nbsp</span> <span style="font-size: 40px; color: #000000;">&nbsp${brideMotherName}</span>
                          <br><span style="font-size: 30px; font-weight: 500;">${brideMotherPhone}</span></p>
                  </div>
              
                  <div style="text-align: center; font-family: Nanum Myeongjo; font-size: 25px; margin-top: 15%;">
                      <p style="margin: 0;">오시는 길</p>
                      <hr style="width: 20%; margin: 5px auto 0; border: none; border-top: 2px solid #999;">
                  </div>
                  
                  
                  <div class="contact-container">
                    <div class="contact-info">
                      <h3>${locationName}</h3>
                      <p>${weddingLocation}</p>
                      <p>Tel. ${locationPhoneNumber}</p>
                    </div>
                    <div class="contact-icon">
                      <img src="https://firebasestorage.googleapis.com/v0/b/invitationgen-7eb56.appspot.com/o/telephone.png?alt=media&token=3a74b98c-6cce-48d7-ae85-61160deb1201" alt="전화 아이콘">
                    </div>
                  </div>
                  
              
                  <div class="map-container">
                    <div id="map"></div>
                  </div>
                    <script>
                    console.log(`x: ${locationX} y:${locationY}`);
                      var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
                          mapOption = { 
                              center: new kakao.maps.LatLng(${locationY}, ${locationX}), // 위도와 경도를 기반으로 지도 중심 좌표 설정
                              level: 3 // 지도의 확대 레벨
                          };
                      
                      var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성
            
                      // 지정된 좌표에 마커 생성
                      var marker = new kakao.maps.Marker({
                        map: map,
                        position: new kakao.maps.LatLng(${locationY}, ${locationX}) 
                      });
                    </script>
              
                  <div class="buttons">
                      
                      <a href="$kakaoRoadUrl" target="_blank" class="button">
                      <img src="https://firebasestorage.googleapis.com/v0/b/invitationgen-7eb56.appspot.com/o/kakaonavi.png?alt=media&token=a01713a6-24d4-4249-bf33-e2f4e207fd65/40x40" alt="카카오내비 아이콘"> <!-- 실제 카카오내비 아이콘 URL로 대체 -->
                      <div>카카오내비</div>
                      </a>
                      <a href="$naverRoadUrl" target="_blank" class="button">
                      <img src="https://firebasestorage.googleapis.com/v0/b/invitationgen-7eb56.appspot.com/o/naver_map.png?alt=media&token=7869e6d4-8bc8-41e6-aecb-d7abec3c81b7/40x40" alt="네이버지도 아이콘"> <!-- 실제 네이버지도 아이콘 URL로 대체 -->
                      <div>네이버지도</div>
                      </a>
                      <a href="$locationUrl" target="_blank" class="button">
                      <img src="https://firebasestorage.googleapis.com/v0/b/invitationgen-7eb56.appspot.com/o/kakao_map.png?alt=media&token=a6a7fdbc-5e5d-4718-bf15-4e8d967aa06d/40x40" alt="카카오맵 아이콘"> <!-- 실제 카카오맵 아이콘 URL로 대체 -->
                      <div>카카오맵</div>
                      </a>
                      
                  </div>
                  
               
                  
                  <div style="text-align: center; font-family: Nanum Myeongjo; font-size: 25px; margin-top: 30%;">
                      <p style="margin: 0;">마음 전하기</p>
                      <hr style="width: 20%; margin: 5px auto 0; border: none; border-top: 2px solid #999;">
                      <p style="font-family: Yeon Sung; text-align: center; margin-top: 40px; margin-bottom: 100px; font-size: 30px; font-weight: 400;">축하의 마음을 전해주세요</p>
                  </div>
                  
              
                  <div class="container">
                      <span style="font-family: Nanum Myeongjo; font-size: 30px; color: #8b8b8b;">신랑 측&nbsp&nbsp&nbsp&nbsp</span>
                      <div class="groombutton">축의금으로 마음 전하기</div>
                  </div>
              
                  <div class="container" style="margin-top: 40px;">
                      <span style="font-family: Nanum Myeongjo; font-size: 30px; color: #8b8b8b;">신부 측&nbsp&nbsp&nbsp&nbsp</span>
                      <div class="bridgebutton">축의금으로 마음 전하기</div> 
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