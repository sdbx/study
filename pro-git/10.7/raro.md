# 10.7 Git Internals - Maintenance and Data Recovery

## 유지보수

### auto gc

- Git은 "auto gc"(`git gc --auto`)를 자동 실행

#### 실행 조건

- loose 객체가 많은 경우. `gc.auto`로 설정 (기본값 7000개 이상)
- packfile이 많은 경우. `gc.autopacklimit`로 설정 (기본값 50개 이상)

#### 동작

- 모든 loose 객체를 packfile으로 패킹
- 여러 packfile을 하나의 큰 packfile로 통합
- 몇 달 지난 dangling 객체를 제거
- 참조를 단일 파일로 패킹(`.git/refs/` -> `.git/packed-refs`)
  - 참조 업데이트시 새 파일 작성. `refs`에 없으면 `packed-refs`로 폴백
  - `^`는 바로 위 태그가 주석 태그, 해당 줄이 주석 태그가 가리키는 커밋을 의미

### 데이터 복구

- reflog: HEAD를 변경할 때마다 HEAD가 무엇이었는지 자동으로 기록
- 업데이트 조건: 커밋이나 브랜치 변경, `git update-ref` 사용
- `.git/logs/` 디렉토리에 보관
- `git reflog`: reflog 확인
- `git log -g`: reflog에 대한 일반 로그 출력 제공
- reflog가 남은 경우: reflog에서 커밋을 찾고, 새 브랜치를 만들어 복구
- reflog가 없는 경우:
  - `git fsck --full`: 모든 dangling 객체 표시
  - "dangling commit"를 찾아서 해당 커밋 해시에서 새 브랜치를 만들어 복구

### 객체 제거

- 결국 사용하지 않기로한 거대한 바이너리 파일은 `clone`이 전체 히스토리를 가져오는 동작 때문에 제거하는 것이 좋을 수 있음. 특히 다른 VCS에서 가져온 직후 유용
- 수정해야하는 커밋 이후의 모든 커밋을 재작성해야 함

#### 과정

1. `git count-objects -v`로 얼마나 많은 공간을 사용하는지 확인
   - size-pack 항목: packfile 크기(KB)
   - size 항목: 느슨한 객체 크기(KB)
1. `git verify-pack`을 정렬하여 큰 객체 식별
   - `git verify-pack -v .git/objects/pack/<pack>.idx | sort -k 3 -n | tail -3`
1. 모든 커밋에서 해당 blob 객체 필터링
   - `git rev-list --objects --all | grep <blob_id>`
   - `--objects`: 커밋과 연관된 객체 ID도 출력
1. `filter-branch`등으로 해당 파일 제거
   - WD로 불러오지 않고 인덱스에서 작업하면 더 빠름
1. 패킹 전에 이전 커밋에 대한 포인터가 있는 모든 것을 제거:
   - `rm -Rf .git/refs/original && rm -RF .git/logs/ && git gc`
1. (선택) 로컬에 loose 객체로 남아있는 제거한 파일의 객체 제거
   - `git prune --expire now`
   - 참고: 여전히 loose 객체로 남아있지만, dangling이므로 푸시되거나 후속 클론에서 전송되지 않음
