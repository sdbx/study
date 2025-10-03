# 7.6 Git Tools - Rewriting History

## 히스토리 재작성하기

- 기본적으로 커밋을 새로 만듦
- 이미 공유한 것을 재작성하지 않기

### 마지막 커밋 수정

- `git commit --amend`
- `--no-edit`: 이전 커밋 메시지 유지

### interactive rebase

- `git rebase -i <commit>`
- `<commit>`: 편집할 가장 오래된 커밋의 부모 커밋
- 일반적으로 `HEAD~3` 형식으로 전달
- `<commit>..HEAD` 범위의 스크립트를 편집기에서 수정
- `git log`와 반대 순서로 나타남. rebase 실행시 위에서부터 하나씩 적용
- 수정한 커밋과 그 이후의 모든 커밋을 새로 작성함

#### 커밋 메시지 수정

1. `git rebase -i HEAD~3`
2. 스크립트에서 편집할 커밋을 `pick`->`edit`로 지정
3. 명령줄에서 `git commit --amend`
4. 작업이 끝나면 `git rebase --continue`

- 2에서 수정한만큼 3~4를 반복

#### 커밋 순서 변경

- 스크립트에서 순서를 원하는 형태로 변경

#### 여러 커밋을 하나로 짜부

- 스크립트에서 짜부할 커밋을 `pick`->`squash`로 지정
- 이 커밋과 그 위 커밋이 하나로 짜부됨
- 여러 커밋을 연속적으로 짜부 가능
- 적용 후 짜부한 커밋들의 커밋 메시지를 수정할 편집기가 뜸

#### 커밋을 여러 커밋으로 나누기

1. 스크립트에서 나눌 커밋을 `pick`->`edit`로 지정
2. 명령 줄에서 커밋을 리셋 (`git reset HEAD^`)
3. 필요한만큼 커밋을 만듦 (`add`, `commit` 반복)
4. 작업이 끝나면 `git rebase --continue`

#### 커밋 제거

- `pick`->`drop`으로 변경하거나, 단순히 그 줄을 지움

#### rebase 취소

- rebase 도중 `git rebase --abort`를 하면 `rebase` 전 처음 상태로 돌아감
- 이미 rebase를 했다면 `git reflog`로 복구 (10.7장)

### 모든 커밋에 대해 특정 작업하기

- 이메일 주소를 전역적으로 변경, 모든 커밋에서 특정 파일 제거 등의 작업을 할 수 있음
- `git filter-branch`가 있으나 권장하지 않음. [git-filter-repo](https://github.com/newren/git-filter-repo) 권장
- 공개하지 않은 코드이며, 이에 기반하여 다른 사람이 작업하지 않았을 때 쓰는 것을 권장
- 일반적으로 테스트 브랜치에서 수행 후, 만족스러우면 `main`을 하드 리셋하는 것이 좋음

- `--tree-filter <명령>`: 트리에 대해 명령을 실행 후 다시 커밋
- `--all`: 모든 브랜치에서 실행
- `--subdirectory-filter <하위디렉토리>`
  - 하위 디렉토리를 프로젝트 루트로 지정
  - 하위 디렉토리에 영향을 주지 않은 커밋은 자동 제거
- `--commit-filter <명령>`: 모든 커밋에 대해 명령을 실행
  - 모든 커밋을 새로 만듦
