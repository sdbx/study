# 7.3 Git Tools - Stashing and Cleaning

## 임시로 저장하기

- 잠시 다른 작업을 하려고 브랜치를 이동해야 하지만, 임시 커밋을 만들고 싶지는 않은 경우
- `git stash list`: stash 목록 보기
- `git stash show [stash@{n}]`: 특정 stash 보기
- `git stash push`: 스택에 stash 추가
  - 작업 트리와 인덱스 모두 저장하고 작업 트리를 깨끗히 만듦
  - `--keep-index`: 지울 때 인덱스는 그대로 둠
  - `-u|--include-untracked`: untracked 파일 포함
  - `-a|--all`: 모든 파일(특히 ignored 파일) 포함
  - `--patch`: 대화식으로 stash할 hunk를 고를 수 있음
- `git stash apply [stash@{n}]`: 특정 stash 적용
  - 적용은 작업 트리가 비어있지 않아도, 브랜치가 달라도 적용됨
  - 단, 상태에 따라 병합 충돌이 발생할 수 있음
  - `--index`: staged를 유지
- `git stash drop [stash@{n}]`: 특정 stash 버리기
- `git stash pop`: 적용하고 버림
- `git stash branch <new branchname>`
  1. 작업을 stash한 시점의 커밋을 기준으로 새 브랜치를 만듦
  2. stash를 적용
  3. 적용에 성공했다면 stash를 버림

## 작업 디렉토리 비우기

- 저장하지 않고 단순히 지우고 싶은 경우, clean build를 위해 build artifact를 지우고 싶은 경우
- `git clean`: 작업 트리를 깨끗하게 만듦
  - 복구 불가능. 복구하고 싶다면 `git stash --all`을 이용
  - `clean.requireForce`가 명시적으로 `false`가 아닌 이상 `-f` 옵션 필수
  - `-d`: 디렉토리 포함
  - `-n|--dry-run`: 지울 목록만 나열
  - `-x`: ignored 파일도 포함
  - `-i|--interactive`: 대화식. 제거할 파일을 선택하거나 특정 패턴으로 선택 가능
  - 다른 Git 저장소(주로 submodule) 안에서 git clean을 하는 경우 `-f`가 두 개 필요
