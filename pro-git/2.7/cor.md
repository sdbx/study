# 2.7 사용자 지정 명령어

## 학습목표
- `git config --global alias.<name> <command>`
- !로 시작하는 명령어의 뜻을 이해한다.

## 메모
`.gitconfig` 파일 혹은 `git config --global` 명령어로 사용자 지정 명령어를 등록 가능.

긴 명령을 단축해서 사용할 수 있고, 필요한 명령을 만들어서 사용할 수도 있음.

깃은 사용자가 명령어를 부분적으로 입력해도 그 명령어가 뭔지 추론하지 않음.

`!` 로 시작하는 명령은 깃의 subcommand로 해석되지 않고 외부 명령어로 해석됨.

## 영단어

regularity ⇒ the state or quality of being regular.

⇒ He came to see her with increasing regularity.