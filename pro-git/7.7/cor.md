# 7.7 리셋

## 학습목표
- git reset에 대해 이해한다.

## 개요
- git reset과 git checkout은 많은 일을 하기 때문에 처음 봤을 때는 좀처럼 이해하기 힘들 수 있음
- 간단한 비유를 통해 머릿속에 개념을 우선 잡도록 하자.

## 세 개의 트리
- 깃을 세 개의 트리를 다루는 파일 관리자라고 생각하자.
- 여기서 말하는 트리의 뜻은 "파일들의 모음"이다.

1. HEAD 트리 => 마지막 커밋 스냅샷으로, 다음번에 부모가 된다.
2. index 트리 => 다음 번의 커밋 스냅샷으로 제안된 것
3. working directory 트리 => 샌드박스 (여러가지를 테스트해볼 수 있는)

### HEAD
- HEAD <= 현재 브랜치 레퍼런스 <= 이 브랜치상의 마지막 커밋
- 다음 커밋이 만들어지면 HEAD는 그 커밋의 부모 커밋이 됨
- **HEAD = 이 브랜치상의 마지막 커밋의 스냅샷**
- 스냅샷 확인하기
   - `git cat-file -p` => `-p`: pretty print
   - `git ls-tree -r` => `-r`: 서브트리 내로 재귀

### index
- index = 제안된 다음 커밋
- index = staging area => git commit시 깃이 index를 봄
- 깃은 index를 채우는데 뭘로 채우냐면
   - 작업 영역으로 마지막으로 checkout된 파일 컨텐츠들의 리스트
   - 최초로 checkout됐을 때 이 파일들이 어떻게 생겼는지
- 내가 작업함에 따라 이 파일들 중 일부가 새로운 버전으로 바뀌고, git commit을 하면 이 바뀐 파일이 tree 내로 들어가 새로운 커밋이 된다.
- 내 인덱스가 현재 어떻게 생겼는지 보기
   - `git ls-files -s`
   - `-s` => staged된 컨텐츠의 mode bit, object name, stage number를 출력에 표시

### working directory a.k.a. working tree
- HEAD 트리와 index 트리는 자신의 내용물을 .git 폴더 내에 저장하나, working tree는 그 내용물을 실제 파일로 꺼냄
- 작업영역을 샌드박스라고 생각하자. => 커밋하기 전에 변경사항을 시험해볼 수 있음

## 작업흐름
1. 예를 들어 작업영역에서 aoba 파일을 작업하고 `git add aoba`를 했다고 하자.
2. 그러면 aoba 파일은 복사되어 index에 들어간다.
3. 이때 `git commit` 을 하게 되면...
   - index에 들어있는 것이 영구적인 스냅샷으로 저장되고,
   - 이 스냅샷을 가리키는 커밋 객체가 생성되며,
   - master 브랜치가 이 커밋을 가리키게 된다.
   - 이 상태에서 `git status`를 하게 되면 아무 것도 나오지 않는다.
      - 왜냐하면 모든 tree가 똑같기 때문이다.
4. 작업영역에서 aoba 파일을 다시 수정한다.
   - 이 상태에서 `git status`를 하게 되면 파일명이 빨간 글씨로 "Changes not staged for commit" 아래에 나온다.
      - 왜냐하면 작업영역과 인덱스가 다르기 때문이다.
5. 그리고나서 `git add`를 했다고 하자.
   - 이 상태에서 `git status`를 하게 되면 파일명이 초록 글씨로 "Changes to be committed" 아래에 나온다.
      - 왜냐하면 인덱스와 HEAD가 다르기 때문이다.
      - 즉, "제안된 다음 커밋"이 마지막 커밋과 다르기 때문이다.
6. 마지막으로 `git commit`을 한다.
   - 이 상태에서 `git status`를 하게 되면 3과 마찬가지로 아무것도 나오지 않는다.
      - 왜냐하면 모든 tree가 다시 동일해졌기 때문이다.

- 브랜치를 전환하거나 clone하는 것도 위와 비슷한 과정을 거친다.
- branch를 checkout하면,
   - HEAD가 이 branch reference를 가리키게 되고,
   - index가 그 커밋의 snapshot으로 채워지며,
   - 작업영역에 index의 내용이 복사된다.

## reset의 역할
> "Reset current HEAD to the specified state"

- 3개의 tree를 간단하고 예측가능한 방식으로 직접 조작한다.
- `git reset [<mode>] [<commit>]`
   - mode의 기본값은 --mixed
   - commit의 기본값은 HEAD
- 총 3가지의 역할을 하는 명령어이다.
   - (단계 1) `--soft` => HEAD와 HEAD가 가리키고 있는 브랜치를 움직인다. (HEAD만 바꾸는 것은 `checkout`이 하는 일임!)
      - 이 상태에서 `git status`를 하면 index와 HEAD 사이의 차이가 초록색 글씨로 나온다.
      - 즉, `git reset --soft HEAD~`를 하는 것은 본질적으로 마지막 `git commit` 명령어를 undo하는 것임
      - 이 상태에서 인덱스를 갱신하고 `git commit`을 하는 것은 `git commit --amend`를 하는 것과 같은 효과임
   - (단계 2) `--mixed` => index를 HEAD가 가리키고 있는 스냅샷으로 갱신한다.
      - 즉, `git reset [--mixed] HEAD~`를 하는 것은 마지막 커밋을 undo한 뒤 모든 것을 unstage하는 것과 같음
      - 즉, git commit과 git add를 하기 전의 상황으로 돌아온 것임.
   - (단계 3) `--hard` => 작업영역을 index과 같게 만든다.
      - 즉, 마지막 커밋, git commit/add 뿐만이 아니라 작업영역에 있던 작업까지도 undo한 것임
