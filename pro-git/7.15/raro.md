# 7.15 Git Tools - Summary

## 리비전 고르기

- 단일 리비전
  - 해시 전체
  - 4자 이상의 모호하지 않은 부분 해시(8~10자 권장)
- 브랜치 참조: 브랜치 이름으로 브랜치가 가리키는 커밋 참조
- reflog 참조
  - `HEAD@{n}`: n번째 이전 커밋
  - `HEAD@{2.days.ago}`: 날짜로 지정
- 조상 참조
  - `HEAD^2`
  - `HEAD~3` == `HEAD~~~`
- `A..B` == `B --not A` == `B ^A`
- `A...B`: 대칭차집합. `git log --left-right`: 각 커밋의 side 출력

## 대화식 스태이징

- `git add -i`

패치 모드는 다른 명령에도 존재

- `git add -p`
- `git reset -p`
- `git restore -p`
- `git stash push -p`

## 임시로 저장하기

- `git stash list`
- `git stash show`
- `git stash push`
  - `--keep-index`: 인덱스 유지
  - `-u`: untracked 파일 포함
  - `-a`: 모든 파일(특히 ignored 파일) 포함
  - `-p`: 패치 모드
- `git stash pop`
- `git stash apply`
  - `--index`: staged 유지
- `git stash drop`
- `git stash branch`: stash한 시점의 커밋을 기준으로 새 브랜치를 만들고 stash 버림

## 작업 디렉토리 비우기

- `git clean`: 작업 트리를 정리
  - `-n`: 지울 목록 나열
  - `-d`: 디렉토리 포함
  - `-x`: ignored 파일 포함
  - `-i`: 대화식
  - `-f`: 강제 삭제 (안전을 위해 요구)

## 서명

- `git tag -s`: 태그 서명
- `git tag -v`: 태그 검증
- `git commit -S`: 커밋에 서명
- `git log --show-signature`: 커밋 검증
- `git merge -S`: 병합 커밋에 서명

## 검색

- `git grep`: 어디에 존재하는지 검색
  - `git grep --break --heading -n -p '검색문자열'`
- `git log -S`: 언제 도입되었거나 삭제되었는지 검색
- `git log -L`: 특정 파일의 특절 줄이나 함수의 히스토리 나열

## 히스토리 재작성하기

- `git commit --amend`, `--no-edit`
- `git rebase -i HEAD~3`

## 모든 커밋에 대해 특정 작업하기

- `git-filter-repo`

## Reset

- 현재 브랜치를 이동
- 경로가 있다면 해당 파일을 unstage

## checkout

### 경로가 없다면 (git-switch 역할)

- HEAD 자체를 이동(다른 브랜치를 가리킬 수 있음)
- 인덱스 업데이트
- 사소한 병합을 시도

### 경로가 있다면 (git-restore 역할)

- 해당 파일의 인덱스와 WD를 HEAD 상태로 만듦

## 고급 병합

- base, ours, theirs
- combined diff: ours열, theirs열 표시

  ```diff
  ++<<<<<<< HEAD
   +  echo 53
  ++=======
  +   echo 64
  ++>>>>>>>
  ```

- 직전 병합 커밋 되돌리기: `git reset --hard HEAD~`
- 커밋 되돌리기: `git revert -m 1 HEAD`

  - 토픽 브랜치를 재병합하려면, 그 전에 `revert`를 한 번 더 해야함

- 어느 한 쪽을 선호하도록 지시
  - `git merge -Xours`: 병합을 시도하고 충돌이 발생하면 지정한 쪽을 사용
- "ours" 병합 전략: 가짜 병합 수행

## rerere

1. 기능 활성화 `git config --global rerere.enabled true`
2. 충돌 기억 후 자동 해결

## 디버깅

- 문제가 발생한 위치를 알 때: `git blame`
- 문제가 발생한 커밋을 모를 때: `git bisect`

## 서브모듈

- `submodule.recurse=true` 설정

## 번들링

## replace

## 자격 증명 시스템

- HTTP 프로토콜에서 자동으로 인증하는 헬퍼
- `cache` 또는 osxkeychain, GCM만 사용할 것
- 사용자화 가능
