# A3.3 스냅샷 취하기

## 학습목표
- 다음의 명령어들을 복습한다.
```bash
git add
git status
git diff
git difftool
git commit
git reset
git rm
git mv
git clean
```

## 요약
- git add
   - 다음 커밋에 들어갈 거 인덱스에 넣기
- git status
   - 파일들의 상태 보기
- git diff
   - 임의의 두 tree 간 차이점 보기
   - 이 자체로는 작업영역과 인덱스간의 차이
   - `--staged` 옵션을 주면 인덱스와 지난 커밋(HEAD)와의 차이
   - 두개의 커밋을 인자로 주면 해당 커밋간의 차이
   - git diff의 맥락에서 `main...topic`의 뜻 = `git diff $(git merge-base topic main)` = main엔 없는데 topic엔 있는거
   - `-b` == `--ignore-space-change`
   - `--ours` `--theirs` `--base` => 충돌 해결전에 차이 확인
   - `--submodule` => 서브모듈 차이 확인
- git difftool
   - 두 트리간 차이 확인을 위해 외부 툴 실행하기
- git commit
   - 스테이지된 파일들을 취해 새로운 스냅샷 만들기
   - `--amend`
- git reset
   - HEAD 및 HEAD가 가리키는 레퍼런스 같이 이동시키기
   - 어떤 옵션을 주느냐에 따라 인덱스랑 작업영역에 영향을 줄수도 있음
- git rm
   - 작업영역과 인덱스에서 파일 삭제하기
   - `--cached` 옵션으로 인덱스에서만 지우기
- git mv
   - 파일 이동시키기
- git clean
   - 작업영역에서 파일 지우기
