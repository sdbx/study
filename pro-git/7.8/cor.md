# 7.8 고급 병합 기법

## 학습목표
-

## 병합 충돌
### 팁
(충돌이 있을지도 모르는) 병합을 하기 전에 작업영역을 깨끗하게 만들어라.
- 작업중인 것이 있으면 임시 브랜치에 커밋하든지 스태시하라.
- 깨끗하게 만드는 이유는 되돌리기를 가능하게 하기 위해서임

### 병합 이전으로 돌아가기
병합 충돌이 발생했을때 병합하기 이전 상태로 돌아가고 싶다면
- `git merge --abort`
- `git reset --hard HEAD`
   - 마지막 커밋상태로 되돌아감으로써 처음부터 다시 시작하기
   - 커밋되지 않은 작업은 날라감

### 공백 무시하기
- 충돌사항을 봤을때 한쪽에서는 모든 줄이 지워지고 다른 쪽에서는 다시 추가되고 있다 => 이 충돌은 공백에 관련된 문제를 가지고 있다
- 기본 병합 전략은 인자를 취할 수 있고 그 중 일부는 공백 변화를 적절하게 무시하기 위함
- 공백으로 인한 충돌이라면, 병합을 abort한 뒤 다음의 인자로 병합 재시도
   - `-Xignore-space-change`: 줄을 비교할때 공백을 완전히 무시
   - `-Xignore-all-space`: 하나 이상의 공백문자열을 동등하게 취급

### 수동으로 파일 병합하기
- 파일을 수동으로 병합하려면 한 파일의 3가지 버전의 사본이 필요함
   - our version: 내가 가지고 있는 파일의 버전
   - their version: 병합하려는 브랜치에 있는 파일의 버전
   - common version: 양 브랜치가 시작된 곳에 있는 파일의 버전 (공통조상)
- our을 고치든지 their을 고치든지 한 뒤 병합을 재시도하는 것임
- 이 파일들은 merge conflict 상태에서 쉽게 획득 가능
   - 이 파일들은 전부 index 내 stages에 보관되어 있으며 각 파일들을 지칭하는 숫자가 있음
      - stage 1 = common ancestor
      - stage 2 = our
      - stage 3 = `MERGE_HEAD` = their
   - 획득방법
      - `git show :<n>:<file> > file.<common|ours|theirs>`
      - 혹은 `git ls-files -u` 로 각 파일에 대한 git blob의 sha-1 획득 가능
         - `-u|--unmerged`: 출력에 병합되지 않은 파일 표시
      - `:<n>:<file>` = 해당 파일의 sha-1를 찾기 위한 약칭
- 이후 필요에 맞춰 적절히 수정한다
- `git merge-file -p <current> <base> <other> > <file>` 로 직접 병합한다
   - `-p`: current 파일을 직접 수정하지 않고 결과를 표준 출력에 보낸다
- 실제로 병합 작업을 완료하기 전에 `git diff` 를 통해 "수동 병합한 파일(이하 결과)"을 stage 1, 2, 혹은 3과 비교할 수 있음
   - `git diff --ours`: 결과와 ours를 비교하기 => theirs가 도입하는 변경사항 확인하기
   - `git diff --theirs`: 결과와 theirs를 비교하기 => ours가 도입하는 변경사항 확인하기
   - `git diff --base`: 결과를 common과 비교하기 => theirs와 ours가 도입하는 변경사항 확인하기
- 병합 작업이 마무리되었으니 `git clean -f`로 수동 병합에 사용했던 파일들 삭제

### checkout으로 충돌의 맥락 파악하기
- `git checkout --conflict[=diff3|merge] <file>`
   - 파일을 다시 checkout한 뒤 merge conflict marker를 재배치한다.
   - marker를 초기화하고 충돌을 다시 해결하려고 할 때 유용하다.
   - `diff3`를 지정하면 ours와 theirs뿐만 아니라 base까지 같이 나옴
   - `merge`가 기본값
- `git checkout --ours|--theirs`
   - 한쪽을 고를 수 있음

### log를 통해 맥락 파악하기
- `git log --oneline --left-right HEAD...MERGE_HEAD`
   - 이 병합에 관련된 각 브랜치에 있는 고유한 커밋들 출력
- `git log --oneline --left-right --merge`
   - 현재 충돌이 난 파일을 건드린 커밋들만을 출력
- `git log ... -p`
   - 충돌이 난 파일의 diff 출력

### combined diff format 읽는 방법
- merge conflict가 발생한 직후 `git diff`를 실행하면 combined diff를 볼 수 있음
- 각 줄의 시작에 두개의 열이 생김
   - 첫번째 열은 이 줄이 ours와 작업영역에 있는 파일 사이에서 다른지(added/removed)를 보여줌
   - 두번째 열은 첫번째 열과 같으나 theirs와 작업영역을 비교하는 것만 다름
   - 추가된 줄 + / 제거된 줄 - / 변경 없으면 공백
- 병합 이후에도 combined diff format을 확인할 수 있음
   - 머지커밋에 대해 아래의 명령 실행
   - `git log --cc -p`
      - `-p`는 기본적으로 비머지커밋에 대해서만 패치를 출력
   - 혹은 `git show <merge-commit>`

## 병합 되돌리기
내가 처한 상황에 따라 적절하게 병합을 되돌릴 수 있음

### HEAD가 가리키는 레퍼런스를 되돌리기
- 잘못된 `git merge` 이후 `git reset --hard HEAD~` 하기
- 이것은 이력을 재작성하는 것이기 때문에 이미 공유된 커밋이라면 협업시 문제가 발생할 수 있음 (리베이스처럼)
- 그리고 만약 git merge 이후 새로운 커밋을 만들었다면 그 커밋을 잃어버리게 됨

