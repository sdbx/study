# 7.11 Git Tools - Submodules

## 서브모듈

- 한 저장소를 다른 저장소의 하위 디렉토리로 유지하는 기능
- 독립적인 히스토리를 유지하면서 동시에 개발 가능
- 특정 버전에 고정되므로, 하위 프로젝트는 독립적으로 개발 하고, 상위 프로젝트는 원하는 시점에 새 버전으로 업데이트 가능
- 상위 프로젝트와 하위 프로젝트를 동시에 작업할 필요가 없다면 의존성 관리 도구를 사용하는 것이 더 간편
- 최신 깃 서브모듈은 최상위 프로젝트의 `.git`에 서브모듈 정보를 담아서, 서브모듈을 제거해도 커밋과 브랜치를 잃지 않음

### 관련 명령어와 설정

- `git status`
  - `status.submodulesummary=1` 설정: 서브 모듈 변경 사항의 짧은 요약 포함
- `git diff`
  - `--submodule`:
    - `diff.submodule=log`설정과 같음
- `git log -p --submodule`: 서브 모듈 정보 표시
- `submodule.recurse=true`: `clone`을 제외한 지원 명령에 `--recurse-submodules` 플래그를 자동으로 붙임

### 서브 모듈 추가

- `git submodule add <URL> [<path>]`
  - `.gitmodules` 파일 생성: 서브모듈 경로와 URL을 기록. 버전 관리됨
- `git commit` 하면 `160000` 모드로 서브모듈 디렉토리를 생성.

### 서브 모듈 클론

```bash
$ git clone --recurse-submodules <URL>

# 또는

$ git clone <URL>                         # 이미 해버린 경우
$ git submodule update --init --recursive # init + update

# 또는

$ git clone <URL>     # 서브모듈의 디렉토리만 가져오고 내용물은 가져오지 않음
$ git submodule init  # 로컬 설정 파일 초기화
$ git submodule update --recursive # 모든 데이터를 가져오고 적절히 체크아웃(detached HEAD)
```

### 서브 모듈에서 일하기

#### 원격 서브 모듈에서 변경 사항 가져오기

- `git submodule update --remote [<서브모듈이름>]`: 하위 디렉토리로 가서 fetch + 업데이트
- 추적할 원격 브랜치 변경: `submodule.서브모듈이름.branch=stable`
  - `.gitmodules`에 적용하면 모두에게 적용
  - `.git/config`는 개인만 적용
  - 참고: `git config -f .gitmodules submodule.서브모듈이름.branch stable`

#### 원격 프로젝트에서 변경 사항 가져오기

```bash
$ git pull --recurse-submodules # pull + update. Git 2.14 이상

# 또는

$ git pull # 재귀적으로 서브모듈 변경 사항을 가져오지만 서브모듈을 변경하지는 않음.
$ git submodule update --init --recursive
```

#### 서브모듈 URL이 변경된 경우

```bash
# 새 URL을 로컬 설정에 복사
$ git submodule sync --recursive
# 새 URL로부터 서브 모듈을 갱신
$ git submodule update --init --recursive
```

#### 서브모듈에서 작업하기

`submodule update`는 detached HEAD 상태로 만들기 때문에, 별도의 브랜치를 두어야 로컬 작업이 날아가지 않음

```bash
# 브랜치 체크아웃
$ cd 서브모듈이름/
$ git switch main

# 병합 또는 rebase
$ cd ..
$ git submodule update --remote --merge
# git submodule update --remote --rebase
```

병합을 깜빡한 경우 (1) 하위 디렉토리로 돌아가서 (2) 브랜치를 체크아웃하고 (3) 원격추적브랜치를 수동 병합

작업 디렉토리에 변경사항이 남아있으면 `update`는 변경사항을 받기만 하고 작업을 덮어쓰지는 않음

병합 간 충돌이 발생하면 하위 디렉토리로 들어가서 해결하면 됨

#### 서브모듈 변경 사항 올리기

```bash
# 커밋된 서브모듈 변경 중 하나라도 푸시되지 않았다면 푸시 자체가 실패됨
$ git push --recurse-submodules=check

# 필요한 서브 모듈 푸시를 자동으로 함
$ git push --recurse-submodules=on-demand
```

기본값으로 만드는 설정: `git config push.recurseSubmodules <check|on-demand>`

#### 서브모듈을 동시에 수정한 경우 병합

non-fast-forward인 경우 사소한 병합도 시도하지 않고 실패함

1. `git diff`로 SHA-1를 알아내고
1. 수동으로 병합을 시도한다. (브랜치를 만드는 것을 권장)

"merge following commits not found": 두 커밋을 포함하는 병합커밋이 히스토리에 없는 경우 발생. 단, git의 안내를 따라 병합하는 것보다 수동으로 테스트하고 커밋하는 것을 권장

### 서브모듈 팁

- `git submodule foreach <명령>`: 각 서브모듈에 임의의 명령을 실행
  - `git submodule foreach 'git stash'`: 모든 서브모듈을 stash
  - `git submodule foreach 'git switch -c featureA'`: 모든 서브모듈에 새 브랜치를 만들고 전환
  - `git diff; git submodule foreach 'git diff'`: unified diff 만들기
- 유용한 별칭

  ```bash
  $ git config alias.sdiff '!'"git diff && git submodule foreach 'git diff'"
  $ git config alias.spush 'push --recurse-submodules=on-demand'
  $ git config alias.supdate 'submodule update --remote --merge'
  ```

### 자잘한 오류

#### 브랜치 이동

2.13 이전 버전에는 브랜치 이동이 문제였음. `git switch`에 `--recurse-submodules`를 주면 해결됨.

#### 하위 디렉토리를 서브모듈로 전환

디렉토리를 지우고(인덱스 포함) 서브모듈을 추가해야함

전환시 발생하는 문제는 작업을 잃을 수 있지만 `checkout -f`로 전환하고 각 서브모듈에 대해 `git checkout .`를 해야함
