# 8.1 깃 환경설정하기

## 학습목표
- 깃을 내가 원하는 환경으로 설정하는 방법들에 대해 알아본다.

## 개요
- 깃 환경설정하는 방법과 `.gitconfig`에 대해서는 [1장 6절](../1.6/cor.md)에서 기 다룬 바 있음
- 환경설정할 수 있는 옵션들은 2가지 범주로 분류됨: 클라이언트 측과 서버 측
- **대부분의 옵션들은 클라이언트 측 환경설정**이나 대부분의 옵션들은 특정한 edge case에 대해서만 유용함

## 목록
### 기본적이고 유용한 클라이언트측 설정
- `core.editor`: 사용할 텍스트 에디터 설정하기
   - 기본적으로 쉘 환경변수 `VISUAL` 혹은 `EDITOR`를 사용하나 없을 시 `vi` 에디터를 사용함
   - core.editor를 설정하면 이 에디터가 사용됨
- `commit.template`: 커밋 시 사용할 기본 메시지 설정하기
   - 이 옵션의 값을 특정 파일의 경로로 지정해 놓으면 해당 파일의 내용이 커밋 시 텍스터 에디터에 나오게 됨
- `core.pager`: 깃이 출력을 page할때 어떤 pager를 사용할지 지정하기
   - 기본값은 `less`이나 `more` 혹은 원하는 pager를 지정 가능
   - 공백문자열을 지정하면 pager를 사용하지 않음
- `user.signingkey`: 태그와 커밋에 사용할 GPG 키를 지정하기
- `core.excludesfile`: .gitignore 역할을 하는 파일 지정하기
- `help.autocorrect`: 잘못 입력한 명령어 자동으로 수정해서 0.n초 뒤에 실행하기
   - 예를 들어 이 옵션에 1이라는 값을 지정하면 0.1초 뒤에 실행됨

### 색깔 관련 옵션
- `color.ui`: 프로그램의 출력에 색칠할지의 여부 지정하기
   - 기본값은 `auto`로, 터미널에 출력할때는 색칠하지만 **출력이 파이프나 파일로 리다이렉트될 때는 색칠하지 않음**
   - `false`로 지정시 색칠을 아예 하지 않음
   - `always`로 지정시 항상 색칠하나 일반적으로 원하는 동작은 아닐 것임. 색칠을 강제하려면 명령어에 `--color` 플래그를 지정할 수 있음
- `color.*`: 명령어별로 색칠 여부 지정하기
   - `true`, `false`, `always` 지정 가능
   - 한발 더 나아가서, 출력의 특정 부분에 무슨 색을 칠할지도 지정 가능
      - 색깔 (총 9종): normal, black, red, green, yellow, blue, magenta, cyan, white
      - 속성 (총 5종): bold, dim, ul, blink, reverse
   - (예시) `git config --global color.diff.meta "blue black bold"`

### 외부 merge/diff 도구 설정
- 깃에서 제공하는 프리셋을 `git mergetool`로 설정할수도 있음
- 혹은 원하는 외부 프로그램을 호출하는 wrapper script를 구성한 뒤 관련된 config 옵션들을 설정해서 사용할수도 있음

### 포매팅 및 공백 관련 설정
특히 cross-platform 협업 시, 포매팅 및 공백 관련 이슈가 발생할 수 있으며 이는 매우 성가심

- `core.autocrlf`: crlf를 lf로 변환하기
   - Windows에서는 줄바꿈할때 carriage-return(\r)과 linefeed(\n)을 사용
   - macOS와 Linux에서는 \n만 사용
   - 이 옵션을 `true`로 설정하면 파일을 index에 추가할 때 crlf를 lf로 바꾸고, 파일을 checkout할 때 lf를 crlf로 바꿈 (윈도우 유저 권장 설정)
   - 이 옵션을 `input`으로 설정하면 커밋에 있는 crlf를 lf로 고침 (맥, 리눅스 유저 권장 설정)
   - 윈도우 환경에서만 개발되는 프로젝트를 하고 있다면, 이 옵션을 `false`로 설정함으로써 캐리지리턴을 유지할 수 있음
- `core.whitespace`: whitespace 문제 감지하기
   - 6개의 상황을 감지하나 3개는 기본적으로 적용되어있고 나머지 3개는 꺼져있음
      - (on) blank-at-eol: 줄 끝의 공백 확인
      - (on) blank-at-eof: 파일 끝의 공백 확인
      - (on) space-before-tab: 줄의 시작에서 탭 앞에 있는 공백 확인
      - (off) indent-with-non-tab: 탭 대신 스페이스로 시작하는 라인 확인 (tabwidth 옵션으로 제어됨)
      - (off) tab-in-indent: 줄의 들여쓰기 부분에 있는 탭 주시
      - (off) cr-at-eol: 줄 끝의 캐리지리턴 허용
   - 옵션들은 콤마로 구분하고, 끄고싶은 옵션 이름 앞에는 -을 붙이고, 사용하고 싶은 옵션은 그대로 적고, 기본값을 사용하고 싶으면 적지 않는다.
   - 이 옵션들은 몇몇 명령어에서 사용됨
      - `git diff`에서는 설정된 상황을 감지하고 색칠해서 보여준다.
      - `git apply`에서는 `--whitespace=(warn|fix)` 옵션을 지정해 경고하거나 패치를 적용하기 전에 공백 문제를 자동 수정하게 할 수 있다.
      - `git rebase`에서는 `--whitespace=fix` 옵션을 지정해 공백 문제를 자동 수정하게 할 수 있다.

### 서버 측 설정
- `receive.fsckObjects`: push 중 받은 object의 consistency 점검하기
   - 무거운 작업이므로 기본적으로는 꺼져 있음
- `receive.denyNonFastForwards`: force-push 거절하기
   - 특정 유저군에 대해 force-push를 거절하려면 server-side receive hook을 사용할 수 있음 (8장 3절)
- `receive.denyDeletes`: 브랜치 및 태그의 삭제를 방지하기
   - true로 설정할 시 누구도 지울 수 없음
   - 원격 브랜치를 지우려면 서버에서 ref 파일을 직접 지워야 함
   - ACL을 통해 유저별로 브랜치/태그의 삭제를 방지할 수 있음 (8장 4절)

## 기타
- `$#`의 뜻 = 인자의 수
- `$*`의 뜻 = 스페이스로 구분된 모든 명령줄 인자

## 영어 공부
- aid[에이드]
   - aid (sb/sth) (in sth/in doing sth)
   - aid sb (with sth)
   - (격식) (일이 수월해지도록) 돕다
- take note of: ~에 주목하다
- not nearly: 결코 ~이 아닌, far from
