# 7.10 깃으로 디버깅하기

## 학습목표
- `git blame`이 무엇인지, 어떻게 사용하는지 숙지한다.
- `git bisect`가 무엇인지, 어떻게 사용하는지 숙지한다.

## git blame
- 임의의 파일에서 어떤 커밋이 어떤 줄을 마지막으로 편집했는지 보여주는 명령어이다.
- 언제 왜 이 버그가 생겼는지 파악하는데 도움이 된다.
- `-L <start>,<end>` 또는 `-L :<funcname>` 으로 범위를 제한할 수 있다.
- 출력되는 필드 순서 => `부분 SHA (저자명 작성일 줄번호) 줄내용`
- `^`로 시작하는 sha가 있는 줄은 이 저장소의 최초 커밋에서 도입되었고 아직도 바뀌지 않았음을 나타냄
- 예전에도 언급된 것이지만 깃은 파일명의 변경을 명시적으로 추적하지 않음.
   - 스냅샷을 기록하고 나서 무엇의 이름이 변경되었는지 사후에 암시적으로 알아냄
- `-C` 옵션을 주면 코드의 어떤 부분이 다른 파일로부터 왔는지 볼 수 있음

## git bisect
- 무엇이 어디서 잘못되었는지 찾아내는데 도움이 되는 명령어
- 커밋 이력에서 이진탐색을 수행
- 자동화 스크립트로 bisect를 자동화 가능

```bash
# 탐색 시작
$ git bisect start

# 현재 커밋에 문제가 있음을 알려주기
$ git bisect bad

# 마지막으로 알고 있는 문제가 없는 커밋 알려주기
$ git bisect good <good-commit>

# 이후 현재 커밋에 문제가 없다면
$ git bisect good
# 문제가 있다면
$ git bisect bad

# 탐색이 끝났다면 아래를 입력해 HEAD를 bisect를 시작하기 전으로 초기화하기
$ git bisect reset
```

```bash
# 테스트 스크립트를 이용해 bisect 자동화하기
# test-script는 쉘 스크립트나 `make` 등이 될 수 있음
# test-script는 good일때 0으로 exit하고 bad일때 non-0으로 exit해야 함
$ git bisect start <bad-commit> <good-commit>
$ git bisect run <test-script>
```

## 영어 공부
- culprit[컬프릿]: 범인
- annotate[애너테이트]: 주석을 달다
- track sb/sth down: ~을 찾아내다
- tad[태드]: (비격식) 조금
- designate[데지그네이트]: (특정한 기호로) 표기하다
