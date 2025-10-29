# A3.4 브랜치와 병합

## 학습목표
- 다음의 명령어들을 복습한다.
```bash
git branch
git checkout
git merge
git mergetool
git log
git stash
git tag
```

## 요약
- git branch
   - 브랜치 관리 도구
   - `-u` => 추적브랜치 설정
- git checkout
   - (데이터베이스에 있는) 항목을 작업영역으로 꺼내기
   - 브랜치 변경
   - `--conflict` => 충돌상황 재현
- git merge
   - 하나 혹은 그 이상의 브랜치를 내가 현재 위치한 브랜치로 병합
   - 스쿼시 머지 가능
   - 서명이 유효한 브랜치만 머지 가능
   - subtree 머지에 대해서도 다뤘었음
- git mergetool
   - 외부 병합 helper를 실행
- git log
   - 커밋 이력 출력
   - 때때로 두개 혹은 그 이상의 브랜치 사이의 차이를 커밋 수준에서 보기 위해서도 사용
   - `-p` => 패치, `--stat` => 도입된 사항 확인
   - `a...b` 와 함께 쓰면 좋은 `--left-right` 옵션
   - `--merge` => 충돌난 파일과 관련있는 커밋만 보기
   - `-g` => reflog
   - `-S` `-L` => 고급 검색
- git stash
   - 임시저장
- git tag
   - 북마크 붙이기
