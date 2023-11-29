import 'package:flutter/material.dart';
import './main_screen.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9E1FF), // 전체 배경 색상 설정
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/logo.png', height: 120, width: 300), // 로고 이미지 추가
            
            // 아이디 입력란
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 250,
                height: 40, // 아이디 입력란의 너비 설정
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '아이디',
                   enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFC19BFF)),
                      ),
                    filled: true,
                    fillColor: Colors.white,
                    
                  ),
                ),
              ),
            ),

            // 비밀번호 입력란
             Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 250,
                height: 40, // 비밀번호 입력란의 너비 설정
                child: TextField(
                  obscureText: true, // 비밀번호를 가리기 위해 설정
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFC19BFF)),
                      ),

                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),

            // 로그인 버튼
            ElevatedButton(
               onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyMain(),
                      ),
                    );
                  },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFB28EFF), // 버튼 배경 색상 설정
                fixedSize: Size(250, 20), // 버튼 크기 설정 (가로, 세로)
                elevation: 2, // 그림자 높이 설정
              ),
              child: Text(
                '로그인',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            
          ],
        ),
      ),
    );
  }
}