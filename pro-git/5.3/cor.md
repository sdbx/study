# 5.3 프로젝트 관리하기

## 학습목표
- 프로젝트를 관리하는데 필요한 지식을 배운다.
   - 패치를 받고 적용하는 방법
   - 원격 브랜치에 있는 작업 통합하기

## 토픽 브랜치에서 작업하기
- 새로운 작업을 통합하기 전에 먼저 시험해보는 용도
- 시도해보려는 작업의 주제에 어울리도록 브랜치 작명
- 브랜치명을 namespace하는 경향이 있음
   - 예: <contributor-name>/<branch-name>
- 해당 브랜치로 switch 후 기여된 작업을 add한다.
- 테스트 후 이 작업을 long-term 브랜치에 합칠지 결정한다.

## 이메일로 온 패치 적용하기
- 패치가 이메일로 왔다면, 토픽 브랜치에 해당 패치를 적용하여 평가해야 한다. 통합을 할 것인지? 통합할 거라면 long-term 브랜치로 어떻게 통합할 것인지?
- 두가지 방법 => `git apply` 혹은 `git am`

### git apply
- `git diff` 혹은 `diff` 명령어로 생성된 패치파일을 적용할 때 사용
   - 이렇게 패치파일을 만드는 것은 권장되지 않는다고 함
- 구문 => `git apply <path-to-patch-file>`
- 작업영역을 변경함
- `patch -p1`과 거의 동일하나 차이점이 있음.
   - `-p<num>` 옵션을 주면 패치파일내 파일명에서 num개의 leading slash를 제거함
   - `-p1`을 사용하는 이유는 `git diff`가 파일명 앞에 a/와 b/를 붙이기 때문이라고 함
   - fuzzy라는 단어는 fuzz factor와 관련있는 것 같은데, 패치파일상의 줄 번호가 잘못됐을 때 스캔할때 사용되는 어떤 값인 것으로 추정됨
- `git apply`는 `patch`에 비해:
   - 좀 더 편집증적이고 더 적은 fuzzy match를 받아들인다고 함
   - git diff 형식에서 파일 추가, 제거, 이름 변경이 나와있다면 handle한다고 함
   - "모든 걸 적용하거나 모든 걸 중단하거나" 모델을 따름
   - 즉, patch보다 보수적임
- 이 명령어를 실행 후 직접 stage 및 commit해야 함.
- 실제로 적용하기 전에 패치가 깨끗하게 적용되는지 확인하고 싶어요 => `git apply --check <patchfile>`
   - 쳤는데 아무 출력도 안나와요 = 패치 정상 적용됨
   - check가 실패하면 오류메시지와 함께 non-zero status로 exit됨 => 스크립트에서 활용 가능

### git am
- `git format-patch`로 생성된 패치를 적용할 때 사용
   - 이 패치파일은 author와 commit message를 포함하고 있음
   - 따라서 패치파일 생성시 format-patch를 사용하는 편이 권장됨
- am = apply a series of patches from a mailbox
- 이 명령어는 mbox 파일을 읽도록 개발되었으며, format-patch에 의해 생성된 파일도 유효한 mbox email format임
- 패치파일을 다운 후 `git am <patchfile>` 실행
- 자동적으로 커밋 생성됨
- 적용 실패시 resolve/skip/abort 가능
   - resolve하려면 conflict를 해결하고 git add <file>을 통해 stage한 후 git am --resolved해야 함
- `-3` 옵션을 줄 시, 패치가 충돌로 인해 적용이 되지 않을 경우 이 패치가 기반으로 하는 커밋이 내 레포지토리에 있다면 three-way merge를 시도함
- `-i` 옵션을 주면 interactive mode로 실행되어서 각 패치에서 정지된 후 적용할지의 여부를 물어봄

