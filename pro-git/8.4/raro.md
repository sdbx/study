# 8.4 Customizing Git - An Example Git-Enforced Policy

- `git rev-list`: 해시만 출력
- `git cat-file`: 원시 커밋 데이터 가져오기
- `sed 1,/^$/d`: `1`(처음)부터 `/^$/`(빈 줄)까지를 d(삭제)
- ACL: Access Control List
- `git diff-index`: 대상과 인덱스 사이의 차이를 출력
- `ref^@`: 해당 커밋의 모든 부모
