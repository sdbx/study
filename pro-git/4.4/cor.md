# 4.4 서버 설정하기

## 학습목표
- 서버측에 SSH 접근을 설정하는 방법을 이해한다.

## 참고
- 아래의 내용은 ssh-copy-id 명령어로 자동화될 수 있다고 함
- 4.2에서 설명된 authorized_keys 방법을 사용한다고 함
- 솔직히 말해서 4.2랑 4.4는 뭔 소린지 하나도 모르겠음 배경지식이 없어서

## 요약
### 서버 설정
- git이라는 이름의 user account를 생성
- git 유저의 authorized_keys 파일에 협업할 사람의 SSH 공개키를 append하기
- git init --bare로 빈 레포지토리 생성
- 이러면 협업자들은 이 repo를 remote로 등록하고 push, clone할 수 있음

### 제약 설정
- 모든 유저가 서버에 로그인해서 git 유저로서의 shell을 얻는 것을 제한하려면 /etc/passwd 파일에서 쉘을 변경하라
- git-shell을 사용해 git 유저 계정이 git에 관련된 활동만 할 수 있도록 제약할 수 있음
- 유저가 git 서버가 도달할 수 있는 임의의 호스트에 ssh port forwarding하는 것을 방지하려면 authorized_keys 파일상에서 제한하려는 키 시작부분에 관련 옵션을 명시해준다.
- git-shell의 명령어를 약간 customize할 수 있다.

## 영어 공부
- walk sb through sth: 상세하게 가이드하다