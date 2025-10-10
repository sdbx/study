# 7.11 서브모듈

## 학습목표
- submodule의 개념과 사용법을 이해한다.

## 개요
- "프로젝트 A에서 작업중인데 프로젝트 B를 A 내에서 사용하고 싶다."
- A와 B를 별도로 취급하면서도 B를 A 내에서 사용할 수 있는 방법이 없는가?
- 이러한 문제를 git은 submodule을 통해 해결한다.
- 깃 저장소가 다른 깃 저장소의 subdirectory에 위치하는 것으로 보인다.

## 서브모듈 사용법
### 추가
- 서브모듈을 가지는 프로젝트를 superproject라고 하는 듯함
- `git submodule add -- <url> [<path>]`
- `.gitmodules` 파일
   - 환경설정 파일
   - 서브모듈로 가져온 프로젝트의 url과 local subdirectory 사이의 mapping을 보관
   - 버전관리되는 파일임
      - 그래야 본 프로젝트를 clone한 사람이 submodule을 어디서 가져오는지 알수있음
      - 가능하다면 다른사람들도 접근할수있는 url을 사용할것
      - 개인적 사용을 위해 이 값을 지역적으로 덮어쓸수 있음
      - `git config submodule.<name>.url <private-url>`
- 서브모듈이 내 작업영역의 서브디렉토리이긴 하지만, 깃은 내가 그 디렉토리 내에 있지 않으면 서브모듈의 내용을 추적하지 않음
- `git diff --cached --submodule`
- `mode 160000` => git에서의 특별한 mode로, 그 뜻은 커밋을 서브디렉토리나 파일이 아니라 디렉토리로서 기록한다는 것임
- `git push`로 서브모듈 추가 작업이 마무리된다.

### 서브모듈을 가지고 있는 프로젝트 clone하기
- 기본적으로, 서브모듈에 해당하는 디렉토리는 있으나 텅 비어있음
- 메인 프로젝트에서 2가지 명령을 실행해야 함
   - `git submodule init` => local config 파일을 초기화하기 위해서
   - `git submodule update` => 서브모듈의 데이터를 fetch해오고 superproject의 리스트에 언급된 commit을 checkout하기 위해서
- 두 명령을 하나로 합칠 수도 있는 듯 => `git submodule update --init`
- 위 방법보다 더 간편한 방법이 있음
- 그건 바로 `git clone` 할 때 아예 `--recurse-submodules` 옵션을 명시하는 것임
- 이러면 레포지토리에 포함된 서브모듈 뿐만 아니라, 중첩된 서브모듈, 즉 서브모듈 내에 포함된 서브모듈도 알아서 초기화 및 갱신됨
- 클론할때 저 옵션 주는걸 깜빡했다면, `git submodule update --init --recursive` 명령을 주면 됨

## 서브모듈을 가진 프로젝트에서 작업하기
### 서브모듈의 원격에서 변경사항 내려받기
- 서브모듈을 사용만 하지 수정은 하지 않음
- 내려받는 방법
   - 서브모듈의 디렉토리에 가서 `git fetch` `git merge`
   - 좀 더 쉽게 하기 (모든 서브모듈 갱신) => `git submodule update --remote`
      - 이 명령어는 기본적으로 원격 서브모듈 저장소의 기본브랜치(=원격지의 HEAD가 가리키는)로 checkout을 update함
      - 다른 브랜치를 track하고 싶으면...
         - `.gitmodules` 파일 바꾸기 (다른사람들에게도 적용됨)
            - `git config -f .gitmodules submodule.<name>.branch <branch>`
            - `-f <config-file>`: .gitconfig가 아니라 명시된 파일에 쓰기
         - `.git/config` 파일 바꾸기 (로컬) => 위 명령어에서 `-f .gitmodules` 옵션 생략하기
- 내려받은 것 확인
   - `git diff --submodule` 혹은 `git config --global diff.submodule log` 후 `git diff`
   - `git status`
      - 좀 더 자세히 보기 => `git config status.submodulesummary 1`
   - (내려받은 것 커밋 후에 확인) `git log -p --submodule`
