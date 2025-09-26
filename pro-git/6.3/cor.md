# 6.3 프로젝트 관리하기

## 학습목표
- 깃허브 상에서 프로젝트를 관리하는 방법을 이해한다.

## 프로젝트 생성
- 그냥 버튼 눌러서 생성하면 됨
- 깃허브 상의 모든 프로젝트는 https와 ssh로 접근 가능
   - 단, ssh로 접근하려면 깃허브 계정이 있어야 하고 ssh 공개키를 등록해두어야 함
   - https의 경우 웹사이트 주소 = 접근에 필요한 주소

## 협업자 등록
- commit access를 주려면 그 사람을 collaborator로 등록해야 함
- 프로젝트에 추가하면 push access를 줄 수 있음 => 해당 프로젝트와 git 레포지토리에 read와 write access를 주는 것
- settings -> collaborators -> type a username -> add collaborator (등록 후 취소도 가능)

## 풀 리퀘스트 관리
- pr은 내 레포지토리의 포크본 내의 브랜치에서 왔든가 내 레포지토리의 다른 브랜치에서 왔든가 둘중 하나
- 이 둘의 차이점: 전자는 종종 나는 기여자의 브랜치에 푸시할 수 없고 기여자는 나의 브랜치에 푸시할 수 없음. 후자는 쌍방이 브랜치에 접근 가능함.

### 이메일 알림
- 여러가지 URL이 들어있음
- `git pull <url> patch-1` => remote 추가 없이 원격브랜치 병합하는 방법
- .diff url은 unified diff 제공
- .patch url은 이 pr의 패치버전을 제공 => `curl https://.../1.patch | git am` 도 기술적으로 가능

### 토의하기
- pr에 커멘트가 달릴 때마다 이메일로 알림이 오며 해당 이메일에는 이 pr로 가는 링크가 들어있음
- 이메일에 답신해도 pr 스레드에 커멘트가 달림
- pr을 병합하지 않고 닫아도 기여자한테 알림이 감

### PR 레퍼런스
- pr 브랜치 = 서버에 있는 유사 브랜치
- `git ls-remote <remote-or-url>`
- 이 레포지토리가 깃허브에 있고 열린 pr을 가지고 있다면 refs/pull로 시작하는 레퍼런스들을 확인 가능
- 각 pr당 2개의 레퍼런스 존재
   - /merge로 끝나는 레퍼런스는 이 pr을 merge하게 됐을 때 만들어질 커밋을 의미 => 실제로 머지하기 전에 테스트 가능
   - /head로 끝나는 레퍼런스는 pr 브랜치의 마지막 커밋을 가리킴
- 특정 레퍼런스 직접 가져오기 => `git fetch origin refs/pull/pr-num/head`
   - /head가 가리키는 커밋을 가리키는 포인터를 `.git/FETCH_HEAD`에 저장함
   - `git merge FETCH_HEAD`로 내가 원하는 브랜치로 병합해 테스트 가능
   - 그러나 이 방법은 다소 불편
- 모든 pr을 fetch하고, 서버와 통신할때마다 최신상태로 유지하는 방법이 있음
   - `.git/config`를 열고 [remote "origin"] 섹션을 찾는다.
   - `fetch =` 로 시작하는 줄은 refspec이며, 리모트에 있는 이름을 로컬에 있는 이름과 연결하는 방법임
   - `fetch = +refs/pull/*/head:refs/remotes/origin/pr/*` 줄 추가 => pr 브랜치는 로컬에 pr/num으로 저장하라는 뜻
   - 이후 `git fetch` 및 `git checkout pr/num` 가능

### PR에 PR 올리기
- main이나 master브랜치를 target하는 pr만 만들수 있는게 아니라, 임의의 브랜치를 target하는 pr도 만들 수 있음
- 다른 pr을 target하는 pr도 만들 수 있음
- pr 올릴때 target할 branch와 fork를 선택 가능하다는 듯

## 멘션과 알림
- 멘션하려면 `@`문자 다음에 유저명 작성. 멘션하면 해당 유저에게 알림이 감.
- subscribe의 조건 => pr이나 issue에서 멘션되거나, 내가 그걸 만들었거나, 내가 해당 repo를 watch하고 있거나, 무언가에 커멘트를 남겼다
- subscribe되면 계속 알림을 받음 => unsubscribe 버튼 눌러서 언제든지 취소 가능

### 알림 설정
- 설정 => 알림 설정
- 웹 and/or 이메일
- 웹 알림 => 파란색 점
- 이메일 헤더에 다양한 정보가 들어있어서 필터링 가능
- 이메일과 웹을 둘다 활성화해놨을 경우, 이메일로 알림을 먼저 읽으면 웹 알림은 읽은 것으로 마킹됨 (메일 클라이언트에서 이미지를 허용해놨다면)

## 특별한 파일
다음과 같은 파일이 레포지토리에 있으면 깃허브는 그것을 인지함

### README 파일
- 거의 어떤 format이든 가능
- README, README.md, README.asciidoc 등
- 이 파일의 내용이 프로젝트 랜딩페이지에 렌더링됨
- 일반적으로 다음과 같은 내용 들어있음
   - 무엇에 대한 프로젝트인지
   - 어떻게 환경설정하고 어떻게 설치하는지
   - 어떻게 사용하거나 실행하는지
   - 라이선스
   - 기여하는 방법
- 이미지나 링크 포함 가능

### CONTRIBUTING 파일
- 임의의 파일확장자
- PR을 만들때 알림창이 뜸

## 프로젝트 관리
### 기본 브랜치 변경
- 대부분의 operation에 영향을 줌
- clone했을때 어떤 브랜치가 기본으로 checkout되는지 등

### 프로젝트 이적하기
- 다른 유저나 조직에 프로젝트 이적 가능
- watcher와 star도 이동됨
- redirect 설정됨 (web request뿐만 아니라 clone, fetch도 리다이렉트됨)

## 영어 공부
- belabor: 장황하게 논하다
- grant: 승인하다
- come along: 도착하다
- obscure: 보거나 이해하기 어렵게 하다
- prose: 산문