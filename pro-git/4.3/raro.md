# 4.3 Git on the Server - Generating Your SSH Public Key

## 워크플로우

1. 기존 SSH 키 존재 여부 확인
   - `ls ~/.ssh/id_*.pub`
2. 없다면 생성
   - `ssh-keygen -t ed25519 -C "이메일주소"`
   - `-o`는 비밀키를 새 OpenSSH format으로 강제하는 옵션인데 최신 버전은 필요 없다고 함
3. 생성한 공개 키 내용을 복사하여 Git 서버 관리자에게 보냄
   - `cat ~/.ssh/id_*.pub`

## 서명 알고리즘 종류

- Ed25519: 권장
- RSA: deprecated. Ed25519를 지원하지 않는 레거시 시스템인 경우 사용
- DSA: obsolete