### revert하기
- `git revert -m 1 HEAD`
   - `-m 1`의 뜻 = 첫번째 부모가 mainline이고 유지되어야 함
   - 두번째 부모를 병합함으로써 도입된 모든 변경사항이 undo됨
- 그런데, revert를 하면 취소커밋이 생김 => "Revert "Merge branch 'topic'"
- 요컨대 HEAD의 이력에 병합된 커밋이 여전히 존재함
- 그래서 곧바로 `git merge topic`을 하면 up to date라고 나옴
   - master로부터 도달가능하지 않은 것이 topic에 없기 때문
- 이런 이유에서, topic에 새로 커밋을 만들고 master에 병합하면, 취소커밋 이후에 만들어진 변경사항만 병합됨
   - 이것을 해결하려면 취소커밋을 취소해야 함 => 즉, `git revert <취소커밋>` 해야 함.

## 다른 유형의 병합
- 그동안 우리가 다룬 것은 "recursive" 병합 전략에 의해 처리되는 두 브랜치의 병합이었음
- 다른 유형의 병합도 존재

### recursive 병합 전략의 ours/theirs 선호 옵션
- recursive 병합 전략에 인자를 전달할 수 있음
- `git merge` 명령어에 `-Xours` 혹은 `-Xtheirs` 옵션을 명시하면 충돌이 났을때 알아서 명시한 쪽을 선택해 병합을 진행함
- 충돌이 난 부분에 대해서만 명시한 쪽을 선호하고, 충돌이 나지 않은 부분은 정상적으로 병합됨
- `git merge-file` 명령어에도 같은 인자 전달 가능

### ours 병합 전략
- 방금 언급한 `-Xours` 옵션과는 다른, `ours` 병합 전략이 존재함
- 선호하지 않는 쪽을 **완전히 배제**하는 전략임
- 한마디로 fake merge를 하는 것임. 두 브랜치가 부모로서는 기록되나, 내가 병합하는 브랜치를 아예 쳐다보지도 않음
- 즉, 현재 브랜치의 내용과 완전히 같음
- 나중에 병합할 때 깃으로 하여금 어떤 브랜치가 이미 병합되었다고 생각하게 만들 수 있음 (실제로는 그 브랜치의 변경사항이 포함되지는 않았지만)

```bash
$ git merge -s ours <branch>
$ git diff HEAD HEAD~
# 아무것도 안 나옴
```

### subtree 병합
- subtree merge의 개념은, 두 개의 프로젝트가 있는데 한 프로젝트가 다른 프로젝트의 subdirectory에 연결되어 있는 것임
- 예를 들어 별도의 프로젝트를 기존 프로젝트에 remote로 추가하고 fetch한 후 `checkout -b sep remote/master` 했다고 하자.
- sep에 위치했을때와 master에 위치했을때 각각 ls을 해보면 각자 별도의 프로젝트 root을 가진다는 것을 알 수 있음
- 즉, 내 레포지토리 내의 모든 브랜치가 **꼭 같은 프로젝트의 브랜치일 필요는 없는 것**임.
- remote 프로젝트를 내 프로젝트에 subdirectory로서 pull하려면...
   - `git read-tree --prefix=myremote/ -u sep`
      - `-u` 옵션을 주면 working tree가 merge의 결과로 갱신되는 듯함
- 이후 커밋하면 remote 프로젝트의 모든 파일이 myremote 서브디렉토리 아래에 있는 것처럼 보이게 됨
- 만약 remote 프로젝트가 업데이트되면
   - sep으로 checkout한 뒤 pull하고,
   - 다시 master로 checkout한 뒤 `git merge --squash [-s recursive] -Xsubtree=myremote sep` 실행
   - 이러면 remote 프로젝트의 변경사항이 merge되고 로컬에서 커밋할 준비가 됨
- 역으로, myremote 서브디렉토리에서 변경사항을 만들고 sep에 병합해 추후에 메인테이너에게 제출하거나 upstream에 push할 수 있음
- 이러한 workflow는 서브모듈의 사용하지는 않지만 서브모듈을 사용하는 workflow와 비슷함
   - 모든 커밋이 하나의 장소에 커밋되는 것과 같은 장점이 있음
   - 그러나 다소 복잡하며 실수하기 쉽다는 단점이 있음.
- 한편, subtree의 diff를 보려면 일반적인 `diff` 대신 `diff-tree`를 사용해야 함
   - sep을 병합할 필요가 있는지 확인하고 싶을 때 도움이 된다
   - `git diff-tree -p <branch-to-compare>`
      - `-p`: 패치 생성
      - `~ sep` => myremote 서브디렉토리와 sep 브랜치간의 diff 보기
      - `~ remote/master` => myremote 서브디렉토리와 remote/master간의 diff 보기

## 기타
- `git diff -b|--ignore-space-change`: 공백을 무시
- `git status -sb`: 출력을 short-format으로 출력하고 브랜치와 tracking 정보도 같이 출력

## 영어 공부
- make it so that: to cause sth to be the case; to have sth be the case
- at one's disposal[디스포우즐]: 마음대로 이용할 수 있는
- determine[디털민]: 밝히다, 결정하다
- replace[리플레이스]: 다시 놓다
- particularly[펄티켤럴리]: 특히
- total[토우틀]: 총
- by mistake: 실수로
- errant[에런트]: 잘못된
- lose[루즈]: 잃어버리다
- scenario[서내리오]: 시나리오
- cancel out: 상쇄되다
- in whole: 전부, 통째로
- draconian[드러코우니언]: (격식) 매우 엄격한, 가혹한
- clarity[클래러티]: 명료성
