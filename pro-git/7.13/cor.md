# 7.13 리플레이스

## 학습목표
- `git replace`가 무엇인지 이해한다.
- replace를 어떤 상황에서 사용할 수 있는지 이해한다.

## 개요
- 깃의 object database에 있는 object는 변경불가
- 그러나, 한 object를 다른 object로 **대체한 것처럼 보이게 하는** 방법이 있음
- 그것이 바로 `replace` 명령어임
- 전체 이력을 rebuild하는 대신 한 커밋을 다른 커밋으로 대체하는데 유용함 (sha-1이 바뀌지 않음)
- 명령어들(bisect, blame 등)도 정상적으로 작동함
- 커밋 p를 커밋 q로 대체한 경우, sha-1은 p의 것을 사용하나 그 내용은 q의 것을 따름.
- 대체한 기록이 남음 => 대체한 이력을 다른 사람과 공유 가능
   - `for-each-ref`로 확인 가능

## 예시상황: 이력 쪼개기
- `commit-tree`
   - 저수준 명령어로, 하나의 tree를 취해 새롭게 만들어진 parentless 커밋 객체의 sha-1을 반환
   - 커밋 메시지를 stdin으로 받음

### 이력 쪼개기
```bash
# 아래와 같은 커밋 이력 가정하고,
# 커밋 이력을 a~d와 d~e로 쪼개기로 하자.
# 한쪽에 있는 커밋을 다른쪽에 있는 동등한 커밋으로 replace하기 위해 d가 겹치는 커밋이 됨
a > b > c > d > e (main)

# a~d를 가지는 커밋 이력 만들기
# 먼저 d에 브랜치를 만들고, d를 history-project에 push
$ git branch old-history d
$ git push history-project old-history:main

# d~e를 가지는 커밋 이력 만들기
# a~d 이력을 얻을 수 있는 방법을 적어둔 base 커밋 생성하기 위해 c커밋의 트리 사용
# 이후 d~e를 base 위로 rebase (현재 main 브랜치 위에 있음)
# rebase된 이력인 base > d' > e' (main) 커밋을 work-project에 push
$ echo 'you can get the whole history by doing the following...' | git commit-tree c^{tree}
$ git rebase --onto base c
$ git push work-project main:main
```

### 이력 합치기
```bash
# 먼저 두 이력을 다 가져와야 함
$ git clone <url-to-work-project>
$ git fetch <url-to-history-project>

# 커밋 치환
$ git replace d' d
```
