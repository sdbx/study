# 5.3 Distributed Git - Maintaining a Project

## 토픽 브랜치

- 새 작업을 시도할 때 사용
- 쉽게 수정하고, 필요해질 때까지 방치할 수 있음
- 작업에 기반한 이름을 부여하면 나중에 찾기 쉬움
- 유지보수자는 프로젝트에 기여한 사람의 이름의 약칭을 네임스페이스로 사용하는 경향이 있음

## 이메일에서 패치 적용하기

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

## 공개 레포에서 가져오기

- 기여자가 공개 레포의 URL와 원격 브랜치 이름을 보낸 경우
- remote를 추가하고 fetch 하고 switch 하거나
- `git pull <URL>`로 remote에 추가하지 않고 한 번만 가져올 수 있음
- 커밋 히스토리를 가져올 수 있기 때문에 3-way merge가 기본값임

## 기여자가 추가한 작업 보기

- main에 병합하기 전에 어떤 내용이 추가될지 검토
- B에는 없고, A에만 있는 모든 커밋 보기: `git log A --not B`
- A와 B의 공통 조상부터 A최근커밋까지의 모든 커밋 보기: `git diff B...A`
- 공통 조상이 B라면 `git diff B`도 가능

## 기여한 작업을 통합하기

### 병합 워크플로우

- 토픽 브랜치를 long-running 브랜치에 병합하는 방식
- `main` <- `develop` <- `integrated`

### Git 프로젝트의 워크플로우

- `master`, `next`, `seen`, `maint`(백포트용)
- 토픽 브랜치가 바로 레포에 올라감. `raro/new-feature`
- 안전하다고 여겨지면 `next`에 병합, 추가 작업이 필요하면 `seen`에 병합
- 충분히 검증되면 토픽 브랜치를 `master`에 병합. `next`, `seen`은 `master`를 기반으로 rebase. 토픽 브랜치는 제거.
- 백포트 패치는 `maint`에서 작업

### rebase와 cherry-pick

- 선형적 히스토리를 만듦
- rebase: 토픽 브랜치에서 `git rebase main` 후 `main`을 fast-forward
- cherry-pick: `git cherry-pick <가져올커밋해시>`, 커밋 하나만 가져옴
- 병합 후 토픽 브랜치 제거

### rerere

- 충돌 전후 이미지를 기록했다가 유사한 충돌 발생시 자동으로 해결하는 도구
- `git config --global rerere.enabled true`

## 릴리즈에 태그 붙이기

- `git tag -s v1.5 -m 'my signed 1.5 tag'`
- 서명에 사용한 공개 PGP 키를 공유하면 다른 사람들이 태그를 검증할 수 있음. 태그에 검증 명령어를 적어두기도 함.
- PGP 키 공유 방법 중 하나: blob에 추가해서 공유

## 빌드 넘버 만들기

- `git describe main` => `v1.6.2-rc1-20-g8c5b85c`
- 최근 태그 이름, 태그 이후 커밋 수, g(Git을 의미), 커밋 해시의 일부를 조합한 문자열을 생성
- 태그와 같다면 태그 이름만 출력
- `--tags`: lightweight tag도 활용

## 소스 코드 압축 파일 만들기

- `git archive <branch>`

```bash
# tarball
git archive main --prefix='project/' | gzip > `git describe main`.tar.gz

# zip
git archive main --prefix='project/' --format=zip > `git describe main`.zip
```

## Shortlog

- `git shortlog --no-merges main`
