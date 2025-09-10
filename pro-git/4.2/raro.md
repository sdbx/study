# 4.2 Git on the Server - Getting Git on a Server

## SSH를 이용한 깃 서버 세팅법

요약: SSH 서버 + bare 레포

관습상 bare 레포 이름엔 `.git` 접미사를 붙임

### bare 레포 만들기

#### 기존 프로젝트가 있는 경우

- ```bash
  # 로컬
  $ git clone --bare study study.git
  $ scp -r study.git git@tnraro.com:/srv/git
  ```

#### 새 프로젝트의 경우

- ```bash
  # 서버
  $ mkdir -p /srv/git/project.git
  $ cd /srv/git/project.git
  $ git init --bare
  ```

읽기 권한이 있다면 fetch가 가능하고, 쓰기 권한이 있다면 push도 가능

### 접근 권한을 주는 방법

- 사용자를 일일이 만들기 (번거롭다)
- 공통 유저 `git`을 만들고 SSH 공개 키를 받아서 `~/.ssh/authorized_keys`에 추가
- 이미 LDAP나 다른 중앙화된 인증이 있다면 그것을 사용

참고: 서버의 계정은 커밋의 author나 committer에 영향을 주지 않음
