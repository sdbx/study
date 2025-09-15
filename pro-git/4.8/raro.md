# 4.8 Git on the Server - GitLab

GitLab: 데이터베이스가 있는 깃 관련 웹 어플리케이션

- 설치: <https://about.gitlab.com/install/>
- 개념:
  - 관리자: 웹 인터페이스 제공
  - namespace: 프로젝트의 논리적 묶음. 유저 또는 그룹임.
  - 유저
  - 그룹: 프로젝트 모음(GitHub의 Organization)
    - 유저마다 다른 권한 레벨 부여
  - 프로젝트: 대략 깃 레포와 대응
    - namespace에 속함
    - 가시성 레벨: private, internal, public
    - members
      - Developer 이상이면 push 가능
    - merge request
    - issue
    - wiki 등
  - 훅
    - 프로젝트와 시스템에 관련된 이벤트가 발생하면 JSON을 보냄
