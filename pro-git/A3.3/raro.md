# A3.3 Appendix C: Git Commands - Basic Snapshotting

- `git add`: 인덱스로 내용 추가(=다음 커밋에 들어갈 파일 추가)
  - 병합 충돌 해결 후에도 사용
  - `-i`나 `-p`로 대화식 스테이지
  - 내부적으로 인덱스를 업데이트 하고, 트리를 만듦
- `git commit`: 인덱스 트리를 새 영구 스냅샷으로 디비에 기록, 브랜치 전진
  - `-a`: `git-add` 생략
  - `-m`: 커밋 메시지를 바로 전달
  - `--amend`: 가장 최근 커밋 재작성
  - `-S`: 서명 포함
  - 내부적으로 인덱스 트리와 기타 정보로 커밋 객체를 만들고, 브랜치 전진
- `git status`: WD와 인덱스 사이 다른 상태인 파일을 출력
- `git diff`: 두 트리의 차이를 출력
  - 기본값: WD와 인덱스 비교
  - `--staged`: 인덱스와 HEAD 비교
  - `A B`: 두 커밋 비교
  - `A...B`: AB의 공통 조상과 B를 비교(참고: 두 끝점을 비교하는 것이기 때문에 range notation과 다름)
  - 충돌 파일에서: `--theirs`, `--ours`, `--base` 다른 스테이지와 비교
  - `--submodule`: 서브 모듈 변경 사항 비교
  - `--check`: 커밋 전 공백 문제 확인
  - `-b`: 공백 차이 무시
- `git difftool`: 외부 도구 실행
- `git reset`:
  - path가 없는 경우:
    1. HEAD 이동
    1. (선택) 인덱스 변경
    1. (선택) WD 변경
  - path가 있는 경우: unstage. `git restore --staged`와 같음
  - 병합 충돌 취소시: `git reset --hard`
- `git rm`: WD, 인덱스에서 파일 제거
  - `--cached`: 인덱스에서만 제거
  - `--ignore-unmatch`: 제거할 파일이 없어도 오류 발생 안 함
- `git mv`: `mv` + `git add` + `git rm`와 동치
- `git clean`: WD에서 untracked 파일 제거
