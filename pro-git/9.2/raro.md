# 9.2 Git and Other Systems - Migrating to Git

## Subversion

1. 작성자 정보 매핑
2. `git svn clone`
3. 이상한 참조 정리
   - 태그를 실제 태그로 매핑
   - `refs/remotes` 아래 참조를 로컬 브랜치로 이동
4. 추가 브랜치(`trunk`) 제거
5. Git 서버에 푸시

## Mercurial

`hg-fast-export` 이용

1. `hp clone`으로 저장소 전체를 클론
2. 작성자 매핑 파일 생성
3. Git 저장소를 새로 만들고 변환 스크립트 실행
4. Git 서버에 푸시

## Perforce

Perforce Git Fusion을 사용하는 경우 저장소를 복제하기만 하면 가능.

Git-p4를 가져오기 도구로 사용

1. `git p4 clone`
2. 선택: `p4import` 디렉토리에서 모든 커밋의 git-p4 식별자 제거
3. Git 서버에 푸시

## Custom Importer

- 위 예시에 없더라도 온라인에서 찾을 수 있음
- 없는 경우 `git fast-import`를 사용
- Git은 스냅샷을 가리키는 커밋 객체의 연결 리스트이므로, 스냅샷이 무엇인지, 어떤 커밋 데이터가 그걸 가리키는지, 들어가는 순서를 `fast-import`에 stdin으로 전달