- 내려받은 후 커밋하기 => 다른사람이 update할때 서브모듈이 새로운 코드를 가지도록 lock하는 효과

### superproject의 원격에서 변경사항 내려받기
- `git pull` 만 하는 것은 불충분함
   - 재귀적으로 서브모듈의 변경사항을 fetch하기는 하지만, 서브모듈을 update하지는 않음
   - `git status`를 찍어보면 new commit들이 `<`로 나타나 있는데 이는 이 커밋들이 superproject에는 있으나 local submodule의 checkout에는 없다는 뜻
- 따라서 `git submodule update --init --recursive`까지 해야 갱신 작업이 끝나게 됨
   - `--init`하는 이유: 내가 방금 내려받은 superproject의 커밋에서 새로운 서브모듈이 추가되었을 수 있으므로
   - `--recursive`하는 이유: 중첩된 서브모듈 대비
- 위 작업을 더 간편하게 하려면...
   - `git pull --recurse-submodules`
   - `--recurse-submodules` 옵션을 지원하는 모든 명령어에서 자동으로 이 옵션 쓰게 하기
      - `submodule.recurse`를 `true`로 설정
      - git clone은 제외임

### 서브모듈 갱신에 실패할 수도 있음
superproject를 pull했는데 내려받은 커밋 중에서 .gitmodules 파일 내 서브모듈의 url을 변경한 커밋이 있다고 하자. 이런 경우에 superproject가 내 레포지토리에서 지역적으로 환경설정된 서브모듈 원격지에서 찾을 수 없는 서브모듈 커밋을 reference한다면 `git pull --recurse-submodules` 혹은 `git submodule update`가 실패할 수 있다. 이 문제를 바로잡으려면 `git submodule sync --recursive`로 새로운 url을 복사한 후 `git submodule update --init --recursive`를 통해 재갱신하면 된다.

### 서브모듈에서 작업하기
- superproject에서 작업하면서 동시에 submodule에서도 작업 가능
- `git submodule update`를 하면 갱신은 되지만 서브모듈은 **detached HEAD** 상태에 놓임
- detached HEAD 상태 = 변경사항을 track하는 local working branch가 없다 = 서브모듈에 커밋을 해도 다음번 `update`에 잃어버릴지도 모름
- 따라서, 서브모듈에서 작업하려면 아래와 같이 해야 함
   - 서브모듈에 가서 (`cd <submodule>/`) 작업할 브랜치로 이동함 (`git checkout <branch>`)
   - (superproject에서) `git submodule update --remote (--merge|--rebase)`
      - merge 혹은 rebase 옵션 지정을 안하면 그냥 업데이트되고 detached HEAD 상태로 됨
      - 설령 그렇게 되었다 할지라도 다시 그 브랜치로 가서 `origin/<branch>`로 직접 merge나 rebase 하면 그만임
- 커밋하지 않은 상태에서 `update`를 하면 fetch는 되지만 에러가 나면서 overwrite는 되지 않음
- upstream과 충돌나는 변경사항을 만든 뒤 `update`를 하면 병합충돌이 나며, 해당 서브모듈 디렉토리에 들어가서 병합충돌을 해결하면 된다.

### 서브모듈의 변경사항 푸시하기
- 메인 프로젝트만 push하면 안되고 서브모듈에 있는 변경사항도 같이 push해야함
- 그렇지 않으면 메인프로젝트가 의존하는 서브모듈의 변경사항을 다른 사람이 얻을 방법이 없기 때문
- 메인 프로젝트를 push하기 이전에 모든 서브모듈들이 적절히 push되었는지 검사해야 함
- `git push --recurse-submodules=(check|on-demand)`
   - `check`로 지정하면 서브모듈에 있는 커밋된 변경사항이 push되지 않았을 경우 push가 실패함
   - `on-demand`로 지정하면 알아서 모든걸 push해 줌 (특정 이유로 서브모듈 push가 실패시 메인 push도 실패)
