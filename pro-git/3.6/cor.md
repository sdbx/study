# 3.6 리베이스

## 학습목표
- `rebase` 의 기본적인 동작 이해하기
- `rebase` 직접 사용해보기
- `rebase` 를 언제 하면 안되는지 숙지하기

## rebase란?
한 브랜치에 있는 변경사항을 다른 브랜치로 통합하는 주된 방법 중에 하나. (다른 하나는 merge.)
### 사용법
```bash
git rebase [--onto <newbase>] [<upstream> [<branch>]]
# 한마디로, branch에는 있는데 upstream에는 없는 커밋(들)을 upstream 혹은 newbase 뒤에 붙여달라는 뜻이다.
# (branch가 upstream으로부터 분기된 이후로의 변경사항들)

# onto 옵션을 주게 되면 커밋을 옮길 위치가 newbase가 된다.
# onto 옵션이 없으면 커밋을 옮길 위치는 upstream이 된다.

# branch를 적어주면 rebase가 일어나기 전에 해당 브랜치로 switch된다.
# branch를 적어주지 않으면 현재 위치한 브랜치가 사용된다.

# rebase가 일어나면, 현재 위치한 브랜치에는 있는데 upstream에는 없는 변경사항들이 임시 영역에 저장된다.
# 다음으로, 현재 위치한 브랜치가 upstream으로 (혹은 onto 옵션이 있으면 newbase로) reset된다.
# 임시 영역에 저장된 커밋들이 현재 브랜치에 순서대로 하나씩 재적용[replay, reapply]된다.
```

1. 내가 현재 위치한 브랜치와 rebase한 결과를 붙일 브랜치로 간다.
2. 내가 현재 위치한 브랜치의 각 커밋에 의해 도입된 변경사항을 얻는다.
3. 해당 변경사항을 임시 파일에 저장한다.
4. 내가 현재 위치한 브랜치를 rebase한 결과를 붙일 브랜치와 같은 커밋으로 reset한다.
5. 각각의 변화를 차례로 적용한다.

### merge와의 차이점
최종적인 결과는 같으나, rebase를 하면 깨끗한 커밋 이력을 가지게 됨.

## 사용시 주의사항
서버에 이미 존재하는 커밋들을 리베이스하거나, 사람들이 이미 작업에 사용한 커밋들을 리베이스하면 안된다.

만약 이런 일이 이미 벌어져서 커밋 이력이 복잡해졌다면, 한가지 방법이 있다.
일반적인 pull을 하는 대신,
- `git fetch` 이후 `git rebase <force-pushed-rebase-branch>`
- `git pull --rebase`
하면 된다. 이러면 중복된 커밋들을 제외된 채, 내가 만든 커밋이 포스푸쉬된 커밋 뒤에 붙게 된다.
(깃은 커밋의 SHA-1 체크섬 외에도, patch에 기반한 체크섬도 계산한다고 하며 이를 patch-id라고 하는 모양이다.)

git pull시 기본적으로 rebase로 동작하게 하려면 `git config --global pull.rebase true` 로 설정한다.

## 리베이스가 나을까 머지가 나을까
필요한 상황에 맞춰 하면 된다. 커밋 이력을 "실제로 일어난 일들의 이력"으로 볼 수도 있고, "이 프로젝트가 어떻게 만들어졌는지에 대한 이야기"라고 볼 수도 있다. 전자의 경우 머지커밋이 남아서 이력이 지저분해 보이더라고 그것이 실제로 일어난 일이기 때문에 보존할 것이며, 후자의 경우 이야기의 초안을 보여줄 필요는 없으므로 커밋 이력을 편집하게 될 것이다.

두 관점을 모두 취할 수 있다. push하기 전에 로컬에 있는 변경사항을 rebase하여 작업을 정돈하되, 이미 push된 것은 rebase하지 마라.

## 영어 공부
- make for: to go in the direction of a place or thing.
- base off (of): base on/upon 이랑 같은? 뜻인듯함
- in a pickle: 곤경에 처한
- be in for: 불쾌한 일을 당할 상황이다. have good reason to expect (typically sth unpleasant).
- in one's own right: 자신의 정당한 자격으로.
- tamper: 함부로 변경하다 (with)
- blasphemous: 신성모독적인
- transpire: 발생하다
- posterity[파스테러티]: 후대
- misstep: 실수
- dead-end: 막다른 길/상황
- coherent: 일관성있는
- get the best of: overcome. 패배시키다, 정복하다, 극복하다