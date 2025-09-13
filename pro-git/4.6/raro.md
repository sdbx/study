# 4.6 Git on the Server - Smart HTTP

- CGI 호환 서버에서 `git-http-backend`를 호출하면 됨

  ```bash
  GIT_PROJECT_ROOT=/srv/git  # 깃 레포 경로
  GIT_HTTP_EXPORT_ALL        # git-daemon-export-ok 파일을 레포에 일일이 두지 않아도 되게 만듦
  ```

- Git 클라이언트 버전을 식별하여 dumb fallback도 제공
- 인증은 웹 서버에서 제어

  - query string에 `service=git-receive-pack`가 있거나,
  - path에 `^/git/.*/git-receive-pack$`가 있으면 인증 필요
  - 인증을 아예 안 걸면 403 Forbidden 발생
