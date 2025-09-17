# 3.2 브랜치 사용 및 병합

## 학습목표
- 브랜치를 사용하는 방법에 대해 알기
- 브랜치 작업에 관련된 기본적인 명령어들에 익숙해지기
- 두 브랜치를 병합하는 방법 이해하기
- 기본적인 병합 충돌 해결하기

## (복습) 브랜치 생성 및 전환
이것은 3장 1절에서 배웠던 내용이지만 중요하기 때문에 다시 짚고 넘어가자.
```bash
# 브랜치 생성과 동시에 해당 브랜치로 이동하기
git checkout -b <br_name>  # legacy
git switch -c <br_name>    # -c = --create
```

## 브랜치 병합
두 브랜치를 병합하려면, 병합을 받고자 하는 브랜치로 이동한 후, `git merge` 명령어에 병합하려는 브랜치명을 인자로 전달한다.
```bash
git switch <merge_into>
git merge <merge_in>
```
한편, 병합을 할 때 아래와 같은 상황이 있을 수 있다.
### fast-forward
예를 들어 아래와 같은 상황을 보자.
```bash
* ddddddd (hotfix)
* ccccccc (HEAD -> main)
```
이 때 `main` 브랜치에서 `git merge hotfix` 를 하게 되면,
```bash
$ git merge hotfix
Updating ccccccc..ddddddd
Fast-forward

$ git log --oneline --graph
* ddddddd (HEAD -> main, hotfix)
* ccccccc
```
단순히 `main` 브랜치가 앞으로 이동한 것을 볼 수 있다. 왜냐하면 커밋 `ddddddd` 의 바로 앞에 커밋 `ccccccc` 가 있기 때문이다. 요컨대, 분기된 브랜치가 없기 때문이라는 것이다. 이렇게 병합된 것을 두고 **fast-forward**라고 일컫는다. (빨리감기라는 뜻인 듯함.)

### ort (recursive)
다음과 같은 히스토리를 생각해보자.
```bash
* a30b57a (fix2)
* ddd37d9
| * 9194714 (HEAD -> main)
|/
* 0f84d82 # common ancestor
```
현재 `main` 에 있고, `fix2` 를 병합하고 싶다고 하자. 그런데, `main` 에 있는 커밋 `9194714` 는 `fix2` 에 있는 커밋 `a30b57a` 의 **직접적인 조상이 아니기 때문**에, 이럴 경우에 `git merge fix2` 를 하게 되면 git은 **three-way merge**라는 것을 하는데, 이때 두 브랜치의 공통 조상인 `0f84d82`과 각 브랜치의 끝에 있는 `9194714` 와 `a30b57a` 이 사용된다고 한다.
```bash
$ git merge fix2
Merge made by the 'ort' strategy.

$ git log --oneline --graph
*   c856b3b (HEAD -> main) Merge branch 'fix2' into main
|\
| * a30b57a (fix2)
| * ddd37d9
* | 9194714
|/
* 0f84d82 # common ancestor
```
이렇게 병합이 이루어지면, git은 이 three-way merge의 결과로 만들어진 새로운 스냅샷을 생성하고, 또 이 스냅샷을 가리키는 커밋을 생성한다. 이 커밋을 두고서 "merge commit"이라고 하며, 둘 이상의 부모 커밋이 있다는 특징이 있다. 또한, `main` 브랜치가 앞으로 이동해 해당 merge commit을 가리키게 된다.

참고로 ort는 ostensibly recursive's twin의 약자로, 원래 git의 기본 병합 알고리즘은 recursive였는데 바뀐 것으로 보인다.

## 병합 간 충돌 해결
병합하고자 하는 두 커밋이 같은 파일의 같은 내용을 변경했다면 충돌[conflict]이 일어나게 된다. 이럴 경우, `git status` 를 입력해보면 어떤 파일에 충돌이 일어났는지 확인할 수 있다.

충돌이 난 파일을 열어보면 `<<<<<<<`, `=======`, `>>>>>>>` 과 같은 줄이 보이는데, 해당 줄 사이로 충돌이 난 내용이 보이게 된다. 적절히 고친 후 위 줄들 역시 지워주면 된다. 이후 `git add <filename>` 하게 되면 충돌을 해결했음을 나타낼 수 있다. (한편, 위의 줄들을 일컫어 standard conflict-resolution markers 라고 하는 것 같다.)

모든 충돌을 해결했다면 `git commit` 을 통해 병합 작업을 완료할 수 있다.

한편, GUI 툴을 활용해 충돌작업을 처리할 수 있는데 그러려면 `git mergetool` 을 입력하면 된다고 한다.