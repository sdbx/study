# 6.2 GitHub - Contributing to a Project

fork: 프로젝트의 사본을 만드는 것. 내가 완전히 소유하고, 공개적으로 원본 프로젝트에 기여할 때 사용함.

GitHub Flow: (1) fork, (2) clone, (3) 작업, 커밋 (4) push (5) PR 열기 (6) 의견 나누기, 선택적으로 커밋 & push (7) 소유자가 PR을 병합하거나 닫음 (8) 최신 main 상태로 동기화

PR

- 설명, ahead 커밋 목록, unified diff, 병합 가능 여부 등이 나타남
- general comment, code comment를 남기거나 코드 리뷰를 할 수 있음
- 같은 브랜치에 commit & push 하면 PR이 자동으로 갱신됨(알림발생 X, 수동 comment 권장)
- merge 버튼은 항상 non-fast-forward merge를 시도
- 로컬에서 병합해도 PR 자동으로 닫힘
- 일찍 열어서 더 일찍 의견을 주고받을 수 있음(tasklist 활용 등)
- fork일 필요는 없음. 같은 레포의 다른 브랜치여도 PR 생성 가능
- 추가 수정은 merge 권장. rebase는 문제를 일으키고 새 PR을 만들게됨

GFM

- [치트시트](https://docs.github.com/ko/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)
- 참조
  - PR이나 이슈: `#<num>`, `forked_username#<num>`, `namespace/repo#<num>`, GitHub Link
  - 커밋: `<hash>`, `forked_username@<hash>`, `namespace/repo@<hash>`, GitHub Link
- Task lists

  ```markdown
  - [x] done
  - [ ] yet
  ```

  - 체크박스 클릭으로 업데이트 가능
  - 이슈나 PR에 있으면 작업 진행도를 보여줌

- Code snippets

  ````markdown
  ```js
  for (let i = 0; i < 5; ++i) {
    console.log(`i is : ${i}`);
  }
  ```
  ````

  - 언어 이름을 넣으면 문법 하이라이팅해줌

- Quoting
  - `> 인용문`
  - comment에서 인용할 문장을 선택하고 r 단축키를 누르면 자동으로 생성
- Emoji
  - `:<name>:`
  - emoji helper
- Image
  - 기술적으로 GFM은 아님
  - 드래그앤드랍을 하면 자동으로 업로드하고, 임베드 URL을 삽입함

forked 레포 최신화

- 설정 없이
  ```bash
  $ git switch main
  $ git pull <upstream URL>
  $ git push origin main
  ```
- 설정

  ```bash
  $ git remote add <upstream name> <upstream URL>
  $ git fetch <upstream name>
  $ git branch -u <upstream name>/main main
  $ git config --local remote.pushDefault origin
  ```

  이후 아래와 같이 사용

  ```bash
  $ git switch main
  $ git pull
  $ git push
  ```

  단, main은 사실상 upstream repository에 속하므로 main에 직접 커밋하지 않도록 주의
