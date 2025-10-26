# 10.8 Git Internals - Environment Variables

- gitconfig에 동일한 항목이 있는 경우 override하는 경향이 있음

## 전역 동작

- GIT_EXEC_PATH: 서브 명령어를 찾는 위치를 결정. `git --exec-path`로 현재 설정을 확인
- HOME: (Git과 무관) 전역 gitconfig를 찾을 때 사용
- PREFIX: `$PREFIX/etc/gitconfig`에서 시스템 수준 gitconfig를 찾음
- GIT_CONFIG_NOSYSTEM: 시스템 수준 gitconfig 설정을 무시하는 옵션
- GIT_PAGER: pager 프로그램을 설정. 없으면 PAGER를 사용
- GIT_EDITOR: 텍스트 편집기를 설정. 없으면 EDITOR를 사용

## 저장소 위치

- GIT_DIR: `.git/` 위치 지정. 없을 경우 `~`나 `/`에 도달할 때까지 트리를 올라가면서 찾음
- GIT_CEILING_DIRECTORIES: `.git/` 검색 동작 제어. 일찍 시도를 중지하도록 할 수 있음
- GIT_WORK_TREE: (not bare) 작업 디렉토리 루트 위치
- GIT_INDEX_FILE: (not bare) 인덱스 파일 경로
- GIT_OBJECT_DIRECTORY: 객체 디렉토리 위치 지정
- GIT_ALTERNATE_OBJECT_DIRECTORIES: 대체 검색 위치를 지정. 콜론으로 구분

## Pathspecs

와일드카드로 경로를 지정하는 방법을 제어. `.gitignore` 파일과 명령줄에서 사용

## 커밋

커밋 객체에 들어가는 정보를 제어

## 그 외

네트워킹, diff, 병합, 디버깅 등 다양한 동작을 바꾸는데 사용 가능
