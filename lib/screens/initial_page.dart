import 'package:flutter/material.dart';
import './main_screen.dart';
import './login_page.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9E1FF), // 전체 배경 색상 설정
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/logo.png', height: 120, width: 300), // 로고 이미지 추가
            
           
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFB28EFF), // 버튼 배경 색상 설정
                    fixedSize: Size(220, 20), // 버튼 크기 설정 (가로, 세로)
                    elevation: 2, // 그림자 높이 설정
                  ),
                  child: Text(
                    '로그인',
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,

                    ),),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // 회원가입 버튼이 눌렸을 때의 동작 추가
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // 버튼 배경 색상 설정
                    fixedSize: Size(220, 20),
                    elevation: 2,
                  ),
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: Color(0xFFB28EFF),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),),
                  
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
