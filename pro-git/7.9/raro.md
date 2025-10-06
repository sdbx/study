# 7.9 Git Tools - Rerere

## rerere - reuse recorded resolution

- hunk 충돌을 어떻게 해결했는지 기억 후 다음 충돌이 발생하면 자동으로 해결
- 유용한 경우
  - 오래 가는 브랜치의 히스토리에 중간 커밋을 남기지 않고 깔끔하게 병합하고 싶은 경우
  - rebase를 자주 하는 경우
  - 여러 토픽 브랜치를 테스트할 때, 문제있는 토픽 브랜치를 제외하고 나머지 브랜치만 병합하는 경우
- 기능 활성화:
  - `git config --global rerere.enabled true`
  - 또는, 활성화 할 저장소에서 `.git/rr-cache` 디렉토리 생성 (명확하지 않아 비권장)

### 명령

- `git rerere status`: 병합 전 상태를 기록한 내용 출력
- `git rerere diff`: resolution의 현재 상태
  - `git ls-files -u`: 충돌한 파일과 그 파일의 base, ours, theirs 버전 확인 (`rerere`와 직접적으로 관련은 없음)
- `git rerere`: 캐시된 resolution을 사용하여 충돌을 자동으로 해결
