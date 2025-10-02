# 7.5 탐색

## 학습목표
- git grep: 특정 문자열의 위치 찾기
- git log: 특정 문자열이 도입된/존재했던 시점 찾기

## 개요
- 어디서 이 함수가 호출/정의되는가?
- 이 메서드의 history는 어떻게 되는가?
- 이러한 궁금증을 해결하기 위한 방법을 알아본다.

## git grep
- committed tree, working directory, index에서 문자열이나 정규표현식을 탐색 가능
- 기본적으로는 작업영역 내 파일을 탐색
- 통상적인 탐색 명령어인 grep과 ack에 대해 가지는 이점은 작업영역뿐만 아니라 임의의 tree에 대해 탐색할 수 있다는 것임.

```bash
# <string>과 일치하는 문자열이 있는 파일 출력
git grep <string> [--] [<pathspec>...]

# 줄 번호까지 같이 출력
git grep -n|--line-number <string>

# <string>이 파일별로 몇 번 등장하는지 출력
git grep -c|--count <string>

# <string>이 등장하는 맥락도 같이 출력
# 함수명이 계산되는 방식을 직접 지정할 수도 있는 것 같음 (매뉴얼 참고)
git grep -p|--show-function

# 패턴 지정
git grep -e <pattern>
git grep --and, --or, --not, ( ... )
## 예시: #define을 가지고 있으면서 동시에 _H나 _NAME을 가지고 있는 줄 출력
git grep -e '#define' --and \( -e _H -e _NAME \)

# 탐색할 특정 tree 지정
git grep ... <tree>

# 파일간 공백줄 출력
git grep --break

# 파일명을 별도의 줄에 출력
git grep --heading
```

## git log
- git grep은 어떤 문자열이 **어디에** 있는지를 찾아주는데 도움이 되었음
- git log는 언제 어떤 문자열이 존재했는지 혹은 도입되었는지를 알아보는데 도움이 됨

```bash
# 파일 내에서 string의 "등장횟수"를 변경시킨 (즉, 추가/삭제) difference를 찾음
# --pickaxe-regex 옵션을 주면 string을 extended POSIX regular expression으로 취급함
git log -S<string> [--pickaxe-regex]

# regex와 일치하는 추가/삭제된 줄을 포함하고 있는 patch text를 가진 difference를 찾음
git log -G<regex>

# file내에서 function name에 의해 주어진 line range의 변화를 추적함
# git이 내가 사용하고 있는 언어의 함수를 match할 수 없으면 regex를 제공할수도 있음
git log -L:<funcname>:<file>
# file내에서 start와 end에 의해 주어진 line range의 변화를 추적함
# 숫자가 하나만 주어지면 해당 줄 아래로 파일 끝까지 출력되는듯
git log -L<start>,<end>:<file>
```

## 영어 공부
- plethora[플래서러]: 과다, 과잉(excess)
- work sth out: ~을 계산하다