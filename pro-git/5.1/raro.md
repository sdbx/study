# 5.1 Distributed Git - Distributed Workflows

## 분산 환경에서 깃을 쓰는 방법

- 모든 개발자는 노드이며 허브임. 따라서 워크플로우를 유연하게 가질 수 있음
- Centralized Workflow
  - 하나의 원격 레포(hub)에 직접 작업함
  - Git은 fast-forward할 수 없다면 push를 거부하기 때문에 실수할 염려 없음
  - 이미 중앙화된 워크플로우에 익숙하다면 적용하기 좋음
  - 브랜칭과 결합하면 대규모 팀에서도 활용 가능
- Integration-Manager Workflow
  - 기준 레포를 복제해서 작업하고, 복제한 공개 저장소를 통합관리자에게 병합해달라고 요청함.
  1. 기준 레포를 clone 후 작업
  2. 작업물을 자신의 공개 레포에 push
  3. 통합관리자에게 공개 레포를 pull해달라고 요청
  4. 통합관리자는 원격 레포로 추가하고 병합
  5. 통합관리자는 병합 후 기준 레포에 push
  - GitHub 등에서 흔히 쓰는 방식
  - 기여자와 통합관리자 모두 병합하는 시점이 디커플링됨
- Dictator and Lieutenants Workflow
  - Linux 커널같이 위계적이고 큰 프로젝트에서 사용
  - 독재자 혼자 참조 레포를 관리
  - 레포의 각 파트를 담당하는 부관이 있음
  1. 일반 개발자는 토픽 브랜치에서 작업하고 참조 레포 main에 rebase
  2. 부관은 기여자의 토픽 브랜치를 그들의 main에 병합
  3. 독재자는 부관의 main 브랜치를 자신의 main 브랜치에 병합
  4. 독재자는 main 브랜치를 참조 레포에 push
- [마틴 파울러의 Patterns for Managing Source Code Branches](https://martinfowler.com/articles/branching-patterns.html)
