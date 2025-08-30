# 3.2 Git Branching - Basic Branching and Merging

## TL;DR

### 워크플로우

- 이슈: 이슈 이름의 브랜치 분기 → 작업 → 병합
- 핫픽스: main에서 분기 → 작업 → 병합(가능한 빨리)
- 고려사항
  - 병합 후 필요 없는 브랜치는 삭제 `git branch -d hotfix`
  - 병합 커밋에는 어떤 수정이 있는지, 필요하다면 왜 그렇게 했는지, 어떻게 충돌을 해결했는지 작성하는 것이 좋음

### 병합 유형

- Fast Forward
  - 병합하려는 브랜치와 브랜치의 첫번째 커밋이 같을 때
  - 포인터를 단순히 앞으로 이동
- 3-Way Merge
  - 분기가 일어난 경우
  - 공통 조상, 각 브랜치의 끝점을 이용해 병합함(그래서 3-way)
  - 새 병합 커밋을 만듦 (부모가 둘)

### 충돌 해결

- 같은 파일의 같은 부분을 서로 수정하여 깃이 자동으로 병합할 수 없을 때 발생
- standard conflict resolution marker를 남김 `<<<<<<<`, `=======`, `>>>>>>>`
- 표준 충돌 해결 표식을 수동으로 지워서 해결.
- `git mergetool` 이용도 가능

## 기본 브랜치 병합하기

main에 이미 작업한 커밋들이 있는 상태

새로운 이슈 #53을 작업하려고 함.

```bash
git switch -c iss53
```

작업(커밋)을 몇번 하면 iss53 브랜치가 앞으로 이동함.

## 즉시 수정해야하는 이슈(hotfix) 발생

→ 깃은 작업 중인 iss53을 같이 배포할 필요도, 수정 사항을 일일이 되돌릴 필요도 없음. 그냥 main으로 되돌아가면 됨.

```bash
git switch main
```

단, 워킹 트리나 스태이징 영역에 커밋하지 않은 변경사항이 체크아웃할 브랜치와 충돌을 일으킨다면 깃은 브랜치를 변경하지 않음. 이는 7.3 Stashing and Cleaning에서 배움. 당장은 문제 없다고 가정

```bash
git switch -c hotfix
vim index.html                   # 어떤 작업 
git commit -a -m "Correct a11y"
```

작업과 테스트가 끝나서 hotfix를 배포하기 위해 main으로 병합할 시점이 옴.

```bash
git switch main
git merge hotfix
```

hotfix는 main보다 직접적으로 앞서있기 때문에 fast-forward 병합이 발생.

병합된 이후에는 필요없는 브랜치는 지움.

```bash
git branch -d hotfix
# 원격에서 PR을 통해 Squash and merge했을 경우 강제 삭제 (-D)를 해야할 수도 있음
git branch -D hotfix
```

작업중이던 #53 브랜치로 이동해서 작업을 이어나감.

```bash
git switch iss53
git commit -a -m "Finish new footer. close #53"
```

hotfix 브랜치에서 작업한 내용이 여기에는 없음. 만약 이 내용이 필요하다면 main에서 iss53 브랜치로 (1) 병합하거나, (2) rebase 하거나, (3) main에 병합하기 전까지 변경사항 통합을 미룰 수 있음.

### 기본 병합

`#53` 이슈 작업이 끝나고 main에 병합하려고 함.

```bash
git switch main
git merge iss53
```

이번에는 3-Way merge가 일어남. 어떤 예전 포인트(공통 조상)에서 분기가 일어났기 때문. 깃은 3-Way merge의 결과로 새 스냅샷을 만들고, 자동으로 새 커밋을 만듦. 이를 병합 커밋이라 부르고, 둘 이상의 부모를 가짐.

병합된 이후에는 필요없는 브랜치는 지움. 이슈 트래커에서도 이슈를 닫음([GitHub 이슈 자동 닫기](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/managing-auto-closing-issues)).

```bash
git branch -d iss53
```

### 기본 병합 충돌

만약 병합시 hotfix와 iss53가 동일한 파일의 동일한 부분을 변경했다면 충돌이 일어남. 깃이 자동으로 병합할 수 없다는 의미.

충돌이 일어나면 깃은 새 병합 커밋을 만들지 않고, 충돌을 해결할 때까지 프로세스를 멈춤. 어떤 파일이 병합되지 않은지 보려면 `git status` 를 사용

깃은 충돌이 일어난 지점에 “standard conflict-resolution marker”를 삽입함. 따라서 수동으로 충돌을 해결할 수 있음.

```html
<<<<<<< HEAD:index.html
<footer>contact</footer>
=======
<div id="footer">
  please contact us
</div>
>>>>>>> iss53:index.html
```

`=======` 위는 HEAD의 버전, 아래는 iss53의 버전임.

충돌을 해결하려면 어느 한 쪽을 고르거나 직접 작성함.

```html
<footer>
  please contact us
</footer>
```

표준 충돌 해결 마커를 지우고, `git add`로 해결된 것으로 표시함.

만약 GUI로 충돌을 해결하려면 `git mergetool`을 이용.

`git status`를 다시 해서 모든 충돌이 해결되고 staged된 것을 확인함. 확인 되었다면 `git commit`으로 병합 커밋을 만듦. 만약 미래에 다른 사람이 필요한 정보를 담아야한다면, 충돌을 어떻게 해결했는지, 수정 사항이 모호하다면 왜 그렇게 했는지 적는 것이 좋음.
