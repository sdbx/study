# 7.4 Git Tools - Signing Your Work

## 서명

- 다른 사람의 작업이 신뢰할 수 있는 출처에서 온 것인지 확인하는 용도
- GPG 서명 구성
  - `gpg --list-keys`: GPG 키 확인
  - `gpg --gen-key`: GPG 키 생성
  - `git config --global user.signingkey 키ID`: 서명할 때 기본으로 사용할 키 설정
  - `git config --local commit.gpgsign true`: 저장소의 모든 커밋이 자동으로 서명되게 동작
- 태그 서명
  - `git tag -s`: 서명
  - `git show <tagname>`: 서명이 있는지 확인
  - `git tag -v <tagname>`: 서명 검증
    - 검증시 서명자의 공개키가 keyring에 있어야 함
- 커밋 서명
  - `git commit -S`: 서명
  - `git log --show-signature`: 검증
    - 참고: `git log --pretty=format:`의 `%G?`
- 병합 서명 (`merge`나 `pull`)
  - `git merge -S`: 병합 커밋에 서명
  - `--verify-signatures`: 병합 전 관련 모든 커밋의 서명을 검사. 유효하지 않으면 실패
