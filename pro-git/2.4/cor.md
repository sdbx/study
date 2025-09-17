# 2.4 작업 되돌리기

## 학습목표
- `git commit --amend`
- `git restore --staged filename...`
- `git restore filename...`

## 메모
어느 단계에서나 작업을 되돌릴[undo] 수 있음.

그러나 어떤 undo의 경우 **잘못하면 작업한 걸 잃어버리게 될 수도 있으므로 주의가 필요**함.

**`git commit --amend`** 를 하면 이전 커밋을 “수정”할 수 있음. **어떤 커밋을 하고 난 뒤 새롭게 파일을 `git add` 한 뒤 `--amend` 를 하면 그 파일이 포함된 커밋으로 수정됨.** 그냥 커밋메시지만 바꾸는 용도만 있는게 아님.

**오직 로컬에 있고 아직 어딘가에 push되지 않은 커밋만을 amend하라.** 이미 푸쉬된 커밋을 amend하고 force push하면 **협업하는 사람과 문제**가 발생할 수 있다. (해결법은 있는 듯함)

### stage된 파일을 unstage하는 방법

`git reset HEAD filename...`

`git restore --staged filename...`

Note: **`git reset` 은 `--hard` 옵션과 같이 쓸 경우 매우 위험**함!

### modified된 파일을 unmodify하는 방법

`git checkout -- filename...` 

`git restore filename...`

Note: `git checkout -- filename...` 이나 `git restore filename...` 을 하게 되면, git은 해당 파일을 **마지막으로 staged된 버전이나 커밋된 버전으로 대체**해버리기 때문에, 로컬에 있는 변경사항이 날아가 버려서 **아주 위험한 명령**임!

Note: 변경사항을 유지하고 싶은데 잠깐 벗어나야 할 경우 ⇒ 일반적으로 stash나 branch하는게 나음.

**★★★ 깃에서 한 번 커밋된 것은 무엇이든지 거의 항상 복구될 수 있다. ★★★** 심지어 삭제된 브랜치에 있는 커밋이나 amend에 의해 덮어씌워진 커밋일지라도 그렇다.

그러나, 커밋되지 않은 **잃어버린 것은 다시 보기 어려울** 가능성이 크다.

Note: `git restore` 는 깃 버전 2.23.0에 새롭게 추가된 명령어임.

---

### 몰랐던 영어표현

**effectively** ⇒ 실제적으로, 사실상

**clutter** ⇒ (어수선하게) 채우다

**be on the receiving end** ⇒ 불쾌한 것을 당하는 입장이 되다

⇒ She found herself on the receiving end of a good deal of teasing.

**invocation** ⇒ (마법) 주문