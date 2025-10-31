# 10.9 요약
10장에서는 깃의 내부적으로 어떻게 작동하는지 다루었다.

## 10장 1절
plumbing과 porcelain라는 개념에 대해 알게 되었으며, .git 디렉토리 내에 무엇이 들어있는지 알았다.

- 깃은 content-addressable filesystem
- plumbing = 저수준 명령어 (end-user용이 아님)
- porcelain = 고수준 명령어
- .git 디렉토리 = 깃에 의해 관리되는 것들이 들어있음
   - refs/ = 레퍼런스
   - objects/ = 깃 오브젝트
   - index = 스테이징 영역
   - HEAD = 현재 checkout된 브랜치

## 10장 2절
깃에서 생성하는 오브젝트의 종류에 대해 알았고, plumbing 명령어를 통해 객체를 만들고 커밋하는 방법을 알았다.

- 깃 = content-addressable filesystem = key-value data storage
- git hash-object = 데이터 기반으로 db에 저장하고 key 리턴
- git cat-file = 오브젝트의 유형에 맞춰 해당 오브젝트 내용 출력
- 데이터를 hash-object => 헤더에 파일내용을 붙인것의 SHA-1가 key
   - 첫 2글자 = sub-directory명
   - 나머지 38글자 = 오브젝트명인 듯
- 객체 종류: blob, tree, commit, tag
- 파일은 blob으로 저장되는 듯
- tree 객체 = blob과 tree로 이루어짐

## 10장 3절
레퍼런스라는 말의 뜻을 알았다.

- 레퍼런스 = SHA-1에 붙여놓은 별명
- .git/refs/ 내 저장되나 직접 편집 비권장 (이유: reflog가 갱신되지 않음)
- HEAD 파일 = 심볼릭 레퍼런스 = 브랜치를 가리킴

## 10장 4절
팩파일이라는 개념에 대해 알았다.

- 효율적으로 데이터를 저장하기 위한 수단
- 델타를 저장
- loose object를 묶어서 하나의 packfile으로 만듦

## 10장 5절
refspec에 대해 알았다.

- `[+]<src>:<dst>` 의 형태
- fetch/push시 사용할 refspec을 .git/config에 작성

## 10장 6절
HTTP 프로토콜의 내부 동작에 대해 둘러보았다.

- dumb냐 smart냐에 따라 동작이 다름
- dumb는 read-only인 것으로 보임
- smart는 데이터 업로드/다운로드 가능

## 10장 7절
git gc의 역할, 데이터를 복구하는 방법, 데이터를 삭제하는 방법에 대해 다뤘다.

- git gc = 팩파일 제작, 현수객체 삭제, 레퍼런스들을 한 파일내로 정리
- 커밋 잃어버렸을 경우 reflog 확인
- reflog가 여의치 않을 경우 git fsck 사용
- 오브젝트를 삭제하려면 filter-branch, gc, prune 등의 명령어 활용

## 10장 8절
쉘 환경변수를 통해 깃의 동작에 영향을 주는 방법에 대해 알았다.

- 깃은 bash 내에서 작동
- GIT_EDITOR, GIT_AUTHOR_NAME 등의 환경변수 존재

## 10장 9절
깃의 내부구조를 조금 들여다봄으로써 깃의 작동방식에 대한 이해가 한층 더 심화되었다고 생각한다.

- content-addressable 파일시스템으로서의 깃은 강력한 도구이며 단순히 VCS로만 사용할 수 있는 것이 아님
