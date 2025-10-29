# A3.4 Appendix C: Git Commands - Branching and Merging

- `git branch`: 브랜치 관리 툴
  - `-u|--set-upstream-to`: 업스트립 브랜치 설정(=브랜치를 추적 브랜치로 만듦)
  - 내부적으로 `.git/refs/heads/`에 있는 참조
- `git checkout`: 브랜치 전환 또는 내용을 WD로 체크아웃
  - 전환 목적 -> `git switch`
    - `--track`: 추적 브랜치로 만듦
    - 내부적으로 HEAD가 가리키는 브랜치를 변경
  - unadd 목적 -> `git restore`
    - `--conflict`: 충돌 마커를 다시 만듦
- `git merge`: 하나 이상의 브랜치 병합
- `git mergetool`: 외부 병합 도구 실행
- `git log`: 최신순으로 도달 가능한 히스토리 출력
- `git stash`: 임시 저장
- `git tag`: 태그
