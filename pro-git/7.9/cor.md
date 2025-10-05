# 7.9 rerere

## 학습목표
- `git rerere`가 무엇인지 알아본다.
- `git rerere`의 사용방법을 숙지한다.

## rerere 소개
- reuse recorded resolution
- 내가 hunk conflict를 resolve한 방식을 기억하고, 다음번에 같은 conflict가 생기면 git이 자동으로 resolve
- 이 기능이 유용한 얼마간의 상황이 있음 => 한번 해결한 conflict를 다시 해결하고 싶지 않을 때.

## rerere 활성화 방법
- `git config --global rerere.enabled true`
- 혹은 특정한 레포지토리에 `.git/rr-cache` 디렉토리 생성

## rerere 사용법
- rerere를 활성화한 상태에서 병합 충돌이 일어나면 `Recorded preimage for 'file'`이라고 나옴
- 병합 충돌이 일어난 상태에서 `git rerere status`를 치면 어떤 파일에 대해 pre-merge 상태를 기록했는지 나옴
- 충돌을 직접 수정하고 `git rerere diff`를 치면 어떤 resolution이 기록될지 확인할 수 있음
- `git add`를 통해 충돌이 완료됐음을 표시하고 `git commit`하면 `Recorded resolution for 'file'`이라고 나옴
- 이제 나중에 같은 파일에서 같은 충돌을 만나면 `Resolved 'file' using previous resolution`이라고 나오면서 자동으로 충돌이 해결되어있음
   - 파일을 직접 열어봐도 되고 `git diff [<file>]`로 확인해볼수도 있음
- `git checkout --conflict=merge -- file`로 충돌상황을 재현한다음에 직접 `git rerere` 하면 다시 자동으로 해결됨

## 영어 공부
- clutter up sth[클러터]: 어지르다
- back out (of sth): (하기로 했던 일에서) 빠지다
