# 3장 브랜치 요약

## 개념

- Git은 스냅샷의 연속으로 데이터를 저장. delta 아님.
- Git의 4가지 객체
  - blob: Binary Large Object. 파일 내용을 담는 바이너리. 해시로 식별됨.
  - tree: 디렉토리 구조를 나타냄. 여러 엔트리를 가짐
    - entry: 파일 권한, 객체 유형(blob, tree), 해시, 이름
  - commit: 저장소의 특정 시점(snapshot)
    - tree 포인터 (최상위만)
    - 메타데이터 (author, committer, email, ...)
    - 커밋 메시지
    - 부모 커밋 포인터(0개 이상)
  - tag: 태그
- branch: commit을 가리키는 포인터
- HEAD: 현재 브랜치를 가리키는 포인터
- merge: 두 개 이상의 브랜치의 내용을 하나로 합치는 것
  - fast forward: 공통 조상이 합치려는 브랜치와 같은 경우. 포인터를 단순히 앞으로 이동
  - 3-way merge: 공통 조상, 각 브랜치 끝점을 이용해 병합. 새 병합 커밋을 만듦.
- conflict: 같은 파일의 같은 부분을 서로 수정하여 자동으로 병합할 수 없을 때 발생
- standard conflict resolution marker: `<<<<<<<`, `=======`, `>>>>>>>` 이거
- 브랜칭 전략
  - 요약: main <- develop <- topic
  - long running branch: 안정성 수준을 나타내는 평행 브랜치. 일정한 수준에 도달하면 상위 브랜치로 병합함.
  - topic branch: 하나의 기능 구현
- 원격 브랜치
  - local branch: 로컬에 있는 브랜치
    - remote-tracking branch: 원격 브랜치의 위치를 나타내는 로컬 브랜치. 직접 수정 X
    - tracking branch: 원격 브랜치와 연결된 로컬 브랜치. 직접 수정 O
    - upstream branch: tracking branch에 대응하는 remote-tracking branch
  - remote branch: 원격 레포에 있는 브랜치
- rebase
  - 이미 push 한 건 rebase하지 않기
  - `git rebase [--onto target] <base> [topic]`
  - rebase = base를 기준으로 topic을 분리해서 target에 올림
  - target의 기본값은 base
  - topic의 기본값은 현재 브랜치

## 명령어

```bash
$ git branch              # 브랜치 목록
$ git branch -v           # 브랜치 목록 자세히
$ git branch -vv          # 브랜치 목록 자세히 + tracking branch
$ git branch --merged     # 현재 브랜치에 병합된 브랜치만
$ git branch --no-merged  # 현재 브랜치에 병합이 안 된 브랜치만
$ git branch --merge main # 기준 브랜치 명시

$ git branch testing      # 브랜치 생성
$ git branch -d testing   # 브랜치 삭제

$ git branch --move a b   # 브랜치 이름 변경
# 원격 브랜치에 이름 반영
$ git push -u b # 원격 브랜치 추가
$ git push origin --delete a       # 원격 브랜치 삭제

$ git switch -c testing   # 만들고 이동
$ git switch testing      # 이동
$ git switch -            # 이전 checkout 한 브랜치로 이동

$ git merge testing       # testing을 현재 브랜치에 병합

$ git clone <url>         # 복제
$ git fetch               # 로컬에 없는 모든 정보를 가져옴. remote-tracking branch 이동.
$ git pull                # fetch + merge

# push. 아래 3개는 모두 같음
$ git push origin remote
$ git push origin local:remote
$ git push origin refs/heads/local:refs/heads/remote

# rebase
$ git rebase base
$ git rebase base topic
$ git rebase --onto target base
$ git rebase --onto target base topic

$ git gc                  # garbage collection 돌림
```
