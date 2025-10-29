# A3.13 요약
부록 C에서는 그동안 책에서 다뤘던 명령어들을 주제별로 되돌아보았다.

## A3장 1절
- config: 환경설정
- help: 도움말

## A3장 2절
- init: 초기화, 재설정
- clone: 복제

## A3장 3절
- add: 인덱스에 추가
- status: 상태보기
- diff: 차이보기
- difftool: 외부 diff툴 실행
- commit: 스냅샷 저장
- reset: 트리 상태 변경
- rm: 인덱스, 작업영역에서 삭제
- mv: 파일 이동
- clean: 작업영역에서 untracked 파일 삭제

## A3장 4절
- branch: 브랜치 관리
- checkout: 파일 꺼내기
- merge: 병합하기
- mergetool: 외부 merge툴 실행
- log: 이력 보기
- stash: 임시저장
- tag: 책갈피 달기

## A3장 5절
- fetch: 서버와 동기화
- pull: 서버와 동기화 후 병합
- push: 서버에 올리기
- remote: 원격 저장소 정보 관리
- archive: 압축파일 생성
- submodule: 서브모듈 관리

## A3장 6절
- show: 깃 오브젝트 정보 출력
- shortlog: 이력을 작성자별로 요약
- describe: 특정 커밋을 표현하는 문자열 생성 (최근 태그 기준)

## A3장 7절
- bisect: 이진탐색
- blame: 파일내 각 줄에 대해 마지막으로 수정한 커밋 표시
- grep: 프로젝트의 임의의 버전에 대해 문자열/정규식 검색

## A3장 8절
- cherry-pick: 한 커밋에서 도입된 변경사항 다른곳에 재도입하기
- rebase: 여러개의 커밋을 다른곳에 재도입하기
- revert: 해당 커밋에서 적용된 변경사항의 반대를 적용하기

## A3장 9절
- apply: (git) diff로 생성된 패치 적용하기
- am: format-patch로 생성된 패치 적용하기
- format-patch: mbox 포맷의 패치 생성하기 (커밋 작성자 정보 포함)
- imap-send: format-patch로 생성된 패치 IMAP drafts로 보내기
- send-email: format-patch로 생성된 패치 이메일로 보내기
- request-pull: 풀리퀘스트 요청에 필요한 메일 내용 생성하기

## A3장 10절
- svn: 깃을 클라이언트로 사용해 svn 작업하기
- fast-import: 외부 정보를 깃 내로 import하기

## A3장 11절
- gc: 불필요한 파일 제거하고 기존 파일은 효율적으로 저장하기
- fsck: 데이터베이스에 문제가 없는지 점검하기
- reflog: 브랜치의 마지막 위치가 어디였는지 보기
- filter-branch: 특정한 패턴으로 다수의 커밋 재작성하기

## A3장 12절
- ls-remote: 원격 레퍼런스 확인하기
- ls-files: 인덱스 확인하기
- rev-parse: SHA-1 확인하기

## A3장 13절
이렇게 대단원은 막을 내리게 된다.
