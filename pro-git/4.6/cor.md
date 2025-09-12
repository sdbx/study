# 4.6 Smart HTTP

## 학습목표
- http 프로토콜을 설정하는 방법을 이해한다.

## 요약
- CGI = Common Gateway Interface
   - 웹 서버가 http 혹은 https user request를 처리하기 위해 외부 프로그램을 실행할 수 있게 하는 "인터페이스 명세".
- smart http를 설정하는 것은 `git-http-backend`라는 cgi 스크립트를 활성화하는 것과 같음
- 깃에는 git-http-backend 라는 게 들어있다
- 이게 호출되면 http를 통해 데이터를 주고받기 위한 negotiation을 전부 해준다
- 이것 자체적으로는 인증이 없지만 이것을 호출하는 웹서버에서 인증을 쉽게 제어할 수 있다

## 영어 공부
- leave out: 생략하다
- come up with sth: ~을 제시하다
- rabbit hole: 탈출하기 힘든 이상하거나 당혹스러운 상황/환경
- may/might/could well: 무언가가 일어날 가능성이 있거나 사실일 가능성이 있다