# 10.9 Git Internals - Summary

## `.git/` 구조

- `objects/`: 데이터베이스의 모든 내용 저장
- `refs/`: 커밋 객체의 포인터(브랜치, 태그, 리모트 등) 저장
- `HEAD`: 현재 체크아웃한 브랜치를 가리킴
- `index`: 인덱스 정보를 저장
- `hooks/`: 클라이언트 측, 서버 측 훅이 위치
- `info/`: 부가 정보를 담음
- `config`: 프로젝트 한정 구성 파일

## content-addressable filesystem

- 단순 key-value data store
- ID (key): 유일. header + content의 체크섬
- 객체 (value): blob, tree, commit, tag
- 객체 데이터베이스: `.git/objects`에 담김

## 객체

- header: 유형, 내용의 크기(byte)
- header + content의 체크섬이 ID가 됨
- 파일은 zlib으로 압축함.
- 명령:
  - `git hash-object -w <filename>` 객체 생성
  - `git cat-file -p <object_id>`: 객체 내용 출력

### 객체 저장 방식

- loose: 객체를 저장하는 초기 형식
  - `.git/objects/xx/xxx...xxx`
- packfile: 공간 효율적인 형식
  - 이름과 크기가 비슷한 파일을 묶어 delta로 표현
  - 최근 것이 원본, 시간 순으로 delta를 만듦
  - `.pack`: packfile. 객체의 내용 혹은 delta
  - `.idx`: 목차. packfile의 offset을 포함
  - 만들어지는 조건: gc, 원격 서버에 push(일부 프로토콜)
  - dangling 객체는 미포함
  - 여러번 repack해도 문제 없음

### Blob 객체

- 거의 모든 것을 담을 수 있음

### Tree 객체

- UNIX 디렉토리의 단순 버전
- tree의 각 항목: mode, type(tree또는 blob), 해시, 이름
  - blob: inode에 대응
  - blob의 모드는 세 가지만 사용: 일반 파일(`100644`), 실행 가능한 파일(`100755`), 심볼링 링크(`120000`)
- `main^{tree}`로 마지막 커밋의 tree 객체를 선택할 수 있음

### Commit 객체

- 누가, 언제, 왜 저장했는지
- 트리 객체의 ID
- 부모 커밋이 있는 경우 포함
- 명령:
  - `git write-tree`: 인덱스 내용을 트리 객체로 만듦

### Tag 객체

- 태거, 날짜, 메시지, 포인터 포함
- 트리 객체를 가리키는 커밋 객체와 다르게, 일반적으로 커밋을 가리킴(아무거나 가리킬 수 있음)
- 주석 태그만 태그 객체를 만듦(경량 태그는 참조만 만듦)

## 참조

간단한 이름

- 일반 참조: 객체 ID를 가리키는 이름
- 심볼릭 참조: 다른 참조를 가리키는 이름
- `.git/refs/`에 저장
- 명령:
  - `git update-ref <ref> <new_oid>`: `<ref>`가 `<new_oid>`를 가리키게 만듦
  - `git symbolic-ref <name> <ref>`: `<name>`이 `<ref>`를 가리키게 만듦

### HEAD

- `.git/HEAD`
- 현재 브랜치에 대한 참조(보통 심볼릭 참조)
- detached HEAD: 일반 참조
  - 태그, 커밋, 원격 브랜치를 체크아웃할 때 발생
- `git commit` 실행시, 커밋 객체를 생성하고, HEAD가 가리키는 커밋 ID를 커밋의 부모로 지정

### 태그 참조

- `.git/refs/tags/`
- 경량 태그: 커밋을 직접 가리키는 참조
- 주석 태그: 태그 객체를 가리키는 참조
- 모든 객체에 태그를 지정 가능

### 리모트

- `.git/refs/remotes/`
- 읽기 전용으로 간주
- 체크아웃 할 수 있지만, detached HEAD가 되므로 커밋하면 HEAD는 움직이지만 리모트는 움직이지 않음

## Refspec

`+<src>:<dst>`

- 리모트와 로컬의 참조를 매핑
- `+`: (선택) fast-forward가 아니더라도 참조를 업데이트
- `<src>`: 출처 참조 패턴
- `<dst>`: 목적지 참조 패턴
- glob와 네임스페이스 지원: `refs/pull/*/head:refs/remotes/origin/pr/*`
- CLI이나 config에 지정 가능
- 여러번 명시 가능
- CLI에서는 짧은 이름을 사용해도 전체 참조 이름으로 확장됨 `origin/main` -> `refs/remotes/origin/main`

### fetch

- `git fetch origin 리모트:로컬`

### push

- `git push origin 로컬:리모트`

### 리모트 참조 제거

- `git push origin :리모트`
- (권장) `git push origin --delete 리모트`

## 데이터 전송 방식(Smart 프로토콜)

- 필요한 정보만 포함한 맞춤형 packfile을 생성하여 전송

## 유지보수

### auto gc

- 주기적으로 `git gc --auto`를 자동 실행
- 기본적으로 아무것도 하지 않음. loose 객체나 packfile이 많은 경우에만 작업을 함.
- 동작:
  - 모든 loose 객체를 packfile로 패킹
  - 여러 packfile을 하나의 큰 packfile로 통합
  - 몇 달 지난 dangling 객체 제거
  - 참조를 단일 파일로 패킹(`.git/refs/` -> `.git/packed-refs`)
    - 참조 업데이트시 새 파일을 작성. `refs`에 없으면 `packed-refs`로 폴백하는 방식

### 데이터 복구

- reflog: HEAD를 변경할 때마다 HEAD가 무엇이었는지 자동으로 기록
- 기록 조건: 커밋이나 브랜치 변경, `git update-ref`로 참조 변경
- `.git/logs/`에 보관
- 명령:
  - `git reflog`: reflog 확인
  - `git log -g`: reflog에 대한 일반 로그 출력 제공
  - `git fsck -full`: 모든 dangling 객체 표시

## 환경 변수

- Git 기본 동작을 변경하는 다양한 환경 변수 지원
- gitconfig보다 우선시됨
