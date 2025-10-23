# 10.5 Git Internals - The Refspec

## Refspec

- 리모트와 로컬의 참조를 매핑

### 구조

- `+<src>:<dst>`
  - `+`: (선택) fast-forward가 아니더라도 참조를 업데이트
  - `<src>`: 출처 참조 패턴
  - `<dst>`: 목적지 참조 패턴
- glob 패턴: `refs/heads/qa*:refs/remotes/origin/qa*` (Git 2.6.0 이후)
- 네임스페이스(=디렉토리): `refs/heads/qa/*:refs/remotes/origin/qa/*`

### 사용

- 여러번 명시할 수 있음
- config 파일의 remote 섹션에 명시하면 명령어 실행시 기본값으로 사용

  ```gitconfig
  [remote "origin"]
    url = ...
    fetch = +refs/heads/*:refs/remotes/origin/*
  ```

```bash
# 명령줄에서는 모두 동치 (모두 refs/remotes/origin/main으로 확장됨)
$ git log origin/main
$ git log remotes/origin/main
$ git log refs/remotes/origin/main
```

#### fetch

- src: 리모트
- dst: 로컬

##### 명령줄

```bash
$ git fetch origin '+refs/heads/main:refs/remotes/origin/mymain' \
                   '+refs/pull/*/head:refs/remotes/origin/pr/*'
```

##### 구성

```gitconfig
[remote "origin"]
  url = ...
  fetch = +refs/heads/*:refs/remotes/origin/*
  fetch = +refs/pull/*/head:refs/remotes/origin/pr/*
```

#### push

- src: 로컬
- dst: 리모트

##### 명령줄

```bash
$ git push origin main:refs/heads/qa/main
```

##### 구성

```gitconfig
[remote "origin"]
  url = ...
  fetch = ...
  push = refs/heads/main:refs/heads/qa/main
```

#### 리모트 참조 지우기

```bash
# 리모트 topic 브랜치를 아무것도 아닌 것으로 만듦
$ git push origin :topic

# Git 1.7.0 이후
$ git push origin --delete topic
```
