# 9.1 Git and Other Systems - Git as a Client

bridge: 다른 VCS를 사용하는 개발자와 협업하기 위한 어댑터

## Subversion

- 특징: 선형 히스토리, 서버 중심
- bridge: `git svn`
  - 장점: 로컬 작업이 가능해짐
  - 권장: 선형 히스토리 유지, SVN 서버 사용, `git-svn-id`가 있는지 검사하면 Git 서버도 괜찮음
  - `clone`: `init` + `fetch`. 커밋을 한 번에 하나씩만 옮김
  - `-s` = `-T trunk -b branches -t tags`: 서브버전 브랜칭 및 태깅 규칙을 따른다는 뜻
  - `dcommit`: 로컬 작업을 서버에 하나씩 푸시(느림). `git-svn-id`를 포함한 커밋을 새로 만듦(체크섬이 변경됨)
  - `rebase`: 충돌이 발생시 리베이스. 충돌이 발생하지 않으면 무조건 병합되어서 어느 누구도 가지지 않은 상태가 서버에 존재 가능
  - Git 로컬 브랜치: `git merge --squash`된 것처럼 하나의 병합 커밋만 만듦
  - 서브버전 브랜치: 가능한 사용하지 않음

## Mercurial

- 특징: DVCS, 많은 면에서 유사
- `git-remote-hg` 설치 필요
- 클론: URL에 `hg::` 접두사를 붙여서 클론
- 참조는 `refs/hg`, `hrefs/notes/hg` 등에 별도로 관리
- `cp .hgignore .git/info/exclude`
- 워크플로 똑같음
- 북마크와 브랜치
  - 북마크: Git의 브랜치와 똑같음
  - 브랜치: 영구적으로 기록. `branches/블라블라`로 생성/접근
- 히스토리 재작성 미지원, 추가만 지원, 강제 푸시하면 저장소가 난해해짐

## Perforce

- 특징: 기업 환경에서 인기 있는 버전 관리 시스템(1995~), 단일 중앙 서버에 항상 연결되어 있음, 로컬에는 하나의 버전만 유지.
- 두 개의 브릿지 존재: Git Fusion, git-p4
- Git Fusion: Perforce에서 만듦. 서버 구성 필요
  - 서버의 변경셋을 Git 커밋으로 증분 변환
  - 대부분 깃 사용과 유사
- git-p4: 클라이언트 측 브릿지. 서버 구성 필요 없음
  - `p4` 실행 파일 필요
  - 몇가지 환경 변수 설정 필요
  - `git p4 clone` 복제 (모든 변경을 가져오지 않음)
  - 원격도 없고 푸시도 불가능
  - `git p4 sync`: fetch 같음
  - `git p4 rebase`: `sync` + `git rebase p4/main` (이거보다 조금 더 똑똑함)
  - `git p4 submit`: 서버에 수정 버전 생성. 편집기 실행.
  - 브랜칭도 지원
