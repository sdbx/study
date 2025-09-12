# 4.5 Git on the Server - Git Daemon

특징: 비인증, 공개, 읽기 전용

Git 프로토콜 데몬을 설정하는 방법

1. `git daemon --reuseaddr --base-path=/srv/git/ /srv/git/`를 실행하고
   - 방화벽이 있는 경우 9418 포트 열기
   - OS에 맞는 방법으로 서비스 등록하기
2. 인증 없이 공개해도 되는 레포에 `git-daemon-export-ok` 파일을 만든다.
