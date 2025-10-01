# 7.3 스태시와 클린

## 학습목표
- git stash가 무엇이고 언제 사용하는 것인지 이해한다.
- git clean이 무엇이고 언제 사용하는 것인지 이해한다.

## git stash
- 아직 마무리되지 않은 작업을 저장해둘 필요가 있을 때 유용하다.
- modified이고 tracked인 파일들과 stage된 변경사항들이 스택에 저장됨
- 원하는 시점에 원하는 곳에 reapply할 수 있음
- git stash save는 deprecated이며 git stash push로 이주할 것
- stash를 apply할 때 working directory가 clean하지 않아도 되고 stash를 저장한 브랜치와 다른 브랜치여도 된다.
- 만약 성공적으로 apply되지 않으면 merge conflict가 발생한다.
- apply시 기본적으로는 stage되었던 파일을 restage하지는 않음

```bash
# 작업하던 사항들(working directory와 staging area)을 스택에 저장
git stash [push]
git stash --patch    # 어떤 부분만 stash에 포함시킬 것이고 어떤 부분은 working directory에 남겨둘 것인지 대화식으로 prompt됨
git stash --keep-index  # stage된 파일들을 stash에 포함시키는 한편, staging area에 계속 유지시키기
git stash --include-untracked | -u  # untracked 파일도 stash에 포함시키기
git stash --all | -a    # ignored 파일도 stash에 포함시키기

# 저장해둔 내역 보기
git stash list

# 적용하기 (apply했다고 해서 스택에서 사라지는 것은 아님)
# 기본적으로는 staged 상태까지 복원되는 것은 아님
git stash apply   # 가장 최근 내역 적용하기 (0번째)
git stash apply stash@{n}     # n번째 기록 적용하기 / 매뉴얼 보니까 그냥 n이라고만 적어도 되는듯
git stash apply --index    # staged 상태까지 복원

# 내역 삭제
git stash drop stash@{n}

# 적용과 동시에 삭제
git stash pop

# 스태시로부터 브랜치 만들기
# 스태시를 만든 후 그 스태시를 만든 브랜치에서 계속 작업했을 경우 해당 스태시를 적용할 때 문제가 발생할 수 있음
# 새로운 브랜치를 만들고, 이 스태시를 만들 때 위치했던 커밋을 checkout한 뒤,
# 그곳에 해당 스태시를 reapply하고, 스태시가 성공적으로 적용되었으면 해당 스태시를 drop
git stash branch <branch-name>
```

## git clean
- working directory를 정리하고 싶을 때 사용
- tracked 되지 않은 파일을 작업영역에서 지우도록 설계된 명령어이므로 사용시 주의!!
- 좀 더 안전한 선택지는 `git stash --all`
- `git rm`과의 차이점은 clean은 작업영역에서 untracked인 파일을 지우는 것이고 rm은 작업영역과 스테이지영역에서 파일을 지우는 것임. (파일명 변경도 되는듯)
- 작업영역안에 또 다른 깃 레포지토리가 들어있으면 -fd이더라도 지울 수 없음. 이럴 경우 -f를 한번 더 적어줘야 함.

```bash
# 작업영역에서 모든 untracked 파일과 삭제의 결과로 비게 되는 subdirectory도 제거
git clean -fd  # -f: force / clean.requireForce가 false로 설정되어 있지 않으면 필요
               # -d: -- path가 제공되지 않거나 -d가 없으면 subdirectory 내로 recurse되지 않음. path가 제공될 경우 -d는 무관함

# dry run
git clean -nd  # -n = --dry-run

# ignored되는 파일도 제거
git clean -ndx

# 인터랙티브 모드
# 각각의 파일을 직접 처리하거나 패턴 지정
git clean -idx
```

## 영어 공부
- wherein = in which / in what place or respect?
- stash: (informal) 안전한 곳에 챙겨두다; 챙겨둔 것
- revert: 원래 상태로 되돌아가다 (to)
- cruft: (computing, informal) 불필요한 것
- quirky: 기이한
- recurse: 재귀하다 라는 뜻인듯