## 원격 브랜치 checkout하기
- pull request 방식의 기여
- 기여자는 메인테이너에게 자신의 레포지토리 URL과 브랜치명을 알려줌
- 메인테이너는 그 레포지토리를 remote로 추가하고 해당 브랜치로 checkout하고 locally merge한다.
- 한명의 사람과 지속적으로 작업할 경우에 유용
- 다수와 작업하는 경우에도 스크립트나 호스팅 사이트를 사용하면 번거로움을 덜 수 있음 => 나와 기여자가 어떻게 작업하느냐에 따라 달림
- 커밋 이력을 가진다는 것도 장점임
- 일회성으로 해당 레포지토리에서 pull하고 싶으면 remote로 등록하는 대신 git pull <url> 가능

## 무엇이 도입됐는지 알아보기
- 기여된 작업이 들어있는 토픽 브랜치를 메인 브랜치에 병합하면 무엇이 도입되는지 알아보고 싶다
- 토픽 브랜치에는 있지만 마스터 브랜치에는 없는 모든 커밋을 보기
   - `git log topic --not master`
   - `git log master..topic`
   - git log에 -p 옵션 주면 해당 커밋에서 도입된 변경사항 확인 가능 (2장 3절 참고)
- topic을 master에 병합했을 때 발생할 전체 diff 보기
   - topic 브랜치의 마지막 커밋과 master 브랜치와의 common ancestor 사이의 diff 계산
   - `git diff $(git merge-base topic master)`
   - triple-dot syntax => `git diff master...topic` => 유용하니까 기억하세요

## 기여된 작업 통합하기
어떻게 통합할 것인가가 관건이다.

### 그냥 합치기
- 모든 작업을 그냥 바로 master에 병합하기
- 그리고 나서 방금 병합된 topic 브랜치 삭제하기
- 이 방식은 단순하지만 그냥 바로 master에 병합하기 때문에 안정적인 측면에서 문제의 소지가 있을 수 있음

### 2단계 병합
- two-phase merge cycle
- 3장 4절에서 설명해준 내용과 연관 있는 듯함
- long-running 브랜치인 master와 develop 존재
- 매우 안정적인 릴리즈가 제작되었고, 모든 새로운 코드가 develop 브랜치에 병합되었을 때만 master 브랜치를 갱신
- 정기적으로 master와 develop 브랜치를 공개 레포지토리에 push
- 병합할 topic 브랜치가 생길 때마다 develop 브랜치에 병합
- 릴리즈에 tag할 때 master를 develop이 있는 곳으로 fast-forward
- 이 방식을 사용하면, 안정적인 버전은 master에서, 가장 최신의 내용은 develop에서 checkout할 수 있다.
- 이 방식을 확장해서 master, develop, integrate의 세 브랜치를 사용 가능
   - 모든 작업은 integrate에서 병합됨
   - integrate의 codebase가 안정적이고 테스트를 통과하면 develop으로 병합
   - develop이 안정적인 것으로 증명되면 master를 fast-forward

### git 프로젝트의 경우
- 4개의 long-running 브랜치: master, next, seen, maint
   - maint 브랜치는 지난 릴리즈에서 분기되는 브랜치이며 maintenance release가 필요한 경우 backport 패치를 제공하기 위함임
   - seen의 이전 이름은 pu (proposed updates)
- 기여자가 도입한 작업은 메인테이너의 레포지토리 내에서 토픽 브랜치 내로 수집됨
- 그 후 해당 작업물은 점검되어 안전한지 혹은 좀 더 작업이 필요한지 결정됨
- 안전하면 next로 병합됨.
- 좀 더 작업이 필요하면 seen으로 병합됨.
- 작업들이 완전히 안정적인 것으로 판명되면 해당 작업들은 master로 재병합됨
- 이후 next와 seen은 master에서 재생성됨
- master는 일반적으로 앞으로 전진, next는 때때로 리베이스됨, seen은 더 자주 리베이스됨
- 토픽브랜치가 master에 병합되면 해당 브랜치는 삭제됨

