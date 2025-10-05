# 7.8 Git Tools - Advanced Merging

## 고급 병합

- 병합을 수행하기 전에 작업 디랙토리를 깨끗하게 만들어야함 -> 취소가 가능해짐

### 병합 도중 취소

- `git merge --abort`: 병합 취소. 병합 수행 전 작업 디렉토리가 깔끔하지 않은 경우를 제외하고 항상 작동
- `git reset --hard`: 저장소를 마지막 커밋 상태로 돌리고 처음부터 다시 시작 (위험)

### 병합 충돌 상태에서의 파일의 세 가지 버전

- base: stage #1, 공통 조상 버전 파일
- ours: stage #2, 현재 브랜치 버전 파일
- theirs: stage #3, 병합하려는 브랜치 파일. `MERGE_HEAD`에서 가져옴

#### 파일 버전 다루기

- `git show :<1|2|3>:파일이름`: 충돌 파일의 각 버전 복사본 추출
- `git ls-files`: 인덱스와 작업 트리에 있는 파일 정보 출력
  - `-u|--unmerged`: 다른 추적 파일 없이 unmerged 파일 정보만 출력
- `git diff`: 변경사항 비교
  - `-1|--base`: stage #1과 작업 트리를 비교
  - `-2|--ours`: stage #2와 작업 트리를 비교
  - `-3|--theirs`: stage #3과 작업 트리를 비교

### 수동 병합

세 가지 버전 추출 후 `git merge-file`로 수동 병합

- `git merge-file <current> <base> <other>`: 파일을 3-way merge
  - `-p|--stdout`: current를 덮어쓰는 대신 표준 출력으로 내보냄

```bash
$ git show :1:hello.rb > hello.common.rb
$ git show :2:hello.rb > hello.ours.rb
$ git show :3:hello.rb > hello.theirs.rb

$ vim hello.theirs.rb # hello.theirs.rb 수정

$ git merge-file -p hello.ours.rb hello.common.rb hello.theirs.rb > hello.rb
```

### 충돌 맥락 검토

- `git checkout <file>`: 작업 트리 파일을 복구 (=`git-restore`)
  - `--conflict=<style>`: 기본 충돌 마커 생성. 사람이 검토하는 영역을 만듦
    - `merge`: 충돌이 발생한 두 버전의 내용 표시
    - `diff3`: 공통 조상의 내용을 함께 표시 (`||||||| base`)
    - `zdiff3`: Git 2.35에 추가된 `diff3` 개선 버전. 충돌 영역 시작과 끝의 일치하는 줄을 충돌 밖으로 이동시켜서 충돌 영역을 더 작게 만듦
    - `--ours`, `--theirs`: 전혀 병합하지 않고 어느 한쪽을 선택하는 방법. 바이너리 충돌이나 특정 파일만 병합하는 경우 유용.
- `git log --left-right HEAD...MERGE_HEAD`
  - `--merge`: 현재 충돌 중인 파일을 건드린 병합 양쪽의 커밋만 표시

### Combined Diff 포맷

```diff
  def hello
++<<<<<<< HEAD
 +   puts 'hola world'
++=======
+    puts 'hello mundo'
++>>>>>>> MERGE_HEAD
  end

  hello()
```

- 각 줄 옆에 두 개의 정보 열 제공
- 첫 번째 열: ours와 작업 디렉토리 간 차이
- 두 번째 열: theirs와 작업 디렉토리 간 차이

- combinded diff format을 사용하는 경우:
  - 병합 충돌 상태에서 `git diff` 실행
  - 병합 커밋에 대해 `git diff`
  - 병합 커밋에 대해 `git show`
  - `git log -p --cc` 중 병합 커밋

### 병합 되돌리기

#### 참조 수정

- 병합 커밋이 로컬에만 존재하고, 병합 커밋 이후 새 커밋을 만들지 않은 경우
- `git reset --hard HEAD~`

#### 커밋 되돌리기

- `git revert -m 1 HEAD`: 모든 변경 사항을 취소하는 새 커밋을 만듦
  - `-m 1`: mainline인 부모 커밋 선택. 1은 HEAD였던 커밋, 2는 병합되는 브랜치의 끝. 1을 유지하면서 2를 병합하면서 생긴 모든 변경 사항을 취소.
- 단, 이 상태에서 topic 브랜치를 병합하려고 하면 up-to-date라고 뜸. topic에 작업을 추가하고 다시 병합하면 병합 이후의 변경 사항만 가져옴. 따라서 병합을 다시 하기 전에 `revert`를 한 번 더 해야함.

### 다른 병합

#### 공백 무시

- recursive, ort 모드에서 동작
- `git merge`에 `-Xignore-all-space`: 줄을 비교할 때 공백을 완전히 무시
- `git merge`에 `-Xignore-space-change`: 하나 이상의 공백 문자 시퀀스를 동등한 것으로 취급

#### 어느 한 쪽을 선호하도록 지시

- `git merge`에 `-Xours` 또는 `-Xtheirs`
  - recursive, ort 모드에서 동작
  - 병합 가능한 차이는 병합됨. 충돌이 발생하면 지정한 쪽을 사용.
  - 바이너리 파일을 처리할 때 유용
  - `git merge-file`에 `--ours`, `--theirs`로도 가능
- "ours" 병합 전략
  - 가짜 병합 수행. 병합하는 브랜치 아예 안 봄
  - 결과로 현재 브랜치의 코드를 단순히 기록
  - 브랜치가 이미 병합되었다고 Git을 속이는 데 유용

#### subtree 병합

- 두 프로젝트를 다른 브랜치에서 관리하고, 어느 한쪽 브랜치를 다른 브랜치의 하위 디렉토리로 지속적으로 병합하는 워크플로우에서 사용.

---

- `git diff`의 `-b`: 공백 변경 무시
- `git status -s`의 `-b`: `--short`여도 브랜치를 표시 (`## main`)
