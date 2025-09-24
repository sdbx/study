# 5.4 요약
5장은 분산된 환경에서의 git 사용법을 조명한 장이었다.

## 5장 1절
분산된 워크플로우의 개념과 그 종류에 대해 설명하는 절이었다.

- 기여자와 관리자
- 중앙 집중식[centralized] => 하나의 중앙 서버가 코드를 받아들임.
- 통합 관리자[integration manager] => 기여자가 원본 저장소를 fork한 뒤 작업함. 관리자에게 pull 요청.
- 집정관과 부관[dictator and lieutenant] => 한 명의 선임관리자가 저장소의 각 부분을 전담하는 관리자 여러 명을 두는 방식.
- 분산 시스템인 git에서 일반적으로 사용되는 워크플로우들이 존재하며, 각 프로젝트의 사정에 맞추어 변화 가능.

## 5장 2절
기여자 역할을 하는 방법에 대해 조명한 절이었다.

- 여러가지 변수에 의해, 프로젝트별로 기여하는 방식이 다름을 이해한다.
   - 활동하는 기여자 수, 선택된 워크플로우, 나에게 주어진 권한, 별도의 기여 방법이 있는지
- 커밋 메시지는 알기 쉽고 간결하게 작성해야 한다.
   - 커밋 전에 불필요한 공백을 제거하려면 `git diff --check` 를 수행한다.
   - 각각의 커밋을 논리적으로 구분되는 변경사항으로 만든다.
   - 하나의 커밋에 적절한 양만을 담도록 한다.
   - 파일을 부분적으로 stage하려면 `git add -p` 를 사용한다.
   - 커밋 메시지 양식이 존재한다.
- `git log --no-merges branchA..branchB` => branchB에만 있고 branchA에는 없는 커밋을 출력하라. => 7장 1절 참고
- `git rebase -i` => 7장 6절 참고
- `git merge --squash` => 한 브랜치에 있는 내용을 하나의 커밋으로 만들어 내가 현재 위치한 브랜치에 옮긴다. 머지 커밋은 생성되지 않는다.
- `git request-pull <base-branch> <url>` => 내 토픽 브랜치가 base-branch에 병합되었으면 좋겠고 내 레포지토리의 주소는 url이다.
- `git format-patch -M <branch>` => 현재 브랜치에는 있는데 branch에는 없는 커밋들을 모두 추출하라. -M => 파일 rename을 감지하라.

## 5장 3절
관리자 역할을 하는 방법에 대해 조명한 절이었다.

- 토픽 브랜치에 받은 패치를 적용해서 테스트해본다.
   - 기여자 이름을 namespace로 활용할 수 있다. => cor/fix-code
- 패치파일이 (git) diff로 생성되었다면 `git apply [--check] <patchfile>` 으로 적용한다. 직접 stage 및 commit해야 한다.
- 패치파일이 git format-patch로 생성되었다면 `git am [-i] <patchfile>` 으로 적용한다. 커밋이 자동으로 생긴다.
   - `-3` 옵션에 대해서는 어떻게 동작하는 것인지 잘 이해할 수 없었다.
- pull request 방식의 기여를 받으려면 해당 url을 remote로 등록 후 fetch한 뒤 `git checkout -b <branchname> <remote>/<branchname>`한다.
- `git log [-p] topic --not master` 혹은 `git log master..topic` => 토픽 브랜치에는 있지만 마스터 브랜치에는 없는 커밋 보기
- `git diff master...topic` => 토픽 브랜치를 마스터 브랜치에 병합했을 때 발생할 전체 diff 보기 (토픽 브랜치의 마지막 커밋과 마스터 브랜치와의 공통조상 사이의 diff 계산임)
- 기여된 작업을 통합하는 방식에는 여러가지가 있다.
   - 바로 main에 병합
   - 2단계 병합 => long-running 브랜치인 master와 develop 유지
   - rebase와 cherry-pick 사용
- `git describe` => 빌드번호 생성
- `git archive` => 압축파일 생성
- `git shortlog` => 마지막 릴리즈 이후 변경사항 획득

## 5장 4절
효과적인 깃 개발자가 된 것에 대해 박수를 치자.