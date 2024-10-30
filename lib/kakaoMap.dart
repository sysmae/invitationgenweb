import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class KakaoMap extends StatefulWidget {
  final double width;
  final double height;
  final String x;
  final String y;

  const KakaoMap({
    Key? key,
    this.width = 500,
    this.height = 400,
    this.x = '126.570667',
    this.y = '33.450701',
  }) : super(key: key);

  @override
  State<KakaoMap> createState() => _KakaoMapState();
}

class _KakaoMapState extends State<KakaoMap> {
  late InAppWebViewController _webViewController;

  // HTML 코드에서 Kakao 지도를 초기화하는 함수
  String getKakaoMapHtml(String x, String y) {
    return '''
    <!DOCTYPE html>
    <html>
      <head>
      
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
        <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c7f14517962ce3117e2ec63ae4cd7d54&libraries=services"></script>
        <style>
          html, body, #map {
            width: ${widget.width}px;
            height: ${widget.height}px;
            margin: 0;
            padding: 0;
          }
        </style>
      </head>
      
      <body>
        <div id="map"></div>
        <script>
        console.log(`x: $x y:$y`);
          var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
              mapOption = { 
                  center: new kakao.maps.LatLng($y, $x), // 위도와 경도를 기반으로 지도 중심 좌표 설정
                  level: 3 // 지도의 확대 레벨
              };
          
          var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성

          // 지정된 좌표에 마커 생성
          var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng($y, $x)
          });
        </script>
      </body>
    </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: InAppWebView(
        initialData: InAppWebViewInitialData(
          data: getKakaoMapHtml(widget.x, widget.y),
          baseUrl: WebUri('about:blank'),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            mediaPlaybackRequiresUserGesture: false,
            javaScriptEnabled: true, // 자바스크립트 사용 허용
          ),
        ),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
      ),
    );
  }
}
