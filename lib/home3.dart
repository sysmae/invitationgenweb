import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart'; //DateFormat 사용하기 위한 라이브러리
// import 'firebase_service.dart';

class HomePage3 extends StatelessWidget {
  // final FirebaseService firebaseService = FirebaseService();
  // final String userId = 'KYWLzRYrpaW9LqQGucsDHGK8cih1'; // 실제 Firestore에서 사용되는 userId
  // final String invitationId = 'phNnoBTnm4gIupnfpA6X'; // 실제 Firestore에서 사용되는 invitationId
  final Map<String, dynamic> data; //추가
  HomePage3({super.key , required this.data}); //required this.data invitationPage 데이터 받아오기위함

  // Future<Map<String, dynamic>> _getInvitationData() async {
  //   DocumentSnapshot? invitationSnapshot = await firebaseService.getInvitation(userId, invitationId);
  //
  //   if (invitationSnapshot != null && invitationSnapshot.exists) {
  //     return invitationSnapshot.data() as Map<String, dynamic>; // 전체 데이터 반환
  //   }
  //
  //   throw Exception('No Data');
  // }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('HTML Overlay with InAppWebView'),
    //   ),
      // body: FutureBuilder<Map<String, dynamic>>(
      //   future: _getInvitationData(), // 전체 데이터를 가져오는 Future 함수 호출
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator()); // 로딩 중일 때 표시
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}')); // 에러 발생 시 표시
      //     } else if (!snapshot.hasData) {
      //       return const Center(child: Text('No Data')); // 데이터가 없을 때 표시
      //     }
      // var invitationData = snapshot.data!; // 가져온 초대장 데이터

          // Firestore에서 가져온 모든 데이터를 변수로 저장
          String templateId = data['templateId'] ?? '';
          String groomName = data['groomName'] ?? '';
          String brideName = data['brideName'] ?? '';
          String weddingLocation = data['weddingLocation'] ?? '';
          DateTime weddingDateTime = data['weddingDateTime'].toDate();
          String additionalAddress = data['additionalAddress'] ?? '';
          String additionalInstructions = data['additionalInstructions'] ?? '';
          String groomAccountNumber = data['groomAccountNumber'] ?? '';
          String brideAccountNumber = data['brideAccountNumber'] ?? '';
          String groomFatherName = data['groomFatherName'] ?? '';
          String groomFatherPhone = data['groomFatherPhone'] ?? '';
          String groomMotherName = data['groomMotherName'] ?? '';
          String groomMotherPhone = data['groomMotherPhone'] ?? '';
          String brideFatherName = data['brideFatherName'] ?? '';
          String brideFatherPhone = data['brideFatherPhone'] ?? '';
          String brideMotherName = data['brideMotherName'] ?? '';
          String brideMotherPhone = data['brideMotherPhone'] ?? '';
          String bridePhone = data['bridePhone'] ?? '';
          String groomPhone = data['groomPhone'] ?? '';
          String locationX = data['locationX'] ?? '';          // 추가된 변수
          String locationY = data['locationY'] ?? '';          // 추가된 변수
          String locationId = data['locationId'] ?? '';        // 추가된 변수
          String locationName = data['locationName'] ?? '';    // 추가된 변수
          String locationPhoneNumber = data['locationPhoneNumber'] ?? '';  // 추가된 변수
          Timestamp createdAt = data['createdAt'];

          String locationUrl = data['locationUrl'] ?? '';      // 카카오 지도 url
          String kakaoRoadUrl = data['kakaoRoadUrl'] ?? '';    // 카카오 내비 url
          String naverRoadUrl = data['naverRoadUrl'] ?? '';    // 네이버 지도 url
          final formattedDateTime = DateFormat('MM월 dd일 HH시 mm분').format(weddingDateTime);//날짜 시간 분만 출력
          final weddingDate = "'${DateFormat('yyyy-MM-dd').format(weddingDateTime)}'";//달력 날짜
          final weddingHours = "'${DateFormat('HH').format(weddingDateTime)}'";//달력 시간
          final weddingMinutes = "'${DateFormat('mm').format(weddingDateTime)}'";//달력 분



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
                <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
                <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c7f14517962ce3117e2ec63ae4cd7d54&libraries=services"></script>
                <title>이미지 보기</title>
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
                <style>
                
                    .intro {
                        font-family: 'Yeon Sung'; 
                        text-align: center; 
                        margin-top: 10px; 
                        font-size: 30px; 
                        font-weight: 600; 
                        width: 100%;"
                      
                      }
                      
                          @media (max-width: 1080px) {
                              .intro {
                                  transform: scale(1.2); /* 박스를 축소하여 글씨 크기와 전체 크기 조정 */
                                  transform-origin: top center; /* 축소의 기준점을 위쪽 중앙으로 설정 */
                                  font-size: 1.2em; /* 기본 글씨 크기도 살짝 조정 가능 */
                              }
                              
                              .phoneContainer{
                                  transform: scale(0.9); /* 박스를 축소하여 글씨 크기와 전체 크기 조정 */
                                  transform-origin: top center; /* 축소의 기준점을 위쪽 중앙으로 설정 */
                                  font-size: 0.8em; /* 기본 글씨 크기도 살짝 조정 가능 */
                              }
                              
                              
                          }
                
                
                    .invitation-container {
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        flex-direction: column;
                        font-family: Yeon Sung;
                        text-align: center;
                        color: #5a4b44;
                        margin-top: -5vh;
                        margin: 0 auto; 
                        max-width: 700px;
                    }
                    .message {
                        font-size: 40px;
                        margin-bottom: -150px;
                    }
                    .names {
                        font-size: 40px;
                        margin-top: -180px;
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
                 
                    }
                
                    .groombutton {
                    background-color: #5bc0de; 
                    color: white;
                    font-size: 24px;
                    padding: 8px 12px;
                    border-radius: 20px;
                    text-decoration: none;
                    }
                
                    .bridebutton {
                    background-color: #f0ad4e; 
                    color: white;
                    font-size: 24px;
                    padding: 8px 12px; 
                    border-radius: 20px;
                    text-decoration: none;
                    }
                
                
                    .mapContainer {
                      display: flex;
                      flex-direction: column;
                      align-items: center;
                      width: 100%;
                      max-width: 600px;
                      margin: 0 auto;
                      padding: 20px;
                      box-sizing: border-box;
                  }
                  
                    @media (min-width: 600px) {
                    .container {
                        max-width: 600px;
                        }
                     }
                
                    .buttons {
                        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                        display: flex;
                        justify-content: space-around;
                        background-color: #fff;
                        padding: 15px;
                        width: 100%;
                        max-width: 1000px;
                        
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
                      width: 105%;
                      max-width: 1000px;
                      }
                
                  #map {
                    width: 100%;
                    height: 300px;
                    background-color: #fff;
                
                  }
                  
                 .accountContainer {
                    display: flex;
                    justify-content: center; /* 수평 가운데 정렬 */
                    align-items: center; /* 수직 가운데 정렬 */
                    gap: 8px; /* 두 텍스트 간격 */
                    font-family: Arial, sans-serif;
                     }
                     
                  .phoneContainer {
                      display: flex;
                      flex-direction: column; 
                      align-items: center; 
                    
                  }
                  
                  .groomPhonebutton, .bridePhonebutton {
                      display: inline-block;
                      padding: 10px 10px;
                      color: white;
                      min-width: 100px;
                      background-color: #5bc0de; 
                      border-radius: 20px;
                      cursor: pointer;
                  }
                  
                  .bridePhonebutton {
                      background-color: #f0ad4e; 
                  }
                  
                 .contact-container {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    padding: 15px;
                    background-color: #fff;
                    border-top-left-radius: 15px;
                    border-top-right-radius: 15px;
                    width: 100%;
                    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                    font-family: Yeon Sung; 
                    font-size: 25px;
                    margin-top: 10%;
                    max-width: 1000px;
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
                  
                  .parent-container {
                      display: flex;
                      justify-content: center;
                      align-items: center;
                      height: 100vh;
                  }
                  
                  
                  
                  
                  .calendar-container {
                      width: 550px;
                      height: 400px;
                      padding: 20px;
                      background-color: transparent;
                      border: 5px solid transparent;
                      border-radius: 10px;
                      text-align: center;
                      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                      
                  }
                
                  .calendar-header {
                      display: flex;
                      justify-content: space-between;
                      align-items: center;
                      font-size: 20px;
                      font-weight: bold;
                      color: #333;
                      margin-bottom: 25px;
                  }
                
                  .calendar-header .date {
                      color: black;
                  }
                
                  .calendar-header .time {
                      color: #666;
                      font-size: 15px;
                  }
                
                  table {
                      width: 100%;
                      height: 80%;
                      border-collapse: collapse;
                      text-align: center;
                      font-size: 16px;
                      color: #666;
                  }
                
                  td {
                      padding: 20px;
                      border-radius: 300px;
                  }
                
                  .today {
                      font-weight: bold;
                      color: #333;
                      background-color: black;
                      color: white;
                      font-weight: bold;
                  }
                
                  .saturday{
                      color: #0000FF;
                  }
                  .weekend {
                      color: #e74c3c;
                  }
                  
                  .weekday-row {
                      display: flex;
                      justify-content: space-around;
                      font-weight: bold;
                      margin-bottom: 10px;
                  }
                  
                  .weekday-row span {
                      width: 100%;
                      text-align: center;
                  }
                  
                  .centered-wrapper {
                      max-width: 1000px; 
                      margin: 0 auto;
                      transform: scale(0.95); 
                  }
                
                 /* General modal styling */
                  .modal {
                      display: none; /* Hidden by default */
                      position: fixed;
                      z-index: 1;
                      left: 0;
                      top: 0;
                      width: 100%;
                      height: 100%;
                      overflow: auto;
                      background-color: rgba(0, 0, 0, 0.5); /* Dark background */
                      justify-content: center;
                      align-items: center;
                      transition: opacity 0.3s ease;
                  }
                  
                  .modal button {
                    background-color: #4CAF50;
                    color: white;
                    padding: 10px 20px;
                    font-size: 16px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    transition: background-color 0.3s ease;
                 } 
                 
                 /* Header style */
                  .modal h2 {
                      font-size: 22px;
                      color: #333;
                      margin-bottom: 15px;
                      font-weight: 600;
                  }
                  
                  /* Paragraph style for account number */
                  .modal p {
                      font-size: 18px;
                      color: #555;
                      margin-bottom: 20px;
                  }
                  
                  /* Modal content box */
                  .modal-content {
                      background-color: #fff;
                      margin: 10% auto;
                      padding: 20px;
                      border-radius: 10px;
                      width: 80%;
                      max-width: 400px;
                      text-align: center;
                      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                  }
                  
                  /* Close button */
                  .close {
                      color: #aaa;
                      font-size: 28px;
                      font-weight: bold;
                      position: absolute;
                      top: 10px;
                      right: 15px;
                      cursor: pointer;
                  }
                  
                  /* Hover effect for close button */
                  .close:hover,
                  .close:focus {
                      color: #000;
                      text-decoration: none;
                      cursor: pointer;
                  }

                
                
                </style>
                </head>
                <body background="https://firebasestorage.googleapis.com/v0/b/invitationgen-7eb56.appspot.com/o/Tem3Bg.png?alt=media&token=9f74e33f-a01a-46d3-8826-b71fb5b715a0" style="height: 4500px;">
                <div class="centered-wrapper">
                    <div class="invitation-container">
                        <div class="message">어느 따스한 봄날,<br>저희 결혼해요.</div>
                        <img src="https://firebasestorage.googleapis.com/v0/b/invitationgen-7eb56.appspot.com/o/Tem3Img.png?alt=media&token=75bc03a8-0866-46ed-859f-6c64c7ec2290" width="600px">
                        <div class="names">${groomName}와 ${brideName}</div>
                        
                    </div>
                <div class = "fading-box">
                    ${formattedDateTime}
                </div>
                    
                
                <div style="text-align: center; font-family: Yeon Sung; font-size: 35px; margin-top: 20%;">
                    <p style="margin: 0;">초대합니다</p>
                    <hr style="width: 25%; margin: 5px auto 0; border: none; border-top: 2px solid #999;">
                  </div>
                  
                  <div class="intro">
                    <p ><br>저희 두 사람의 결혼식에 모시고자 합니다 <br><br> 먼 길 힘드시겠지만, 꼭 참석하여 그동안 쌓아온<br>인생의 경험과 강인함을 저희와 공유해 주시길 부탁드립니다
                <br>여러분들의 가르침을 따라 올바르게 앞을 향해 나아가겠습니다.<br><br>함께하시어 행복을 더해주시길 기대합니다</p>
                  </div>
                
                <div style="display: flex; gap: 20%; font-family: 'Yeon Sung'; font-weight: 500; text-align: center; justify-content: center; margin-top: 1%;">
                    <div class="phoneContainer">
                        <p style="font-size: 40px;"><span style="color: #8b8b8b;">신랑&nbsp</span> ${groomName}</p> 
                        <div class="groomPhonebutton" onclick="location.href='tel:${bridePhone}'">전화하기</div>
                    </div>
                    <div class="phoneContainer">
                        <p style="font-size: 40px;"><span style="color: #8b8b8b;">신부&nbsp</span> ${brideName}</p>
                        <div class="bridePhonebutton" onclick="location.href='tel:${groomPhone}'">전화하기</div> 
                    </div>
                </div>
                
                
                
                <div class="parent-container">
                  <div class="calendar-container">
                      <div class="calendar-header">
                          <span class="date">10 October</span>
                          <span class="time">sat. pm 1:30</span>
                      </div>
                       <div class="weekday-row">
                            <span style="color: #FF0000;">일</span>
                            <span>월</span>
                            <span>화</span>
                            <span>수</span>
                            <span>목</span>
                            <span>금</span>
                            <span style="color: #0000FF;">토</span>
                        </div>
                      
                      <table>
                          <tr>
                              <td class="weekend">1</td>
                              <td>2</td>
                              <td>3</td>
                              <td>4</td>
                              <td class="today">5</td>
                              <td>6</td>
                              <td class ="saturday">7</td>
                          </tr>
                          <tr>
                              <td class="weekend">8</td>
                              <td>9</td>
                              <td>10</td>
                              <td>11</td>
                              <td>12</td>
                              <td>13</td>
                              <td class ="saturday">14</td>
                          </tr>
                          <tr>
                              <td class="weekend">15</td>
                              <td>16</td>
                              <td>17</td>
                              <td>18</td>
                              <td>19</td>
                              <td>20</td>
                              <td class ="saturday">21</td>
                          </tr>
                          <tr>
                              <td class="weekend">22</td>
                              <td>23</td>
                              <td>24</td>
                              <td>25</td>
                              <td>26</td>
                              <td>27</td>
                              <td class ="saturday">28</td>
                          </tr>
                          <tr>
                              <td class="weekend">29</td>
                              <td>30</td>
                              <td>31</td>
                              <td></td>
                              <td></td>
                              <td></td>
                              <td class ="saturday"></td>
                          </tr>
                      </table>
                  </div>
                </div>
                
                
                <script>
                  console.log(`wedding date:${weddingDate}`);
                  const formattedDateTime = ${weddingDate};
                  const [year, month, day] = formattedDateTime.split("-").map(Number);
                  const date = new Date(year, month - 1, day);
                  const hours = ${weddingHours};
                  const minutes =  ${weddingMinutes};
                  
                  
                
                  // 달력 함수
                  function createCalendar(date, hours, minutes) {
                      const calendarHeader = document.querySelector(".calendar-header .date");
                      const timeHeader = document.querySelector(".calendar-header .time");
                      const tableCells = document.querySelectorAll("table td");
                
                     
                      calendarHeader.textContent = date.toLocaleString('ko', { month: 'long' }) +' '+ date.toLocaleString('En', { month: 'long' })
                      timeHeader.textContent = date.toLocaleDateString('ko', { weekday: 'short' }) + ' ' + (hours >= 12 ? '오후' : '오전') + ' ' + (hours % 12 || 12) + ':' + String(minutes).padStart(2, '0');
                
                      const firstDay = new Date(date.getFullYear(), date.getMonth(), 1).getDay();
                      const lastDate = new Date(date.getFullYear(), date.getMonth() + 1, 0).getDate();
                
                      tableCells.forEach(cell => {
                          cell.textContent = '';
                          cell.classList.remove('today', 'selected');
                      });
                
                      for (let i = 1; i <= lastDate; i++) {
                          tableCells[firstDay + i - 1].textContent = i;
                
                          if (i === date.getDate()) {
                              tableCells[firstDay + i - 1].classList.add("today");
                          }
                      }
                  }
                
                  createCalendar(date,hours, minutes);
                  
                  function openModal(type) {
                    var modal;
                    if (type === 'groom') {
                        modal = document.getElementById("groomModal");
                    } else if (type === 'bride') {
                        modal = document.getElementById("brideModal");
                    }
                
                    // Display the modal
                    modal.style.display = "block";
                
                    // Close the modal when clicking outside of the modal content
                    window.onclick = function(event) {
                        if (event.target === modal) {
                            closeModal(type);
                        }
                    };
                }
                
                function closeModal(type) {
                    var modal;
                    if (type === 'groom') {
                        modal = document.getElementById("groomModal");
                    } else if (type === 'bride') {
                        modal = document.getElementById("brideModal");
                    }
                
                    // Hide the modal
                    modal.style.display = "none";
                
                    // Remove the click event listener to prevent multiple bindings
                    window.onclick = null;
                }

            
            function copyToClipboard(type) {
                var accountNumber;
                if (type === 'groom') {
                    accountNumber = document.getElementById("groomAccountNumber").innerText;
                } else if (type === 'bride') {
                    accountNumber = document.getElementById("brideAccountNumber").innerText;
                }
            
                var tempInput = document.createElement("input");
                tempInput.value = accountNumber;
                document.body.appendChild(tempInput);
                tempInput.select();
                document.execCommand("copy");
                document.body.removeChild(tempInput);
                alert(accountNumber + "이(가) 클립보드에 복사되었습니다.");
            }
            
                </script>
                
                
                
                <div style="text-align: center; font-family: Yeon Sung; font-size: 35px; margin-top: 5%;">
                    <p style="margin: 0;">혼주 연락처</p>
                    <hr style="width: 25%; margin: 5px auto 0; border: none; border-top: 2px solid #999;">
                </div>
                
                <div style="display: flex; gap: 40%; font-size: 30px; font-family: Yeon Sung; font-weight: 600; text-align: center; justify-content: center; margin-top: 5%;">
                    <p style="color: #87CEEB;">신랑 측</p>
                    <p style="color: #ffdc92;">신부 측</p>
                </div>
                
                <div style="display: flex; gap: 20%; font-family: Yeon Sung; font-weight: 500; text-align: center; justify-content: center;">
                  <div class="phoneContainer">
                      <p><span style="font-size: 30px; color: #8b8b8b;">아버지&nbsp</span> 
                         <span style="font-size: 40px; color: #000000;">&nbsp${groomFatherName}</span></p>
                      <div class="groomPhonebutton" onclick="location.href='tel:${groomFatherPhone}'">전화하기</div>
                
                      <p><span style="font-size: 30px; color: #8b8b8b;">어머니&nbsp</span> 
                         <span style="font-size: 40px; color: #000000;">&nbsp${groomMotherName}</span></p>
                      <div class="groomPhonebutton" onclick="location.href='tel:${groomMotherPhone}'">전화하기</div>
                  </div>
                
                  <div class="phoneContainer">
                      <p><span style="font-size: 30px; color: #8b8b8b;">아버지&nbsp</span> 
                         <span style="font-size: 40px; color: #000000;">&nbsp${brideFatherName}</span></p>
                      <div class="bridePhonebutton" onclick="location.href='tel:${brideFatherPhone}'">전화하기</div>
                
                      <p><span style="font-size: 30px; color: #8b8b8b;">어머니&nbsp</span> 
                         <span style="font-size: 40px; color: #000000;">&nbsp${brideMotherName}</span></p>
                      <div class="bridePhonebutton" onclick="location.href='tel:${brideMotherPhone}'">전화하기</div>
                  </div>
                </div>
                
                
                <div style="text-align: center; font-family: Yeon Sung; font-size: 35px; margin-top: 15%;">
                    <p style="margin: 0;">오시는 길</p>
                    <hr style="width: 25%; margin: 5px auto 0; border: none; border-top: 2px solid #999;">
                </div>
                
                <div class="mapContainer">
                <div class="contact-container">
                  <div class="contact-info">
                    <h3>${locationName}</h3>
                    <p>${weddingLocation}</p>
                    <p>Tel. ${locationPhoneNumber}</p>
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
                    </div>
                
                
                
                <div style="text-align: center; font-family: Yeon Sung; font-size: 35px; margin-top: 10%;">
                    <p style="margin: 0;">마음 전하기</p>
                    <hr style="width: 25%; margin: 5px auto 0; border: none; border-top: 2px solid #999;">
                    <p style="font-family: Yeon Sung; text-align: center; margin-top: 40px; margin-bottom: 100px; font-size: 30px; font-weight: 400;">축하의 마음을 전해주세요</p>
                </div>
                
                
                <div class="accountContainer">
                    <span style="font-family: Yeon Sung; font-size: 30px; color: #8b8b8b;">신랑 측&nbsp&nbsp&nbsp&nbsp</span>
                    <div class="groombutton" style="font-family: 'Yeon Sung';  cursor:pointer;" onclick="openModal('groom')">축의금으로 마음 전하기</div>
                </div>
                
                <div class="accountContainer" style="margin-top: 40px;">
                    <span style="font-family: Yeon Sung; font-size: 30px; color: #8b8b8b;">신부 측&nbsp&nbsp&nbsp&nbsp</span>
                    <div class="bridebutton" style="font-family: 'Yeon Sung';  cursor:pointer;"  onclick="openModal('bride')">축의금으로 마음 전하기</div> 
                </div>
                </div>
                
                  <!-- 신랑 측 계좌 모달 -->
                  <div id="groomModal" class="modal">
                      <div class="modal-content">
                          <span class="close" onclick="closeModal('groom')">&times;</span>
                          <h2>신랑 측 계좌번호</h2>
                          <p id="groomAccountNumber" style="display: inline-block; font-size: 24px; font-weight: 800; margin-right: 10px;">$groomAccountNumber</p>
                          <button id="copyButton" onclick="copyToClipboard('groom')" style="display: inline-block;">복사</button>

                      </div>
                  </div>
                  
                  <!-- 신부 측 계좌 모달 -->
                  <div id="brideModal" class="modal">
                      <div class="modal-content">
                          <span class="close" onclick="closeModal('bride')">&times;</span>
                          <h2>신부 측 계좌번호</h2>
                          <p id="brideAccountNumber" style="display: inline-block; font-size: 24px; font-weight: 800; margin-right: 10px;">$brideAccountNumber</p>
                          <button id="copyButton" onclick="copyToClipboard('bride')" style="display: inline-block;">복사</button>
                      </div>
                  </div>
                  
                  
                  
                   <div style="text-align: center; font-family: Yeon Sung; font-size: 35px;">
                      <p style="margin: 0;">전하고싶은 말씀</p>
                      <hr style="width: 30%; margin: 5px auto 0; border: none; border-top: 1px solid #4d4d4d;">
                      <p style="font-family: Grandiflora One; text-align: center; margin-top: 40px; font-size: 30px; font-weight: 600;">${additionalInstructions}</p>
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
        // },
      // ),
    // );
  }
}