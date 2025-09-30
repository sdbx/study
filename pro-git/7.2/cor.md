# 7.2 인터랙티브 스테이징

## 학습목표
- interactive한 방식으로 커밋을 만드는 방법을 배운다.

## 개요
- 인터랙티브 명령을 사용하면 원하는 파일들만을 혹은 원하는 파일의 부분만을 포함하는 커밋을 제작할 수 있다.
- 다수의 파일을 작업한 뒤 기능별로 나눠서 커밋할 수 있다.

## git add --interactive | -i
```bash
*** Commands ***
  1: status       2: update       3: revert       4: add untracked
  5: patch        6: diff         7: quit         8: help
What now>
```
- 하고자 하는 작업을 선택한 후 엔터를 누른다.
- 작업을 다 마쳤으면 아무것도 치지 않은 채 엔터를 누른다.

## 부분적으로 파일 작업하기
- partial stage
   - `git add -i`의 `5: patch`
   - `git add --patch | -p`
   - 각 hunk에 대해 어떻게 할 것인지 선택 가능
   - `?` 입력하면 도움말 나옴
- partial unstage
   - `git reset -p`
- partial discard
   - `git checkout -p`
   - `git restore -p`
- partial stash
   - `git stash push -p`
   - (deprecated) `git stash save -p`

## 영어 공부
- succinct[석싱트]: (호감) 간결한
- informative[인폴머티브]: 유용한 정보를 주는
- hunk[헝크]: (특히 음식을 큰 것에서 분리해 낸) 덩이/조각