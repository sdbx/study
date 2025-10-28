# A2.1 Appendix B: Embedding Git in your Applications - Command-line Git

자체 프로그램에 Git을 임베드 할 일이 종종 있음. 크게 두 가지 방법이 있음

## 명령 줄 사용하기

- 셸 프로세스를 spawn하고, Git 명령 줄 도구를 사용
- 장점
  - 모든 Git 기능 사용 가능
- 단점
  - 모든 출력은 plain text여서 파싱해야함 (가끔 바뀔 수 있음)
  - 오류 복구가 어려움
  - 프로세스 관리가 의도치 않은 복잡성을 추가함
