# 8.1 Customizing Git - Git Configuration

## 구성 파일

- 구성 파일은 plain-text이므로 직접 수정해도 무방
- 이름은 case-insensitive
- 모든 옵션 보기: `man git-config`

### 구성 파일 수준

- `--system`: 시스템 범위(모든 사용자, 모든 저장소), `[path]/etc/gitconfig`
- `--global`: 사용자 범위(모든 저장소), `~/.gitconfig` 또는 `~/.config/git/config`
- `--local`(기본값): 저장소 범위, `.git/config`

### 기본 클라이언트 구성

- `core.editor <editor>`: Git이 사용할 텍스트 편집기를 지정. 기본값은 셸 기본 편집기(`VISUAL`, `EDITOR`, 없으면 `vi`)
- `commit.template <path>`: 커밋할 때 편집기에 보일 초기 메시지. 팀 정책에 맞는 내용을 넣어서 실수를 줄이는데 사용할 수 있음
- `core.pager <pager>`: 여러 줄을 출력할 때 사용할 pager 지정. 빈 문자열은 pager 사용 안 함. 기본값 `less`
- `user.signingkey <key-id>`: 매번 키를 명시하지 않고 태그를 서명할 수 있게 만듦
- `core.excludesfile <path>`: `.gitignore` 패턴이 들어있는 파일 지정. 모든 저장소에 특정 파일을 무시할 때 유용(`.DS_Store`, `*~`, `.*.swp` 등)
- `help.autocorrect`: 잘못 입력한 명령을 교정
  - `0|false|off|no|show`: 명령 제안. 기본값
  - `1|true|on|yes|immediate`: 제안한 명령을 즉시 실행
  - `positive number > 1`: 0.1초 단위로 실행을 지연
  - `never`: 제안하지 않음
  - `prompt`: 제안을 실행할지 물어봄

### 색 입히기

- `color.ui`: 출력에 색을 칠할지 여부
  - `auto`: 터미널에서 바로 실행하면 색 출력, pipe나 redirect는 색 출력 코드 무시. 기본값
  - `always`: 항상 출력. 리다이렉트한 출력에 색상이 필요하면 대신 `--color` 플래그를 명령에 넘기는 것이 나음
  - `false`: 색칠 X
- `color.*`: 특정 명령에 대한 색 설정. `true`, `false`, `always`
  - 하위 세팅에 특정 색 지정도 가능: `git config --global color.diff.meta "blue black bold"`

### 외부 병합, Diff 도구

- `merge.tool`: 도구 등록
- `mergetool.<tool>.cmd`: 병합할 때 실행할 프로그램 지정
- `mergetool.<tool>.trustExitCode`: 프로그램의 종료 코드가 성공적인 병합 해결을 나타내는지 여부
  - 전달하는 환경 변수: `BASE`, `LOCAL`, `REMOTE`, `MERGED`
- `diff.external`: diff할 때 실행할 프로그램 지정
  - 전달하는 인자: `path old-file old-hex old-mode new-file new-hex new-mode`

`git mergetool`로 설정한 병합 충돌 해결 도구를 실행 가능

- `git mergetool --tool-help`로 Git이 지원하는 도구 프리셋 확인

### 형식과 공백

특히 크로스플랫폼 협업에 문제를 일으킴

- `core.autocrlf`
  - `true`: index에 추가하거나 파일 시스템에 가져올 때 변환
  - `input`: 커밋할 때만 CRLF를 LF로 변환
  - `false`: 변환하지 않음. 유일하게 CR이 저장소에 기록되게 만듦
- `core.whitespace`: 공백 문제를 감지하고 고치는 프리셋. `git diff`를 실행할 때 검사
  - `blank-at-eol`(기본값): 줄 끝에 공백이 있는지 봄
  - `blank-at-eof`(기본값): 파일 끝에 공백이 있는지 알림
  - `space-before-tab`(기본값): 줄 시작에 탭 이전에 공백이 있는지 봄
  - `indent-with-non-tab`: 탭이 아닌 공백으로 줄이 시작하는지 봄(`tabwidth` 옵션으로 제어됨)
  - `tab-in-indent`: 줄의 들여쓰기 부분에서 탭을 찾음
  - `cr-at-eol`: 줄 끝에 CR이 있는 것은 괜찮은 것으로 간주
  - 콤마로 구분, `-`를 앞에 붙여서 비활성화, 아예 제외해서 기본값 사용: 'trailing-space,-space-before-tab' (`trailing-space` = `blank-at-eol` + `blank-at-eof`)
  - `git apply`, `git rebase`에 `--whitespace=<warn|fix>` 옵션 전달 가능

### 서버 설정

- `receive.fsckObjects`: 푸시 중 수신된 모든 객체가 SHA-1 체크섬과 일치하고 유효한 객체를 가리키는지 확인. 비싼 작업이므로 기본적으로 비활성화
- `receive.denyNonFastForwards`: 강제 푸시 거부. 대신 receive 훅을 이용하면 더 세세하게 제어 가능
- `receive.denyDeletes`: 모든 브랜치, 태그의 삭제 거부. 서버에 접속해서 참조 파일을 수동으로 제거해야함. 대신 서버 측 훅으로 더 세세하게 제어 가능
