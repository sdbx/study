# A3.2 Appendix C: Git Commands - Getting and Creating Projects

- `git init`: 새 Git 저장소를 만듦
  - `--bare`: 새 bare 저장소를 만듦
  - 내부적으로 `.git/` 디렉토리를 만듦
- `git clone`: 이미 있는 Git 저장소를 복제
  - 디렉토리를 만들고 거기에 이동, `git init` 실행, 리모트 추가, fetch, 마지막 커밋 체크아웃을 함
  - `--bare`: WD없는 사본을 만듦
  - 저장소 번들을 unbundle하는데 사용
  - `--recurse-submodules`: submodule init + update
