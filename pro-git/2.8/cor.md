# 2.8 요약
2장은 git의 기본적인 명령어들에 대해 다룬 장이었다.

## 2장 1절
깃 레포지토리를 생성하는 방법을 알려준 절이었다: `git clone <url> [<dirname>]`

## 2장 2절
변경사항을 저장하는 방법을 다루는 절이었다.

파일 = tracked 혹은 untracked
tracked = unmodified 혹은 modified 혹은 staged

`git status --short` => 좌측열은 stage 영역, 우측열은 working directory 영역 / A = newly staged

`git add <filename>` => 이 내용을 다음 커밋에 추가하기

`git diff` => stage 영역과 w.d. 영역간의 차이를 보여줌
`git diff --cached` => stage 영역과 지난 커밋간의 차이를 보여줌

`git commit -v` => diff도 보여줘
`git commit -m msg` => 에디터를 열지 않고 커밋 메시지를 작성하겠다
`git commit -a` => tracked된 파일에 대해 변경된 파일들이 자동으로 add됨

`git rm --cached` => 파일은 내버려두고 stage 영역에서만 지워
`git rm \\*` => rm에서 wildcard를 사용할 때는 \를 붙여주기

## 2장 3절
커밋 이력을 조회하는 방법을 알려준 절이었다.

`git log` 에 다양한 옵션을 넣어서 히스토리가 출력되는 형태를 변경할 수 있음.

주목할만한 옵션은:
- `-oneline` => 한줄로 짧게 보여줘
- `-grep` => 이 문자열이 들어있는 것만 보여줘
- `- path` => 맨 뒤에 위치시켜야 되는 옵션으로, 해당 경로에 있는 파일을 건드린 커밋만 보여줘
- `<n>` => n개의 커밋만 보여줘

## 2장 4절
작업을 되돌리는 방법을 알려준 절이었다.

중요: 푸쉬된적이 없는 커밋만을 amend하라.
커밋메시지를 수정하고 싶다 => `git commit --amend`
커밋을 너무 일찍 해서 파일을 빠트렸다 => 빠트린 파일 add 후 `git commit --amend`

`git restore --staged <filename>...` => stage한 파일 unstage하기
`git restore <filename>...` => modified된 파일 unmodify하기 (작업한 내용을 잃어버리게 되므로 주의)

중요: 깃에서 한번 커밋된것은 일반적으로 복구가 가능. 그러나 커밋된적이 없는것은 다시 복구하기 어렵대

## 2장 5절
원격 레포지토리의 개념에 대해 소개한 절이었다.

중요: 원격이라고 해서 반드시 인터넷상에 있다는 의미는 아님. 내 컴퓨터에 있을 수도 있음.

`git remote -v` => 등록된 원격 레포지토리 목록 보기 (기본값 origin)
`git remote add <remname> <url>` => 원격 레포지토리 등록하기

`git fetch <remname>` => 원격 레포지토리로부터 새로운 내용 받아오기. 받아온 이후 remname/branchname 과 같이 브랜치 접근 가능

중요: 원격브랜치를 track하게 되면 `git pull` 을 했을 때 fetch와 merge가 자동적으로 된다.

중요: `git push <remname> <branch>` 가 실패했다면 해당 원격 레포지토리에 write 권한이 없을수도 있고, 내가 push 하기 직전에 다른 누가 push 했기 때문일 수 있다. 후자의 경우 먼저 fetch해서 해당 작업물을 내쪽에 합쳐야 함.

`git remote show <remname>` 을 하면 해당 원격 레포지토리와 관련된 정보를 보여준다. 어떤 url을 사용해 pull, push하는지, 어떤 원격브랜치가 있는지 등.

중요: stale하다는 말의 뜻은, 나는 아직 가지고 있는 원격추적브랜치가 서버에서는 이미 제거된 브랜치일 경우를 뜻하는 듯하다.

중요: 브랜치의 종류에는 3개가 있는 듯하다. 로컬, 원격추적, 원격.

## 2장 6절
태그에 대해 소개한 절이었다.

태그란 특정한 커밋을 중요하다고 표시하는 꼬리표

`git tag [--list]` => 태그 전체 나열
`git tag --list "v1.2.*"` => 1.2.n 버전만 나열. 와일드카드를 쓰면 --list 옵션 필수적.

태그는 경량 태그와 주석 태그로 나뉨. 주석 태그는 여러가지 메타데이터를 가지고 있음.

`git tag -a <tagname>` => 주석 태그 만들기
`git tag <tagname>` => 경량 태그 만들기 (단, -a, -s, -m 옵션을 주면 안됨 이러면 주석태그되는 듯함)
`git tag ... <hash>` => 이전 커밋에 태그 달기
`git show <tagname>` => 태그 내용 확인

`git push <remote> <tag>` => 원격에 태그 전송하기
`git push <remote> --tags` => 태그들 일괄적으로 전송하기

`git tag -d <tagname>` => 로컬에서 태그 삭제하기
`git push <remote> --delete <tag>` => 원격에서 태그 삭제하기

`git checkout <tag>` => 해당 태그가 위치한 커밋으로 이동 (detached HEAD 상태 됨)

## 2장 7절
alias를 만드는 방법을 알려준 절이었다.

`git config --global alias.<cmdname> <cmd>` => 사용자 지정 명령어 등록

중요: `!` 로 시작하는 명령은 외부 명령어임 (깃의 subcommand가 아님)