- 따라서 hard reset만이 유일하게 위험하다. 왜냐하면 작업영역의 파일을 강제로 덮어쓰기 때문이다.
   - 만약 커밋을 했다면 reflog에서 찾아볼 수 있겠지만
   - 커밋을 안 했다면 복구할 수 없겠지

## reset에 path를 지정하기
- `git reset [<tree-ish>] [--] <pathspec>...`
   - tree-ish의 기본값은 HEAD임
- reset 명령어에 path를 지정할 수 있음
- path를 명시하면 reset이 작동하는 범위가 특정 파일 혹은 파일의 집합으로 국한됨
- path를 명시하면 단계 1을 건너뛰고 단계 2에서부터 시작함 (왜냐하면 단계 1은 HEAD를 움직이는 것이기 때문)
   - 즉 HEAD를 움직이지 않음
- `git reset aoba` == `git reset HEAD aoba`
   - 즉, index의 aoba 파일이 HEAD의 aoba 파일과 같아졌으니, 이 명령어의 효과는 aoba 파일을 unstage하는 것과 같음.
   - 요컨대 git add의 반대작업
- `git reset <commit> -- aoba`
   - 특정 commit에서 aoba 파일을 꺼내서 인덱스에 놓으란 말
- `-p|--patch` 옵션으로 partial unstage/revert도 가능
   - `git reset (--patch|-p) [<tree-ish>] [--] [<pathspec>...]`
   - `git add -p`의 반대동작

## reset으로 squash하기
- `git rebase -i`로도 squash할 수 있었지만 reset으로도 가능...!
- 그냥 `git reset --soft HEAD~n` 한 다음에 `git commit` 하면 된다.
   - 여기서 HEAD~n은 내가 보존하고 싶은 가장 최근 커밋이다.
   - 이게 작동하는 이유는 --soft가 HEAD를 가리키고 있는 브랜치를 HEAD~2로 움직였으나,
   - 인덱스에는 아직 HEAD(였던 것)이 들어있기 때문이다.

## checkout의 역할
> "Switch branches or restore working tree files"

> "Updates files in the working directory to match the version in the index or the specified tree."

`reset`과 마찬가지로 세 tree를 조작하며, file path를 주느냐 마느냐에 따라 동작이 다소 다르다.

### path를 주지 않았을 때
- `git checkout <branch>`
- 이 경우는, branch처럼 보이기 위해 세 개의 트리를 갱신한다는 점에서 `git reset --hard <branch>`와 유사함
- 그러나 2가지 차이점 존재
   1. checkout은 작업영역을 날리지 않지만 hard reset은 작업영역을 날림. (checkout시 변경되지 않은 파일들은 갱신됨)
   2. reset은 HEAD가 가리키는 브랜치를 이동시키는 반면 checkout은 HEAD 자체를 이동시킴

### path를 주었을 때
- `git checkout [<tree-ish>] [--] <pathspec>...`
- 해당 커밋에 있는 파일로 index를 갱신하고, 작업영역에 있는 파일을 덮어씌운다.
   - 즉, wd-safe 하지 않음
   - `git reset <commit> <file>`은 해당 커밋에 있는 파일로 index만 갱신하였음
- HEAD를 움직이지 않는다.

## 요약!
- `reset`과 `checkout` 모두 세 가지 트리에 영향을 미침
- 그리고 path가 지정됐는지의 여부에 따라 작동방식이 달라짐

### 커밋 수준에서의 행동
- `git reset --soft <commit>`은 head가 가리키는 ref를 움직이고, index와 wd를 변경하지 않는다. 따라서 wd-safe.
- `git reset [--mixed] <commit>`은 head가 가리키는 ref를 움직이고, index를 변경하나 wd는 변경하지 않는다. 따라서 wd-safe.
- `git reset --hard <commit>`은 head가 가리키는 ref를 움직이고, index와 wd를 변경한다. 따라서 wd-safe하지 않다.
- `git checkout <branch|commit>`은 head 자체를 움직이고, index와 wd를 변경한다.
   - 단, wd에 변경사항이 있으면 유지된다. 따라서 wd-safe하다. (매뉴얼 참고)
   - 아마 clean하게 checkout할 수 없으면 checkout에 실패했었던 것으로 기억한다.

### 파일 수준에서의 행동
- `git reset <commit> -- <path>`는 head를 움직이지 않는다. index를 변경하나 wd는 변경하지 않는다. 따라서 wd-safe.
- `git checkout <commit> -- <path>`는 head를 움직이지 않는다. index와 wd를 변경한다. 따라서 wd-safe하지 않다.

## 영어 공부
- demystify[디미스티파이]: 이해하기 쉽게 하다, 분명하게 설명하다
- employ[임플로이]: 쓰다, 이용하다
- metaphor[메터펄]: 은유, 비유
- be more of: ~에 가깝다
- behind the scenes: 막후의
- manifest[매니페스트]: 목록, 명부
- unpack[언팩]: 꺼내다, 풀다
- try something out: 시험삼아 해보다
- populate[파퓰레이트]: 채우다, (빈 곳에) 데이터를 추가하다
- take a second look at sth: ~을 재차 보다
- recap[리캡] => recapitulate[리커피츌레이트]: (이미 한 말의) 개요를 말하다
- newfound[누파운드]: 새로 발견된
- across the board: 전반에 걸쳐
