# A3.9 이메일

## 학습목표
- 다음의 명령어들을 복습한다.
```bash
git apply
git am
git format-patch
git imap-send
git send-email
git request-pull
```

## 요약
- git apply
   - git diff로 생성된 패치 적용하기
- git am
   - mbox format인 패치를 email inbox로부터 적용하기
- git imap-send
   - format-patch로 생성된 mailbox를 IMAP drafts 폴더에 업로드
- git send-email
   - format-patch로 생성된 패치를 이메일로 보내기
- git request-pull
   - 누군가(아마도 메인테이너)에게 보낼 메일 내용의 예시를 생성
