# 10.3 Git Internals - Git References

## 관련 plumbing 명령

- `git-update-ref`: 참조에 저장된 오브젝트 이름을 안전하게 업데이트
  - `<ref> <new-oid>`: `<ref>`에 `<new-oid>`를 저장
- `git-symbolic-ref`: 심볼릭 참조를 읽거나, 쓰거나, 삭제
  - `<name>`: 읽기
  - `<name> <ref>`: 쓰기
  - `-d|--delete <name>`: 삭제

## 참조

- 참조(=refs): 간단한 이름
- `.git/refs/`에 저장
  - `.git/refs/heads/`: 브랜치
  - `.git/refs/tags/`: 태그
- 일반 참조: 단순히 가리키는 해시를 담은 파일
- 심볼릭 참조: 다른 참조를 가리키는 참조. `ref: refs/...` 형식의 파일. `refs/...` 스타일을 써야함

```bash
# main이 1a410e을 가리키게 만듦
$ git update-ref refs/heads/main 1a410efbd13591db07496601ebc7a059dd55cfe9

$ cat .git/refs/heads/main
1a410efbd13591db07496601ebc7a059dd55cfe9
```

### HEAD

- 현재 브랜치에 대한 심볼릭 참조임
- detached HEAD: 일반 참조. 태그, 커밋, 원격 브랜치를 체크아웃할 때 발생
- `git commit` 실행시, 커밋 객체를 생성하고, HEAD가 가리키는 SHA-1 값을 커밋의 부모로 지정

```bash
$ git symbolic-ref HEAD
refs/heads/main

$ git symbolic-ref HEAD refs/heads/test
$ cat .git/HEAD
ref: refs/heads/test
```

### 태그

#### 태그 객체

- 태거, 날짜, 메시지, 포인터 포함
- 트리를 가리키는 커밋 객체와 달리 보통 커밋을 가리킴

#### 태그 참조

- `refs/tags/` 아래
- 경량 태그: 커밋을 직접 가리키는 참조 생성
- 주석 태그: 태그 객체 생성 후 그 태그 객체를 가리키는 참조 생성
- 모든 객체에 태그를 지정할 수 있음

### 리모트

- `refs/remotes/` 아래
- 주로 읽기 전용으로 간주. `checkout`할 수 있지만, detached HEAD가 되므로, `commit`으로 업데이트 할 수 없음
