# 10.2 Git Internals - Git Objects

## content-addressable filesystem

- 단순한 key-value data store
- ID (key): unique. (content + header)의 checksum
- 객체 (value): blob, tree, commit.
- `.git/objects`: 객체 데이터베이스. 실제 객체가 담기는 위치. SHA-1의 앞 두 글자가 하위디렉토리로, 나머지 38자가 파일이름으로 담김

## Plumbing commands

- `git-hash-object`: 파일에서 객체 ID를 계산하고, 선택적으로 객체를 생성할 수 있음
  - stdout: 객체 ID
  - `-w`: 객체 데이터베이스에 객체를 작성
  - `--stdin`: 파일 대신 stdin에서 내용을 읽음
- `git-cat-file`: 객체의 내용 또는 세부 정보를 제공
  - `-p`: 객체의 유형에 따라 내용을 예쁘게 출력
  - `-t`: 내용 대신 객체 유형을 출력
- `git-update-index`: WS에 있는 파일 내용들을 인덱스에 등록
  - `--add`: 인덱스에 없는 새 파일도 추가. (없으면 새 파일을 무시함)
  - `--cacheinfo <mode>,<object>,<path>`: 지정된 정보를 인덱스에 직접 삽입
- `git-write-tree`: 현재 인덱스에서 트리 객체 생성
- `git-read-tree`: 트리 정보를 인덱스로 읽기
  - `--prefix=<prefix>`: 현재 인덱스 내용을 유지하고, `<prefix>`이름의 디렉토리로 트리 정보를 읽어오기
- `git-commit-tree`: 새 커밋 객체를 만듦
  - `-m`, `-F` 옵션이 없으면 stdin에서 커밋 메시지를 읽음
  - `-p`: 부모 커밋 객체의 ID
  - `-m`: 커밋 메시지 전달 (여러번 사용 가능)
  - `-F`: 커밋 메시지를 파일에서 읽음 (여러번 사용 가능)

## 헤더

- 모든 객체에는 헤더가 있음
- `<type> <content_size>\0` 형식
  - `<type>`: blob, tree, commit 중 하나
  - `<content_size>`: 내용의 바이트 크기
- header + content의 SHA-1가 체크섬이 됨
- 체크섬의 앞 두 글자를 `.git/objects/`의 하위 디렉토리로, 나머지 38자를 파일 이름으로 사용
- 파일은 zlib으로 압축함

## Blob 객체

```bash
# 객체 생성
$ echo 'test content' | git hash-object -w --stdin
d670460b4b4aece5915caf5c68d12f560a9fe3e4

# 객체 생성 위치 확인
$ find .git/objects -type f
.git/objects/d6/70460b4b4aece5915caf5c68d12f560a9fe3e4

# 객체 유형 출력
$ git cat-file -t d670460b4b4aece5915caf5c68d12f560a9fe3e4
blob

# 객체 내용 출력
$ git cat-file -p d670460b4b4aece5915caf5c68d12f560a9fe3e4
test content
```

## Tree 객체

UNIX 파일 시스템과 유사하지만 단순한 방식으로 저장

- tree: UNIX 디렉토리에 대응
  - tree의 각 항목은 mode, type(tree 또는 blob), 해시, 이름으로 구성
- blob: inode나 파일 내용에 대응
  - 모드는 세 가지만 사용:
    - `100644`: 일반 파일
    - `100755`: 실행 가능한 파일
    - `120000`: 심볼링 링크

참고: `main^{tree}` 문법: main브랜치의 마지막 커밋이 가리키는 tree 객체. 환경에 따라 따옴표로 감싸야할 수 있음

```bash
# 트리 객체 항목 출력
$ git cat-file -p 'main^{tree}'
100644 blob a906cb2a4a904a152e80877d4088654daad0c859      README
100644 blob 8f94139338f9404f26296befa88755fc2598c289      Rakefile
040000 tree 99f1a6d12cb4b6f19c8655fca46c3ecf317074e0      lib

# 인덱스에 파일 추가
$ git update-index --add --cacheinfo '100644,83baae61804e65cc73a7201a7252750c76066a30,test.txt'

# 또는 트리를 인덱스로 읽기
$ git read-tree d8329fc1cc938780ffdd9f94e0d364e0ea74f579

# index를 트리 객체로 만들기
$ git write-tree
```

## Commit 객체

- 구성: 누가, 언제, 왜 저장했는지, 단일 트리 해시, 부모 커밋이 있는 경우 지정
- 커밋 객체를 `cat-file -p`하면 나오는 정보:
  - 최상위 트리 (해당 시점의 프로젝트 스냅샷)
  - 부모 커밋이 있는 경우 표시
  - 작성자 정보, 타임 스탬프
  - 커미터 정보, 타임 스탬프
  - 빈 줄
  - 커밋 메시지

```bash
# 커밋 생성
$ echo 'First commit' | git commit-tree d8329f
fdf4fc3344e67ab068f836878b6c4951e3b15f3d

# 커밋 객체 확인
$ git cat-file -p fdf4fc3
tree d8329fc1cc938780ffdd9f94e0d364e0ea74f579
author Scott Chacon <schacon@gmail.com> 1243040974 -0700
committer Scott Chacon <schacon@gmail.com> 1243040974 -0700

First commit

# 직전 커밋을 참조하는 커밋 생성
$ echo 'Second commit' | git commit-tree 0155eb -p fdf4fc3
cac0cab538b970a37ea1e769cbbde608743bc96d
$ echo 'Third commit'  | git commit-tree 3c4e9c -p cac0cab
1a410efbd13591db07496601ebc7a059dd55cfe9

# git log시 실제 Git 히스토리를 확인 가능
git log --stat 1a410e
```

## git add, git commit 시 일어나는 일

1. 변경된 파일에 대한 블롭 저장
1. 인덱스를 업데이트
1. 트리 작성
1. 최상위 트리와 직전 커밋을 참조하는 커밋 객체 작성
