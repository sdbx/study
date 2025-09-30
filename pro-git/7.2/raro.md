# 7.2 Git Tools - Interactive Staging

## Interactive shell mode

- `git add -i|--interactive`
- staging area에 올리거나 내릴 파일이나 부분을 대화식으로 선택할 수 있음
- status: `git status`와 같은 정보를 보여주지만 더 간결함
- `update`: 특정 파일만 staging area에 추가
- `revert`: 특정 파일만 staging area에서 제거
- `diff`: 특정 파일에 대한 `git diff --cached`
- `patch`: 특정 파일에 대한 패치 추가 모드
  - 파일을 hunk 단위로 나눔
  - `?`: 도움말
  - `y`: 추가
  - `n`: 제외
  - `a`: 이 파일의 남은 모든 hunk 추가
  - `d`: 이 파일의 남은 모든 hunk 제외
  - `s`: 현재 hunk를 더 작게 나눔
  - `e`: 현재 hunk를 직접 수정

패치 모드는 다른 명령에도 있음

- `git add -p|--patch`: 파일의 일부만 staging
- `git reset --patch`: 파일의 일부만 reset
- `git restore --patch`: 파일의 일부만 discard
- `git stash push --patch`: 파일의 일부만 stash
