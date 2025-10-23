# 10.5 Refspec

## 학습목표
- refspec에 대해 이해한다.

## 개요
- 원격브랜치와 로컬레퍼런스 사이의 대응은 복잡할수도 있음
- `git remote add <name> <url>`을 하게 되면...
   - `.git/config` 파일에 섹션이 생김
   - 이 원격의 이름, url, 그리고 **fetch**에 사용되는 **refspec**이 적혀있음
- refspec의 형식
   - (optional) +
      - fast-forward가 아니더라도 레퍼런스를 업데이트하라는 뜻
   - `<src>:<dst>`
      - src: 원격측 레퍼런스에 대한 패턴
      - dst: 원격측 레퍼런스가 로컬에서 트랙될 곳
- 예를 들어 `refs/heads/*:refs/remotes/origin/*` 이라는 말의 뜻은
   - 서버측의 refs/heads/ 아래에 있는 모든 레퍼런스를 fetch해오고
   - fetch해온걸 refs/remotes/origin/ 아래에 (지역적으로) 작성하라는 것
- origin/master나 remotes/origin/master로 축약해서 적어도 refs/remotes/origin/master로 확장됨
- 특정한 refspec을 작성함으로써 일회성 fetch 가능 => `git fetch origin main:refs/remotes/origin/mymain`
- 여러개의 refspec을 작성할수도 있음 => 명령줄에서도 되고 config 파일에서도 됨
- 깃 버전 2.6.0부터 부분적 glob이 가능 => 예를들어 ab*면 abc adb 이런게 된다는 얘기인 것으로 추측됨
- 레퍼런스를 네임스페이스화하면 쉽게 관리 가능

## refspec push하기
- `git push origin main:refs/heads/namespace/main`
   - 내 main 브랜치를 원격에 있는 namespace/main에 push한다는 뜻
- git push origin까지만 쳐도 자동으로 되게 하려면 config 파일에 push 항목을 추가
   - push = refs/heads/main:refs/heads/namespace/main
- 한편, refspec을 사용해 한 저장소에서 fetch하고 다른 저장소로 push하는 것은 불가능하다.
   - 이렇게 하려면 6장 2절 맨 마지막 참고

## refspec 삭제하기
- `git push origin :topic` => 원격에서 레퍼런스 삭제하기
- `<src>` 부분이 비어있기 때문에 원격에 있는 topic을 지우게 됨
- 깃 버전 1.7.0 이후로는 `git push origin --delete topic` 구문을 사용할 수 있음
- 이 내용은 지난 2장 6절에서 태그를 삭제하는 방법에서 소개되었던 바 있음
