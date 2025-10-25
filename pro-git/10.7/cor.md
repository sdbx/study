# 10.7 유지보수 및 데이터 복구

## 학습목표
- `git gc` 명령어의 역할을 이해한다.
- 

## 유지보수
- 깃은 간헐적으로 auto gc (`git gc --auto`) 라는걸 함.
   - 대부분의 경우 이 명령어는 아무것도 안함
   - 깃이 진짜 gc를 작동시키려면 7천개의 loose object 혹은 50개 초과의 packfile이 필요함
   - 이러한 한도는 `gc.auto`나 `gc.autopacklimit`으로 제어 가능
- 그러나, loose object가 너무 많거나 packfile이 너무 많으면 `git gc` 실행됨
- gc = garbage collect
- gc 명령어가 하는 일
   - loose object를 수집해 packfile에 배치
   - packfile을 수집해 단일한 packfile로 통합
   - 어떤 커밋에서도 도달가능하지 않고 몇달이 지난 객체 삭제
   - 레퍼런스들을 단일한 파일(`.git/packed-refs`)로 통합
- 레퍼런스를 갱신하면 packed-refs 파일이 수정되는게 아니라 refs/head에 새로운 파일을 씀
- 주어진 레퍼런스의 SHA-1를 찾기 위해 깃은 refs/를 먼저 확인하고 packed-refs를 대비용으로 사용함
- packed-refs에서 ^로 시작하는 줄의 뜻은 위에 있는 태그가 주석태그란 뜻이며 이 줄은 이 태그가 가리키는 커밋을 의미

## 데이터 복구
- 깃을 쓰다보면 실수로 커밋을 잃어버릴 수 있음 (브랜치를 force-delete하거나 hard-reset했을 경우)
- 가장 손쉬운 방법은 `git reflog` 혹은 `git log -g`를 사용해서 원하는 SHA-1를 찾는 것임
- 참고로 reflog는 내가 HEAD를 이동시켰을때뿐만 아니라(커밋, 체크아웃), `git update-ref`에 의해서도 갱신됨
   - 이것이 ref파일을 직접 수정하는것이 비권장되는 이유임
- reflog 데이터는 `.git/logs` 디렉토리에 보관되므로 이걸 날리면 reflog가 날아감
- reflog를 사용할 수 없을때는 `git fsck`를 사용
- fsck = file system check
- fsck 명령어가 하는 일
   - 데이터베이스가 integrity를 가지는지 검사
   - `--full` 옵션으로 실행할시 **다른 object에 의해 point되지 않는** 모든 객체 출력
- 잃어버린 커밋은 dangling commit이라고 나옴
- 해당 커밋의 SHA-1을 가리키는 커밋을 만들면 데이터 복구 끝

## 오브젝트 삭제
- `git count-objects -v`를 통해 얼마나 많은 공간을 사용하고 있는지 확인 가능
   - `-v`는 verbose 옵션
- `git verify-pack -v <idxfile> | sort -k 3 -n | tail -3` 같은 식으로 정렬을 통해 크기가 큰 파일을 찾아낼 수 있음
   - `-v`는 verbose 옵션
   - idxfile 대신 packfile 넣어도 같은 결과 나오는 듯?
   - sort 프로그램
      - `-k` 혹은 `--key=KEYDEF` 옵션은 key를 통해 정렬하는 옵션. KEYDEF는 위치와 유형을 제공
      - `-n` 혹은 `--numeric-sort` 옵션은 문자열의 수치값을 비교
   - tail 프로그램
      - `-n` 혹은 `--lines` 옵션은 마지막 n줄만 출력
- `git rev-list --objects --all | grep <blob-SHA1>` 명령어를 통해 해당 blob의 파일명을 확인 가능
   - `--objects`: Print the object IDs of any object referenced by the listed commits.
   - `--all`: Pretend as if all the refs in refs/, along with HEAD, are listed on the command line as <commit>.
- `git log --oneline --branches -- <file>` 을 통해 이 파일을 수정한 커밋 확인 가능
   - 최초의 커밋을 포함해 그 이후에 작성된 커밋을 rewrite하려는 것 같음
   - `--branches`: Pretend as if all the refs in refs/heads are listed on the command line as <commit>.
- `git filter-branch --index-filter 'git rm --ignore-unmatch --cached <file>' -- <initial-commit>^..`
   - `--index-filter` 를 주면 인덱스에서 주어진 명령어가 실행되는 것 같음
   - git rm
      - `--cached`를 하는 이유는 이편이 disk에 checkout된걸 rm하는것보다 훨씬 빠르기 때문
      - `--ignore-unmatch`를 하는 이유는 지우려는 파일이 없어도 오류를 무시하기 위함인 듯
- 여전히 reflog와 filter-branch를 했을때 `.git/refs/original`에 생성된 새로운 refs들은 여전히 삭제된 파일에 대한 ref를 가지고 있음
- 따라서 데이터베이스를 repack하기 전에 이것들 역시 삭제해줘야 함
   - `rm -Rf .git/refs/original .git/logs/`
   - `git gc`
- 한편, 삭제된 오브젝트는 여전히 loose object로 존재하고 있다는 것 같음. 그러나, 이것이 추후 push나 clone시 전송되지는 않는다고 함
- 이것 역시 지우려면 `git prune --expire now`로 삭제 가능

## 영어 공부
- fledge[플래쥐]: (새) 나는데 필요한 깃털을 발달시키다
- full-fledged: 완전히 발달한
- consolidate[컨살리데이트]: 굳히다, 통합하다