- 특정 옵션을 기본값으로 지정하려면 `git config push.recurseSubmodules <check|on-demand>`

### 서브모듈의 변경사항 병합하기
(상황 1) fast-forward 상황이면 문제 없음

(상황 2-A) 이력이 분기되었다면 아래와 같이 해결 가능
- 그런데 서브모듈의 커밋이력이 분기되었으면 충돌이 남
- 이 문제를 해결하려면 우선 `git diff`를 통해 충돌난 두 커밋의 sha-1을 얻어야 함 (좌측이 우리쪽에 있는 커밋이고 우측이 upstream의 커밋)
- 서브모듈 디렉토리 내로 이동(cd)후 `git branch <try-to-merge-in> <sha1-of-upstream>`
- `git merge <try-to-merge-in>` 이후 충돌을 해결하고 add 및 commit
- 본 프로젝트로 돌아와서 `git add <submodule>` 이후 commit

(상황 2-B) 이력이 분기되었는데 이미 이 충돌을 해결하는 머지커밋이 있을 수도 있음
- `git update-index --cacheinfo ...` 는 비권장이라고 함
- 대신 직접 해당 서브모듈로 cd한 뒤 merge해서 fast-foward시킨뒤 다시 본 프로젝트로 와서 서브모듈 add후 commit하는 것이 추천됨
   - 이렇게 하면 해당 코드를 서브모듈 내에서 직접 검증해볼수 있기 때문인 것으로 이해됨
   - 잘은 모르겠지만 git pull만 하면 서브디렉토리의 내용이 fetch는 되나 update는 되지 않는다고 했으니까 그 때문인 듯

## 서브모듈 사용 요령
### 일괄적으로 각 서브모듈에서 특정 명령 수행하기
- `git submodule foreach <command>`
- 응용 예시: `git diff; git submodule foreach 'git diff'`

### alias를 사용하자
서브모듈 관련 명령어는 길기 때문에 alias 활용하면 좋음

## 서브모듈 사용시 주의할 점
### 브랜치 전환
- 이전 버전의 깃에서는 서브모듈을 추가한 브랜치와 그렇지 않은 브랜치간 전환에 불편함이 있었던 듯
- 2.13 버전 이후로는 `git checkout --recurse-submodules` 하면 됨
- 위에서 언급된대로 gitconfig에 recurse-submodules 옵션을 지원하는 명령어에서는 항상 이 옵션을 사용하도록 할 수 있음 (clone 제외)

### 서브디렉토리에서 서브모듈로 전환
- `git rm -r <subdirectory>`로 인덱스에서도 지워야 `git submodule add`가 되는 듯
- 만약 별도의 브랜치에서 방금 말한 작업을 한 뒤 메인으로 갈때, 그리고 메인에서 다시 이 브랜치로 올때 이슈가 있음 => `checkout -f` (저장하지 않은 내역 날라가므로 주의) 와 `checkout .`로 해결 가능한 듯

## 요약
- 서브모듈을 통해 메인프로젝트에서 서브프로젝트(들)의 내용을 사용하면서 서브프로젝트 또한 동시에 개발할 수 있음
- 다만 사용이 다소 복잡해보이나 최근 버전의 깃에서 도입된 --recurse-submodules 옵션을 사용하면 머리아픈 일이 별로 없을 것 같기도 함
- 최근 버전에서의 서브모듈은 모든 데이터를 top project의 .git 디렉토리에 저장하므로 서브모듈의 디렉토리를 삭제해도 커밋이나 브랜치를 잃지는 않을 것이라고 함

## 영어 공부
- list: 리스트에 언급하다[포함시키다]
- leave off: 어떤 활동을 중단하다; 명단에서 누군가/무언가를 포함시키지 않다
- remedy[레머디]: (문제를) 바로잡다
- caveat[캐비애트]: (특정 절차를 따르라는) 경고 (라틴어로 let a person beware라는 뜻이라는 듯)
- simultaneous[사이믈테이니어스]: 동시의
