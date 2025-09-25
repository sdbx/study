# 6.2 프로젝트에 기여하기

## 학습목표
- 깃허브 상에 있는 프로젝트에 기여하는 방법을 이해한다.
- 관련하여 깃허브 사용법에 익숙해진다.

## 프로젝트를 fork한다는 말의 뜻
- push 접근을 할수없는 프로젝트에 기여하고싶을때 fork해야 함
- fork를 하면 내 namespace 아래에 해당 프로젝트의 복사본을 깃허브가 만들어줌
- 풀 리퀘스트를 통해 원본 레포지토리에 기여 가능

### fork라는 말의 뉘앙스
역사적으로 fork라는 말은 맥락상 다소 부정적이었는데 그 의미는 누군가가 오픈소스 프로젝트를 다른 방향으로 취해 개발함으로써 때때로 경쟁관계에 놓이는 프로젝트를 만들어 기여자를 양분한다는 것이다.

그러나 깃허브에서 fork는 단순히 복제본을 의미함.

## 깃허브 플로우
- 깃허브는 풀 리퀘스트, 토픽 브랜치를 중심으로 하는 특정한 협업 워크플로우에 맞춰 설계됨 (5장 1절에서 다룬 integration-manager workflow임)
- 공식 깃허브 cli 툴인 gh를 사용해 깃허브 웹 인터페이스에서 할수있는 대부분의 작업을 할수있다고 함

1. 프로젝트를 포크한다.
2. master에서 토픽 브랜치 생성
3. 해당 토픽 브랜치 위에서 커밋 생성
4. 내 fork에 해당 토픽 브랜치 push
5. 깃허브에서 pull request 생성 (제목과 설명을 잘 쓰는 것이 좋음)
6. 메인테이너와 토의 및 추가적인 작업
7. 메인테이너가 해당 pr을 merge하거나 close
8. 갱신된 master를 내 fork로 sync

### pr 만드는법
- 포크 웹페이지에 방문하면 알림이 뜸
- branches 페이지에 방문해 해당 브랜치를 찾아 pr을 만들수도 있음

### pr 창에서 확인할수있는것
- master 브랜치에 대해 ahead인 본 토픽 브랜치 내의 커밋들
- unified diff => `git diff master...<branch>`
- merge가 clean하게 되는지 아닌지

### pr 사용법
- 기여자가 완전한 작업물을 가지고 있을때
- internal project에서 종종 개발단계의 시작점에서도 사용가능 (pr이 올라간 뒤에도 계속 토픽브랜치에 push할 수 있기 때문)

### 기타
- 이미 만든 pr에 커밋을 추가해도 알림이 새롭게 가지는 않으므로 댓글을 달아야 함
- 머지버튼을 누르면 non-fast-forward 머지가 됨 (머지커밋생성)
- 같은 레포지토리 내의 두 브랜치 사이에서도 pr을 만들수 있음 (꼭 fork가 필요한것은 아님)

### git diff --word-diff
word diff를 출력함

## PR 활용법
### PR과 패치 기여의 차이점
- 대부분의 깃허브 프로젝트들은 PR을 완전한 작업이라기보다는 반복적인 대화로 생각함
- 메인테이너가 변경을 요구하면 기존 작업 위에 새로운 커밋이 올라감 (리베이스 후 새로운 PR 올리는거 아님)

### PR이 clean merge가 안될때 해결법
- target 브랜치 위로 rebase하든지 target 브랜치를 토픽 브랜치로 merge하든지 둘중 하나 (전자는 비추천)
- rebase는 이력이 약간 더 깨끗해진다는거 외에 장점이 없음. 그러나 단점이 큼 (어렵고 오류에 취약)
- merge하려면 원본 레포를 remote로 등록후 (이름 예시: upstream) fetch하고 upstream/master를 토픽브랜치에 merge한다. 이슈가 있으면 고치고 git push origin <topic-branch>한다.
- 정 rebase하려거든 pr이 열려있는 기존 브랜치에 forcepush 하지 말고 새 브랜치에 push후 기존 pr을 reference하는 새 pr을 만들고 기존 pr을 닫아라.

### 레퍼런스 하는법
- 모든 pr과 issue는 통틀어서 고유한 번호가 부여됨
- 다음을 글이나 댓글에서 사용하면 cross-reference됨 (깃헙이 자동적으로 pr 타임라인에 trackback 이벤트를 만듦)
   - `#n`
   - `username#n`
   - `username/repo#n`
   - `url-to-issue-or-pr`
   - `commit-sha-1-40-len`

## 마크다운 지원
- task list
   - [ ] a
   - [x] b
- code snippet
- quote => 단축키가 있음: 텍스트 하이라이트 한 후 r키 누르기
- emoji => :name:
- image => 드래그 앤 드랍 가능

## fork를 최신상태로 유지하는법
"this branch is n commits behind original:master"
```
$ git remote add upstream url
$ git fetch upstream
# master 브랜치가 upstream에서 fetch하도록 설정
$ git branch --set-upstream-to=upstream/master master
# 기본 push 레포지토리를 origin으로 설정
$ git config --local remote.pushDefault origin

$ git checkout master
$ git pull
$ git push

# 단, master에 직접적으로 커밋하지 않도록 주의하라.
```

## 영어 공부
- aggregate[애그리거트]: total
- trivial[트리비얼]: 사소한, 평범한
- ensue[인수]: 뒤따르다
- culminate: ~로 끝이 나다(막을 내리다)
- trackback: a사이트에 b사이트로 가는 링크가 만들어졌을때, a사이트로 가는 상호 링크가 만들어질수있게 발송되는 자동 알림
- reciprocal: 상호간의
- supersede: 대체하다
- tedious[티디어스]: 지루한, 싫증나는