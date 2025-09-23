# 5.4 Distributed Git - Summary

## 분산 환경에서 깃을 쓰는 방법

- 모든 개발자는 노드이며 허브
- [마틴 파울러의 Patterns for Managing Source Code Branches](https://martinfowler.com/articles/branching-patterns.html)

### Centralized Workflow

- 하나의 원격 레포(hub)에 직접 작업함
- Git은 fast-forward할 수 없다면 push를 거부하기 때문에 실수할 염려 없음
- 이미 중앙화된 워크플로우에 익숙하다면 적용하기 좋음
- 브랜칭과 결합하면 대규모 팀에서도 활용 가능

### Integration-Manager Workflow

- 기준 레포를 복제해서 작업하고, 복제한 공개 저장소를 통합관리자에게 병합해달라고 요청함.

1. 기준 레포를 clone 후 작업
2. 작업물을 자신의 공개 레포에 push
3. 통합관리자에게 공개 레포를 pull해달라고 요청
4. 통합관리자는 원격 레포로 추가하고 병합
5. 통합관리자는 병합 후 기준 레포에 push

- GitHub 등에서 흔히 쓰는 방식
- 기여자와 통합관리자 모두 병합하는 시점이 디커플링됨

## 기여하는 방법

- 공백 오류 검출: `git diff --check`

### 양질의 커밋 작성하기

- 논리적으로 구분한 커밋: 이슈당 최소 하나의 커밋 만들기

  - `git add -p`로 필요한 내용만 스태이징 가능
  - ⇒ 리뷰하기 쉽게 만듦
  - ⇒ 변경점을 가져오거나 복구하기 쉽게 만듦

- 제목: 50자 이내의 요약. 명령형으로 작성
- 본문: (선택) 구현 동기, 이전 동작과 비교 등을 작성. 한 줄을 띄우고 작성해야함.

### 작은 팀의 private 협업

- 2~3명 정도의 개발자가 private 레포에서 작업하는 방법

1. 작업을 함(보통 토픽 브랜치에서)
2. 작업이 완료되면 main에 병합함
3. 서버에 공유하기 전에 fetch + merge함
4. push함

### 하위 팀이 있는 private 협업

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

## 프로젝트 유지보수하기

### 토픽 브랜치

- 새 작업을 시도할 때 사용
- 쉽게 수정하고, 필요해질 때까지 방치할 수 있음
- 작업에 기반한 이름을 부여하면 나중에 찾기 쉬움
- 유지보수자는 프로젝트에 기여한 사람의 이름의 약칭을 네임스페이스로 사용하는 경향이 있음

### 이메일에서 패치 적용하기

- 기여자가 보낸 패치 형식에 따라 다른 명령어로 적용
- 우선 토픽 브랜치에 적용하는 것이 일반적
- (레거시) `git diff`, `diff` 등으로 생성한 경우
  - `git apply <patchfile>`
  - 파일 추가, 삭제, rename 지원
  - 모두 적용하거나 모두 무시
  - 별도의 커밋을 만들지 않음
  - dry-run with `git apply --check`
- `git format-patch`로 생성한 경우
  - `git am <mboxfile>`
  - am: apply a series of patches from mailbox
  - mbox: 하나 이상의 이메일 메시지를 담은 plain-text 포맷
  - 충돌이 발생할 경우 충돌 마커를 만듦. 수동으로 해결 후 `git am --resolved` 실행
  - `-3` 옵션으로 3-way merge를 시도하도록 만들 수 있음. 단, 기준 커밋이 병합할 레포에 있어야함
  - `-i` 옵션으로 상호작용 모드를 실행할 수 있음. 각 패치마다 적용 여부를 물어봄.

### 공개 레포에서 가져오기

- 기여자가 공개 레포의 URL와 원격 브랜치 이름을 보낸 경우
- remote를 추가하고 fetch 하고 switch 하거나
- `git pull <URL>`로 remote에 추가하지 않고 한 번만 가져올 수 있음
- 커밋 히스토리를 가져올 수 있기 때문에 3-way merge가 기본값임

### 기여자가 추가한 작업 보기

- main에 병합하기 전에 어떤 내용이 추가될지 검토
- B에는 없고, A에만 있는 모든 커밋 보기: `git log A --not B`
- A와 B의 공통 조상부터 A최근커밋까지의 모든 커밋 보기: `git diff B...A`
- 공통 조상이 B라면 `git diff B`도 가능

### 기여한 작업을 통합하기

#### 병합 워크플로우

- 토픽 브랜치를 long-running 브랜치에 병합하는 방식
- `main` <- `develop` <- `integrated`

#### rebase와 cherry-pick

- 선형적 히스토리를 만듦
- rebase: 토픽 브랜치에서 `git rebase main` 후 `main`을 fast-forward
- cherry-pick: `git cherry-pick <가져올커밋해시>`, 커밋 하나만 가져옴
- 병합 후 토픽 브랜치 제거

#### rerere

- 충돌 전후 이미지를 기록했다가 유사한 충돌 발생시 자동으로 해결하는 도구
- `git config --global rerere.enabled true`

### 릴리즈에 태그 붙이기

- `git tag -s v1.5 -m 'my signed 1.5 tag'`

### 빌드 넘버 만들기

- `git describe main` => `v1.6.2-rc1-20-g8c5b85c`
- 최근 태그 이름, 태그 이후 커밋 수, g(Git을 의미), 커밋 해시의 일부를 조합한 문자열을 생성
- 태그와 같다면 태그 이름만 출력
- `--tags`: lightweight tag도 활용

### 소스 코드 압축 파일 만들기

- `git archive <branch>`

```bash
# tarball
git archive main --prefix='project/' | gzip > `git describe main`.tar.gz

# zip
git archive main --prefix='project/' --format=zip > `git describe main`.zip
```
