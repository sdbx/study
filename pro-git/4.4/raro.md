# 4.4 Git on the Server - Setting Up the Server

## 서버 세팅법

1. git-shell이 `/etc/shells`에 있는지 확인한다.
   1. `$ cat /etc/shells`에 없으면…
   2. `$ which git-shell`의 경로를
   3. `$ sudo -e /etc/shells`에 추가한다.
2. 공통 user를 만든다.
   - `# useradd -m -s $(which git-shell) git`

### 사용자 별

1. 접속할 사용자의 SSH 공개 키를 전달 받는다.
2. 제한을 포함한 SSH 공개 키를 `~/.ssh/authorized_keys`에 한 줄씩 붙여넣는다.
   - `no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty` + SSH public key

### 참고

- `no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty`는 SSH 포트포워딩을 막는다.
- git-shell 커마: `git help shell`
