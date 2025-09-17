# 1.6 깃 초기 설정

## 학습목표
- .gitconfig 파일에 대해서 이해한다.
- 이름과 이메일, 텍스트 에디터를 설정하는 방법을 숙지한다.
- 설정된 사항을 확인하는 방법을 숙지한다.

## .gitconfig 파일
- git을 처음 깔은 컴퓨터에 대해서 한번만 하면 됨 (업그레이드해도 변경x)
- 설정 바꾸려면 쳤던 명령어를 다시 치면 됨
- `git config` => 환경 설정 변수를 get/set하는 명령어
   - 아래단계가 윗단계를 이김
   - `[path]/etc/gitconfig` => 시스템 내의 모든 유저의 모든 repo에 적용 / `--system`
   - `~/.gitconfig` 혹은 `~/.config/git/config` => 특정 유저에게만 적용 / `--global`
   - `.git/config` => 해당 repo에만 적용 / 기본값(`--local`)

## 설정값 확인
- `--show-origin` => 모든 설정값과 이 설정이 어디에 속하는지 확인하기
- `git config --list [--show-origin]`
   - 설정값 출력하기
   - 같은 설정값이 한번이상 나올수있으며 이는 git이 여러개의 .gitconfig파일을 읽기 때문
   - 이러한 경우 마지막 값이 사용됨
- `git config <key>.<value> [--show-origin]` => 특정 설정값 확인하기

## 설정
### 이름과 이메일
- 커밋할때마다 사용되는 정보
- `git config --global user.name "Firstname Lastname`
- `git config --global user.email cor@example.com`
### 에디터
- 뭔갈 적어야 할 때 사용되는 에디터 지정
- 설정되어있지 않으면 시스템의 기본 에디터 사용됨
- `git config --global core.editor code --wait`
### 기본 브랜치명
`git config --global init.defaultBranch main`

## 영어 공부
- trump: 뭔갈 더 잘 말하거나 함으로써 누군가나 무언가를 이기다 / Taste trumps most if not all other factors when consumers choose food products.
- have the final say: 최종 결정권을 갖다