# 4.7 GitWeb

## 학습목표
- GitWeb이 무엇인지 이해한다.

## 요약
- httpd = (d는 daemon을 나타내는 글자) 백그라운드에서 프로세스로서 실행되면서 http(s) 프로토콜을 사용해 서버의 역할을 하는 "프로그램"
- Apache = 웹 서버
- GitWeb은 간단한 웹 기반 visualizer로, cgi 스크립트다. 깃에 들어있다.
- 임시적으로 확인하는법 => `git instaweb` (단, lighttpd나 webrick와 같은 경량 웹서버가 깔려있어야 함)
- 상시적으로 필요하다면 통상적인 웹서버에서 serve되게 해야 함
   - 몇몇 linux 배포판에는 apt나 dnf로 설치할 수 있는 gitweb 패키지가 있음
   - 수동 설치하려면 git 소스코드를 다운받은뒤 custom cgi 스크립트를 generate해야 함
- GitWeb은 임의의 cgi나 perl 사용가능 웹서버에서 serve될 수 있다

## 영어 공부
- best bet: 가장 확실한 수단