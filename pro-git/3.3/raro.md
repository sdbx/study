# 3.3 Git Branching - Branch Management

## 브랜치 관리 도구

### 브랜치 보기

```bash
$ git branch
  iss53
* main        # HEAD가 가리키는 브랜치
  testing
```

### 브랜치 자세히 보기

```bash
$ git branch -v
  iss53   93b412c Fix javascript issue
* main    7a98805 Merge branch 'iss53'
  testing 782fd34 Add scott to the author list in the readme
```

### 병합된 브랜치 보기

```bash
# 현재 브랜치에 병합이 된 브랜치만
$ git branch --merged
  iss53
* main   # 현재 브랜치도 보임

# 현재 브랜치에 병합이 안 된 브랜치만
$ git branch --no-merged
  testing

# 기준 브랜치 명시 가능(다른 브랜치에 있을 때 유용)
$ git branch --merged main
```

병합된 브랜치는 `git branch -d`로 제거 가능

병합되지 않은 브랜치는 `git branch -D`로 강제 제거 가능

### 브랜치 이름 바꾸기

다른 작업자가 사용할 수 있는 브랜치는 이름을 바꾸지 마세요.

```bash
# 로컬 브랜치 이름 바꾸기
$ git branch --move bad-branch-name corrected-branch-name

# 원격 브랜치 이름 반영
$ git push --set-upstream origin corrected-branch-name # 새 이름 올리기
$ git push origin --delete bad-branch-name             # 기존 이름 삭제
```

### 주 브랜치 이름 바꾸기

주 브랜치 이름을 바꾸는 것은 통합, 서비스, 각종 유틸, 빌드 스크립트 등이 동작하지 않게 만들 수 있다. 반드시 동료와 상담하고, 관련 코드와 스크립트를 모두 수정해야한다.

```bash
$ git branch -m master main
$ git branch --set-upstream origin main
```

원격 저장소의 브랜치를 삭제하기 전에:

- 이와 연관된 프로젝트의 수정해야하는 코드나 설정 수정
- 테스트 러너 설정 파일 수정
- 빌드나 릴리즈 스크립트 조정
- 레포의 기본 브랜치, 병합 규칙, 등 브랜치 이름과 연관된 설정 수정
- 문서에 있는 예전 브랜치 이름 참조 수정
- 예전 브랜치를 가리키는 PR을 병합하거나 닫음

모든 작업이 끝나고 변경할 준비가 되었다면 원격 저장소에서 예전 이름을 삭제함:

```bash
$ git push origin --delete master
```
