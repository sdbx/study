# 10.8 환경변수

## 학습목표
- 쉘 환경변수가 깃에 어떻게 영향을 미치는지 이해한다.

## 요약
- 깃은 항상 bash 쉘 내에서 작동하며, 다수의 쉘 환경변수가 깃의 작동에 영향을 미침
- pathspec이란 말의 뜻: git에서 path를 명시하는 방법을 이르는 말
- 깃은 curl 라이브러리를 사용해서 http 네트워크 작업함
- 쉘 환경변수와 config 파일의 변수가 같은 작업을 담당할 경우, 쉘 환경변수가 우선도가 높은 것으로 보임
- 대략 다음과 같은 영역을 제어할 수 있음:
   - 전역 행동: `GIT_PAGER` `GIT_EDITOR` 등
   - 저장소 위치: `GIT_DIR` `GIT_INDEX_FILE` 등
   - pathspec 지정
   - 커밋: `GIT_AUTHOR_NAME` `EMAIL` 등
   - 통신: `GIT_CURL_VERBOSE` 등
   - diff와 merge: `GIT_DIFF_OPTS` `GIT_MERGE_VERBOSITY` 등
   - 디버깅: `GIT_TRACE` 등
   - 기타: `GIT_ASKPASS` `GIT_FLUSH` 등

## 영어 공부
- interface[인털페이스]
   - ~ (sth) (with sth) | ~ A and B
   - 접속하다[되다]
- misnomer[미스노우머]: 부정확한 명칭
