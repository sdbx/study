# 5.1 분산형 작업 흐름

## 학습목표
- 분산형 작업 흐름의 종류에 대해 알아본다.
- 각 작업 흐름의 특징에 대해 숙지한다.
- contributor로서 작업하는 방법에 대해 이해한다.
- integrator로서 작업하는 방법에 대해 이해한다.

## 개요
- 중앙집중형 버전관리시스템과는 다르게, git은 분산적임
- cvcs에서, 개발자는 중앙 hub과 일하는 node임
- git에서 개발자는 잠재적으로 node이면서 동시에 hub임
   - 다른 repo에 코드를 contribute할 수 있음
   - 다른 사람들이 기반으로 삼고 contribute할 수 있는 public repo를 관리할 수 있음
- git의 이러한 성격에 의해 다양한 workflow가 가능

## 중앙 집중형 작업흐름
- centralized workflow
- 하나의 central hub이 코드를 accept함
- 모두가 이 central hub과 자신의 작업을 synchronize함
- A라는 사람이 push를 하면 B라는 사람은 push하기 전에 먼저 fetch와 merge해야 함 (A가 만든 변경사항을 덮어쓰지 않도록)
- 많은 사람들에게 친숙함
- 깃의 branch 기능을 사용한다면 많은 개발자가 있더라도 동시에 작업할 수 있음

## 통합 관리형 작업흐름
- integration-manager workflow
- 각 개발자가 자신의 공개 repo에 write 권한이 있고 다른 사람의 repo에는 read 접근만 가능
- 아래의 순서를 따름.
   1. 프로젝트 관리자는 공개 repo에 push함
   2. 기여자는 해당 repo를 clone한 뒤 변경사항을 만듦
   3. 기여자가 자신의 공개 copy에 push함
   4. 기여자가 관리자에게 자신이 만든 변경사항을 pull해달라고 요청하는 이메일을 보냄
   5. 관리자는 기여자의 repo를 remote로 등록하고 로컬에서 시험해본 뒤 자신의 브랜치에 merge함
   6. 관리자는 merge된 변경사항을 main repo에 push함
- hub-기반 툴인 GitHub이나 GitLab에서 매우 일반적인 작업 흐름
   - 프로젝트를 fork하는 것이 쉬움
   - 모두가 보도록 내 fork에 변경사항을 push하기 쉬움
- 이 방식의 장점
   - 나는 계속 작업할 수 있고 main repo의 관리자는 언제든지 내 변경사항을 pull할 수 있음
   - 기여자는 내 변경사항이 포함될때까지 기다리지 않아도 됨

## 집정관과 부관 작업흐름
- dictator and lieutenant workflow
- 수백명의 참여자가 있는 거대한 프로젝트에서 사용되는 작업 흐름
- 실제로 해본적이 없어서 정확히 어떻게 돌아가는지는 잘 와닿지 않네
- 여러명의 integration manager는 repo의 특정 부분을 전담함. 이들을 lieutenant라고 함.
- lieutenant들은 통괄하는 한 명의 integration manager가 있고 이를 dictator라고 함.
- dictator는 자신의 디렉토리를 reference repo (= blessed repo) 에 push하고 모든 참여자들은 이 repo를 pull해야 함
- 아래의 순서를 따름.
   1. 일반 개발자는 blessed repo를 clone/pull하는 것으로 보임. 여기서 topic branch를 만들어 작업하고 master 브랜치에 작업물을 rebase함 (ref. repo의 master 브랜치를 의미)
   2. lieutenant는 일반 개발자의 topic branch를 자신의 master 브랜치로 merge함
   3. dictator는 lieutenant의 master 브랜치를 자신의 master 브랜치로 merge함
   4. dictator는 자신의 master 브랜치를 ref. repo에 push하여 다른 개발자가 그 위에 rebase할 수 있도록 함
- 즉 프로젝트 리더가 통합 작업의 상당수를 하위 책임자에게 위임할 수 있게 하며 여러군데로부터 코드의 subset을 수집할 수 있게 함

## 요약
- 분산시스템인 git에서 일반적으로 사용되는 workflow들이 있음
- 현실의 필요에 맞는 variation도 가능함

## 영어 공부
- focal point: (관심, 활동의) 초점
- afford: 제공하다
- more or less: 거의
- match: 연결시키다
- canonical[커나니클]: 권위있는, 규범적인, 공인된, 정통파의, 표준적인
- lieutenant[루테넌트]: 부관
- benevolent[버네벌런트]: 자애로운
- hopefully: 바라건대 (= it is to be hoped that)