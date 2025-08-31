# 3.3 브랜치 관리

## 학습목표
- 브랜치 관리하는 방법 이해하기
   - 나열하기
   - 병합 여부 확인하기
   - 삭제하기
   - 이름 변경하기

## 브랜치 관리 명령어
`*` 이 앞에 붙은 브랜치는 내가 지금 위치한 브랜치 => 즉 HEAD가 가리키고 있는 브랜치
### 브랜치 열거
- `git branch` => 현재 브랜치 목록
- `git branch -v` => 각 브랜치의 마지막 커밋도 같이 출력하기. `--verbose` 로도 된다.
- `git branch --all` => 로컬 브랜치와 원격추적브랜치를 모두 열거한다. `-a` 로도 되며, `--list` (혹은 `-l`) 를 추가적으로 사용해 패턴매칭도 된다.
### 브랜치 병합 여부 확인
- `git branch --merged` => **현재 위치한 브랜치**에 병합된 브랜치 목록 출력. 여기에 나와있는 브랜치는 일반적으로 지워도 무방.
- `git branch --merged branchName` => branchName 브랜치와 병합된 브랜치 목록 출력
- `git branch --no-merged` => **현재 위치한 브랜치**에 병합되지 않은 브랜치 목록 출력. 여기에 나와있는 브랜치를 `-d`로 지우려고 하면 실패함. 진짜 지우려면 `-D` 사용.
- `git branch --no-merged branchName` => branchnName 브랜치와 병합되지 않은 브랜치 목록 출력
### 브랜치 이름 변경
**다른 사람이 쓰고 있는 브랜치의 이름을 바꾸지 말 것!!**
- `git branch --move oldname newname` => 로컬 브랜치의 이름을 바꾼다. `-m` 으로 써도 된다.
- `git push --set-upstream origin newname` => 브랜치를 푸시한다. `--set-upstream` 이 정확히 뭘 하는건진 모르겠는데 원격 브랜치를 track하게 하는 것 같다. 매뉴얼에 따르면 이 옵션 대신 `--track` (혹은 `-t`) 이나 `--set-upstream-to` (혹은 `-u`) 를 쓰라고 한다.
- `git push origin --delete oldname` => 원격에서 이전에 사용하던 브랜치명을 지운다.

## 주의해야 할 브랜치
위에서 언급한 브랜치 이름 변경법과 다른 점은 없는 것 같다. 단, **master/main/mainline/default** 같은 이름의 브랜치를 함부로 바꾸는 것은 안된다. 왜냐하면, 해당 레포지토리가 쓰고 있는 빌드/릴리즈 스크립트나 헬퍼 유틸리티, 통합, 서비스의 작동에 영향을 미칠 수 있기 때문이다. 만약 이런 브랜치명을 변경하려면 먼저 다른 협업자들과 상의해야 하며, 또 완전히 바꾸기 위해서 여러가지 작업을 해야 한다고 한다.

## 영어 공부
- now (that)... = used to give an explanation of a new situation
- come in handy = (infml.) turn out to be useful. (Ex.) the sort of junk that might come in handy one day.
- consult = 상담하다, 찾아보다. to get information or advice from a person, book, etc. with special knowledge on a particular subject.
- consult with = 상의하다. to discuss something with someone before you make a decision.
- as in = for example. 예시를 들 때 사용하는 말인 듯.