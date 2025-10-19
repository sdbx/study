# 10.1 Git Internals - Plumbing and Porcelain

Git: content-addressable filesystem

초기에는 VCS를 위한 툴킷이었기 때문에 저수준 명령어로 구성됨 -> UNIX 스타일로 연결하거나 스크립트로 만들게 설계됨

- plumbing: 저수준 명령
- porcelain: 고수준 명령

## `.git/` 구조

- `objects/`: 데이터베이스의 모든 내용 저장
- `refs/`: 커밋 객체의 포인터(브랜치, 태그, 리모트 등) 저장
- `HEAD`: 현재 체크아웃한 브랜치를 가리킴
- `index`: 인덱스 정보를 저장
- `hooks/`: 클라이언트 측, 서버 측 훅이 위치
- `info/`: 부가 정보를 담음
- `config`: 프로젝트 한정 구성 파일
- `description`: GitWeb에서만 사용