### 리베이스와 체리픽
- 리베이스와 체리픽을 사용해 기여된 작업을 master (혹은 develop 등) 위에 합치고 master 브랜치 fast-forward 시키기
- 선형적인 커밋 이력
- 체리픽
   - 하나의 커밋에 대한 리베이스 같은 것
   - 특정 커밋에서 도입된 패치를 내가 현재 위치한 브랜치 위에 재적용 시도
   - 여러 개의 커밋 중 하나만 취하고 싶을 때
   - 토픽 브랜치에 커밋이 하나만 있는데 리베이스를 쓰기는 싫을 때
   - SHA-1 해시값 바뀜 (date가 달라졌기 때문에)

### rerere
- reuse recorded resolution
- conflict 해결을 도와주는 도구
- 활성화되어 있다면, 성공적으로 merge를 했을때 사전이미지, 사후이미지를 기억
- 만약 다음번에 같은 충돌이 있다면 지난번의 해결책을 사용
- `git config --global rerere.enabled true`
- `git rerere`
   - 단독으로 사용하면 해결책 db를 확인 후 현재의 merge conflict와 일치하는 것이 있는지 검색, resolve를 시도 <= enabled true면 자동으로 됨
   - 무엇이 record될 것인지, 캐시에서 특정 resolution 지우기, 전체 캐시 지우기를 위한 subcommand 존재

## 릴리즈에 태그 붙이기
- 2장 6절에서 배운 대로 태그 붙이기 가능
- `-s` 옵션을 주어 태그에 sign 가능
- 태그를 sign하는데 사용한 공개 pgp 키를 배포하는 방법
   - 공개키를 레포지토리에 blob으로 포함시키기
   - 해당 blob을 직접 가리키는 tag 추가
   - `gpg --list-keys`로 추가하려는 키 확인
   - `gpg -a --export <key> | git hash-object -w --stdin` => 키의 내용으로 새로운 blob을 생성 후 해당 blob의 SHA-1 반환
   - `git tag -a maintainer-pgp-pub <key-blob-sha1>`
   - `git push --tags`
   - `git show maintainer-pgp-pub | gpg --import` => 키를 import해 signed tag를 검증 가능
- 태그에 tag 검증에 대한 절차를 메시지로 적어두면 git show를 한 사람에게 정보를 제공할 수 있음

## 빌드 숫자 생성하기
- `git describe`를 사용하여 특정 커밋을 나타내는 이름 만들기 가능 (human-readable name)
- 반환값 => `<이 커밋 이전의 최신 태그>-<해당 태그 이후로의 커밋 수>-g<이 커밋의 SHA-1값 일부>`
   - g는 git을 의미
- 기본적으로 annotated 태그가 필요하나 lightweight 태그를 사용하려면 `--tags` 옵션 명시

## 릴리즈 준비하기
```
# 최신 스냅샷의 archive 생성하기
git archive master --prefix='project/' | gzip > `git describe master`.tar.gz

# zip파일로
git archive master --prefix='project/' --format=zip > `git describe master`.zip
```

## shortlog
- 마지막 릴리즈 이후로 무엇이 추가되었는지(changelog)를 얻는 방법
- `git shortlog`
   - 커밋 범위 내의 모든 커밋을 요약
   - author별로 커밋들이 group됨
   - 예시: `git shortlog --no-merges master --not v1.0.1` => v1.0.1 이후의 커밋들에 대한 요약
- 이 내용을 이메일로 보내거나 해서 변경사항을 알릴 수 있음

## 영어 공부
- legitimate: 합법적인, 합리적인
- determine: 알아내다, 밝히다
- cut: 음반 등을 녹음[제작]하다
- backport: 현재 버전에 대해 제작된 소프트웨어 업데이트를 그 소프트웨어의 예전 버전으로 포팅하는 절차
- vet: 점검하다