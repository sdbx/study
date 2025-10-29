# A3.8 패치

## 학습목표
- `git cherry-pick`, `git rebase`, `git revert`를 복습한다.

## 요약
- git cherry-pick
   - 하나의 커밋에서 도입된 변경사항을 취해 내가 현재 위치한 브랜치 위에 새로운 커밋으로 도입하기
- git rebase
   - 자동화된 cherry-pick
   - 일련의 커밋을 취해 다른곳에 같은순서로 replay함
   - `-i` => 인터랙티브 리베이스
- git revert
   - 역 cherry-pick
   - 명시한 커밋에서 도입된 변경사항의 정확한 반대를 적용하는 새 커밋 생성 => 결국 undo와 마찬가지
   - 단 머지 이력이 여전히 이력에 남아있으니 주의
