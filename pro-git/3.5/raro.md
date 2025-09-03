# 3.5 Git Branching - Remote Branches

## TL;DR

- 로컬 브랜치: 로컬에 있는 브랜치
  - 원격 추적 브랜치: 원격 브랜치의 위치를 나타내는 로컬 브랜치. 직접 수정 불가
  - 추적 브랜치: 원격 브랜치와 연관 있어서 push, pull 할 때 리모트와 브랜치 이름을 생략 해도 되는 브랜치
  - 업스트림 브랜치: 추적 브랜치가 추적하는 원격 추적 브랜치
- 원격 브랜치: 원격 레포지토리에 있는 브랜치

## 용어 정리

- remote reference: 원격 저장소에 있는 브랜치, 태그 등의 포인터
  - `git ls-remote <remote>`: 모든 원격 참조를 나열
  - `git remote show <remote>`: 원격 브랜치와 추가 정보를 보여줌
- remote-tracking branch
  - 원격 브랜치의 상태를 참조
  - 로컬 브랜치. 직접 이동 불가
  - 네트워크와 소통 할 때마다 알아서 이동
  - `<remote>/<branch>`
- tracking branch
  - 원격 브랜치와 직접적으로 관련있는 브랜치. `main`, `iss53`, …
  - push, pull을 할 때 서버와 브랜치 이름 생략 가능
- upstream branch
  - tracking branch에 대응하는 브랜치. `origin/main`, `origin/iss53`
- `git clone` 하면 일어나는 일
  1. 원격 저장소에 자동으로 origin이라는 이름을 붙임
  2. 모든 데이터를 내려 받음
  3. `origin/main`이라는 이름의 원격 추적 브랜치를 만듦. (이름에 특별한 의미가 있진 않음)
  4. `main`이라는 이름의 로컬 브랜치를 만듦
  - 참고: `git clone -o booyah`: 다른 리모트 이름 지정
- `git fetch` 하면 일어나는 일
  1. 원격에 있는 아직 가져오지 않은 모든 데이터를 가져와서 로컬 데이터베이스에 반영
  2. 관련된 원격 추적 브랜치도 이동
  - `clone`과 달리 서버에서 새로 추가된 브랜치는 로컬 브랜치를 만들지 않고, 원격 추적 브랜치만 만듦.
- 작업한 것을 서버에 올리기

  ```bash
  # 다 같은 뜻
  git push origin serverfix
  git push origin serverfix:serverfix
  git push origin refs/heads/serverfix:refs/heads/serverfix
  ```

  - `refs/head/` 부분은 10.3 Git Internals - Git References에서 자세히 배움
  - `a:b`는 로컬 브랜치 a를 원격의 b 브랜치에 푸시하라는 뜻

- 새로 생긴 원격 추적 브랜치를 사용하기

  - git fetch는 로컬 브랜치를 만들지 않기 때문에 작업하려면 가져와야함. 크게 병합하는 방법과 브랜치를 만드는 방법이 있음.

  ```bash
  # 아래 명령은 모두 같음
  git switch -c <branch> <remote>/<branch>
  git switch --track <remote>/<branch>
  git switch <branch> # 단, <branch>가 로컬에 없고, 서버 중 같은 이름의 브랜치가 하나만 있어야함
  ```

- 원격 추적 브랜치를 변경하고 싶은 경우
  - `git branch [-u|--set-upstream-to] <branchname>`
- 현재 브랜치의 upstream 브랜치 참조
  - `@{upstream}`이나 `@{u}`로 참조. 즉, iss53 브랜치에서 `git merge @{u}`는 `git merge origin/iss53`와 같음
- 추적 브랜치 확인
  - `git branch -vv`
  - ahead: 로컬에만 있는 커밋
  - behind: 서버에만 있는 커밋
- 원격 브랜치 삭제
  - `git push origin --delete <branch>`
  - 서버에서 포인터만 삭제. gc될 때까지 데이터는 남아 있음
