# 2.5 원격 레포지토리

## 학습목표
- `git remote [-v]`
- `git remote add <name> <url>`
- `git remote show <name>`
- `git remote rename <old> <new>`
- `git remote remove <name>`

## 메모
협업을 하려면 원격 레포지토리와 소통하는 방법을 알아야 함.

원격 레포지토리는 **보통 read-only이나 read/write일수도** 있음.

다른 사람과 협업을 한다는 것은 무엇을 의미할까?

- 원격 레포지토리 관리하기
    - 원격 레포지토리 등록하는 법
    - 더 이상 유효하지 않은 원격 레포지토리 제거하는 법
    - **다양한 원격 브랜치 관리하는 법**
    - **원격 브랜치를 track되고 있는 브랜치 혹은 그렇지 않은 브랜치로 정의하는 법**
- 원격 레포지토리에 데이터 push하기
- 원격 레포지토리로부터 데이터 pull해오기

**“원격”이라고 해서 인터넷 혹은 네트워크 어딘가에 있다는 말은 아님. 즉, 나와 같은 호스트(장치?)에 있을수도 있음.**

**`git remote`** 를 하면 원격에 위치한 레포지토리를 칭하는 **별명**이 나옴 **(origin이 기본값)**

**`git remote -v`** 를 하면 별명에 더불어 **해당 별명에 대한 URL**도 같이 나옴

**`git remote add shortname url`** 을 하면 원격 레포지토리를 **명시적으로 등록**할 수 있음.

원격 레포지토리를 등록한 후 **`git fetch** shortname` 을 하면, **해당 레포지토리에는 있지만 내 레포지토리에는 없는 내용**을 받아옴. 그리고 나면 해당 레포지토리에 있는 브랜치를 **로컬에서 접근**할 수 있음 (**`shortname/branchname`** 같은 식으로)

**`git fetch remote`** 를 하면 **새로운 데이터를 다운로드하기만 할 뿐** 자동으로 내 레포지토리에 합치거나 내 작업물을 수정하거나 하지 않음. 내가 그럴 준비가 되면 직접 해야 함.

**만약 현재 브랜치가 원격 브랜치를 track하도록 설정되어 있다면, `git pull` 을 하면 자동적으로 fetch될 뿐만 아니라 해당 원격 브랜치가 내 브랜치로 merge된다.**

참고: 깃 버전 2.27.0부터 `.gitconfig` 에 `pull.rebase` 변수가 설정되어있지 않으면 오류가 나온다고 함.

**`git push remote branch`** 를 하면 로컬에 있는 커밋을 원격에 올릴 수 있다. 단, 해당 원격 레포지토리에 write 권한이 있어야 하고, 내가 푸쉬하기 이전에 다른 사람이 먼저 푸쉬했으면 **푸쉬가 거절**된다. 이런 경우 fetch해서 그 사람의 작업물을 내 작업물에 포함시켜야 함.

**`git remote show remotename`** 을 하면 **해당 원격 레포지토리를 사찰**해 다음의 정보를 보여준다.

- fetch 및 push URL
- head 브랜치
- 원격브랜치 및 브랜치별 상태 (track되었는지, stale되었는지, new인지)
    - stale이라는 말의 뜻은, 서버로부터는 제거되었으나 나는 아직 가지고 있는 원격-추적 브랜치를 의미하는 것으로 보인다.
- 로컬브랜치가 git pull하면 어디서 땡겨오는지
- 로컬브랜치가 git push하면 어디로 보내는지

**`git remote rename oldname newname`** 을 하게 되면 원격브랜치를 가리키는 별명뿐만이 아니라 **remote-tracking 브랜치들의 이름 또한** 자동적으로 바뀌게 된다.

**`git remote remove remotename`** 혹은 **`git remote rm remotename`** 을 하게 되면, 해당 원격 레포지토리에 대한 reference가 삭제되고, 이 원격레포지토리에 연관된 **모든 remote-tracking 브랜치와 관련 설정 역시** 삭제된다.

브랜치에는 3개의 종류가 있는 듯: local, remote-tracking, remote.

ref (혹은 reference) 는 브랜치를 의미하는 단어인거같음 일단 책을 좀더 읽어보면서 그 의미를 파악하는 것으로…

## 더보기

[stale 브랜치란?](https://stackoverflow.com/questions/29112156/what-is-a-stale-git-branch)

[브랜치의 종류 1](https://stackoverflow.com/questions/20106712/what-are-the-differences-between-git-remote-prune-git-prune-git-fetch-prune)

[브랜치의 종류 2](https://stackoverflow.com/questions/2003505/how-do-i-delete-a-git-branch-locally-and-remotely/23961231#23961231)