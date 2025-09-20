# 5.2 Distributed Git - Contributing to a Project

## 기여하기 요약

프로젝트에 기여하는 방법은 다음에 따라 크게 달라짐

- 실제 기여자 수
- 선택한 워크플로우
- 레포 push 권한 여부

### 커밋 가이드라인

- 커밋 팁: 깃 소스코드의 `Documentation/SubmittingPatches` 파일
- 공백 오류 검출: `git diff --check`
- 논리적으로 구분한 커밋: 이슈당 최소 하나의 커밋 만들기
  - `git add -p`로 필요한 내용만 스태이징 가능
  - ⇒ 리뷰하기 쉽게 만듦
  - ⇒ 변경점을 가져오거나 복구하기 쉽게 만듦
- 양질의 커밋 메시지 작성하기
  - 제목: 50자 이내의 요약. 명령형으로 작성
  - 본문: (선택) 구현 동기, 이전 동작과 비교 등을 작성. 한 줄을 띄우고 작성해야함.

### 작은 팀의 private 협업

- 2~3명 정도의 개발자가 private 레포에서 작업하는 방법

1. 작업을 함(보통 토픽 브랜치에서)
2. 작업이 완료되면 main에 병합함
3. 서버에 공유하기 전에 fetch + merge함
4. push함

### 하위 팀의 private 협업

- main 병합 권한은 integrator에게만 있고, 한 기능을 1~3명의 개발자가 동시에 협업하는 방법
- 작업이 끝날 때마다 관련자에게 알리는 것이 중요

1. 기능 브랜치를 생성
   - 만약 다른 사람이 이미 다른 이름으로 만들었다면 `git push origin -u localname:remotename`
2. 기능 브랜치에 대해 관련 개발자가 작업(작은 팀 private 협업과 동일)
3. 기능이 완성 되면 integrator에게 병합 요청

### 수정 권한이 없는 공개 레포에 기여하는 방법

1. clone 후 feature 브랜치 만들어서 작업
2. fork 후 URL을 remote로 추가
3. 작업이 끝난 뒤 forked repo에 토픽 브랜치를 push
4. 유지보수자에게 pull request

- 다양한 PR 방법
  - 호스팅 서비스의 기능 사용
  - `git request-pull` 후 나온 내용을 유지보수자에게 전달
- 토픽 브랜치의 유용성
  - 거절되거나 일부만 반영되어도 쉽게 복구할 수 있음
  - 다른 브랜치와 간섭 없이 재작성, rebase, 수정할 수 있음
- 수정 요청에 대응하기
  - 병합이 실패하는 경우: `git rebase origin/main` 후 force push
  - 브랜치를 새로 만들어야할 정도로 복합적인 큰 변경이 필요한 경우:
    1. `git switch -c featureBv2 origin/main`
    2. `git merge --squash featureB`: 한 커밋으로 짜부
    3. 작업 & push 후 유지보수자에게 알리기

### 이메일로 협업하는 방법

- 작업 자체는 이전 섹션과 유사하지만 보내는 방법만 다름

1. 작업
2. `git format-patch -M origin/main` 으로 패치를 만듦
3. 이메일 보내기
   - 복붙 (일부 클라이언트는 공백을 지우기 때문에 권장 X)
   - IMAP: `cat *.patch | git imap-send`
   - SMTP: `git send-email *.patch`

- 이메일 관련 프로토콜
  - IMAP: 이메일 서버 동기화. 폴더에 접근 가능
  - SMTP: 이메일 전송만 담당
- 이메일 관련 `gitconfig`

  - IMAP 설정법

    ```toml
    [imap]
      folder = "[Gmail]/Drafts"
      host = imaps://imap.gmail.com
      user = user@gmail.com
      pass = YX]8g76G_2^sFbd
      port = 993
      sslverify = false
    ```

  - SMTP 설정법

    ```toml
    [sendemail]
      smtpencryption = tls
      smtpserver = smtp.gmail.com
      smtpuser = user@gmail.com
      smtpserverport = 587
    ```
