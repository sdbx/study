# 7.12 Git Tools - Bundling

USB 스틱 등에 담을 수 있는 단일 파일로 커밋들을 묶음. 네트워크가 죽은 경우 유용

- `git bundle create <번들이름> <revs>`: 번들 만들기
  - 다른 곳에서 클론해야 한다면 `HEAD`를 추가해야함
- `git clone 번들이름 디렉토리이름`: 번들 클론하기
  - `HEAD`를 포함하지 않았다면 `-b 브랜치이름` 명시 필요
- `git bundle verify <번들파일>`: 제대로된 Git 번들인지, 커밋을 복원하는데 필요한 상위 커밋을 가지고 있는지 검증
- `git bundle list-heads <번들파일>`: head 나열
- `git fetch <번들파일> <번들브랜치명>:<불러올브랜치명>`: 불러올브랜치명으로 커밋이 불러와짐. `git-pull`도 가능
