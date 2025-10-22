# 10.4 Git Internals - Packfiles

객체의 저장 방식:

- loose 객체 포맷: 객체를 디스크에 저장하는 초기 형식(`.git/objects/xx/xxx...xxx`)
- packfile:
  - 이름과 크기가 비슷한 파일을 찾아서, 최근 것은 원본 그대로 남기고, 이전 버전을 delta로 만듦(최근 버전에 접근할 가능성이 높기 때문)
  - 만들어지는 조건: 가비지 컬랙팅 실행시, 원격 서버에 push
  - `.pack`: packfile. 파일 시스템에서 제거된 모든 객체의 내용을 담음
  - `.idx`: 목차. 객체의 packfile offset을 담음
  - 어느 커밋에도 속하지 않은 dangling 객체는 포함되지 않음
  - 여러번 repack 해도 문제 없음
  - `git verify-pack`: 무엇이 패킹되었는지 확인
