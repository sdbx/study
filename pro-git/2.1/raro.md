# 2.1 깃 레포 얻기

## 로컬 머신에 Git 레포를 얻는 두 가지 방법

- `git init` - 로컬에서 새 Git 레포 시작
- `git clone <url>` - 이미 있는 Git 레포를 clone

## .git 디렉토리 구조

`.git` 디렉토리는 모든 필요한 레포 파일을 포함. (Git repository skeleton)

```bash
$ ls -F1 .git/
config         # project-specific 설정
description    # GitWeb에서만 씀
HEAD           #
index          #
hooks/         # client or server-side hook scripts
info/          # 정보 (.git/info/exclude)
objects/       #
refs/          #
```

`objects/`: object database

`refs/`: branches, tags, remotes 등을 나타내는 포인터. 해당 commit object를 가리킴

`HEAD`: 현재 checked out한 브랜치를 가리킴

`index`: staging area 정보

백업하거나 클론하려면 `.git`를 복제하는 것으로 충분

### Content-addressable filesystem

Git은 content-addressable 파일 시스템 (단순한 key-value 스토어)

Plumbing[ˈplʌmɪŋ] and Porcelain[|pɔːrsəlɪn] 명령

- Porcelain 명령(고수준, 유저 친화적, 우리가 쓰는 것)
- Plumbing 명령(저수준, 유닉스 스타일, script에서 쓰기 좋음)
  - `git hash-object`: 어떤 데이터를 object database에 저장. object를 참조하는 유일한 키를 반환
  - `git cat-file`: object database에 저장한 내용을 보기

Git은 UNIX filesystem의 단순한 버전으로 내용을 저장함. 모든 내용은 tree와 blob object로 저장됨.

- tree - UNIX directory entries에 대응
- blob - inode나 file content에 대응

## 이름이 clone인 이유

working copy만 가져오는 다른 VCS과 달리, Git은 서버가 가진 거의 모든 정보를 복제함. 기본적으로 모든 파일의 모든 버전을 pull down함.

## Git의 전송 프로토콜

- Local: 리모트가 같은 host에 있는 경우. NFS와 같이 모든 팀이 공유 파일 시스템을 쓰는 경우 유용.
- HTTP: Git 1.6.6이전과 이후로 나뉨. (Smart HTTP, Bumb HTTP)
  - Smart HTTP: SSH나 Git 프로토콜과 유사. 다양한 HTTP 인증도 가능. 따라서 다른 프로토콜보다 사용하기 쉬울 수 있음
- SSH: SSH가 없는 서버는 없다. 어디서나 쓰고, 인증도 있어서 무난한 선택
- Git: 인증도 암호화도 없어서 제일 빠른 대신 안 쓰는 것이 좋음.

자세한 내용은 <https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols> 에 있음
