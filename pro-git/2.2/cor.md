# 2.2 변경사항 저장하기

## 학습목표
- 파일이 tracked/untracked이라는 말의 뜻을 이해한다.
- .gitignore 파일의 역할에 대해 이해한다.
- `git diff`, `git diff --staged`의 차이를 이해한다.
- `git status`, `git status --short`의 차이를 이해한다.
- `git add` 의 역할을 이해한다.
- `git commit`의 역할을 이해한다.
- `git rm`과 `git rm --cached`의 차이를 이해한다.

## 메모
bona fide (라틴어 표현임) = real, genuine, authentic

checkout(명사)은 working copy of all of the repository’s files라는 의미인 듯함

⇒ [자세한 뜻은 깃 용어사전을 참조](https://git-scm.com/docs/gitglossary)

[**(사진 참조)](https://git-scm.com/book/en/v2/images/lifecycle.png) 깃 레포지토리 내에 있는 모든 파일들은 `tracked` 혹은 `untracked` 둘 중 하나의 상태임.**

- **tracked 상태라는 말의 뜻 = ▲ 이 파일은 지난 snapshot에 있었던 파일로서, unmodified, modified, 혹은 staged 중 하나의 상태이거나, ▲ 혹은 새롭게 staged된 파일이다.**
- **untracked 상태라는 말의 뜻 = tracked 상태가 아니라는 의미이므로, 지난 snapshot에 있었던 파일도 아니고, 새롭게 staged된 파일도 아니라는 뜻이다.**

follow suit = (비유적) 다른사람의 행동을 좇아서 똑같이 하다

**`git add` 는 다용도로 쓰이는 명령어로서, “이 내용을 다음 커밋에 추가하기” 라는 의미로 이해하고 있으면 좋다.**

**`git status -s` 를 통해 간략화된 상태를 확인할 수 있다. (`--short` 의 약자임.) 좌측열은 stage된 영역에서의 변경사항을 나타내고, 우측열은 작업영역에서의 변경사항을 나타낸다. untracked된 파일은 `??` 로 나타나며, 새롭게 stage된 영역에 추가된 파일은 `A` 로 나타나고, 변경된 파일은 `M` 으로 나타난다.**

`.gitignore` 파일의 문법:

- 공백줄이나 #로 시작하는 줄은 무시됨
- `/` 로 시작하면 재귀성이 무시됨
- `/` 로 끝나면 디렉토리를 명시함
- `!` 로 끝나면 패턴을 부정함
- `*` 은 0개 이상의 문자를 의미함
- `?` 는 하나의 문자를 의미함
- `[abc]` 는 a, b, 혹은 c를 의미함
- `[0-9]` 는 0과 9 사이의 문자를 의미함
- `a/**/z` 는 중첩된 디렉토리를 의미함. 예: `a/z` `a/b/z` `a/b/c/z`

하위 디렉토리에도 `.gitignore` 가 존재할 수 있으며 해당 햣무시 파일의 규칙들은 해당 디렉토리 이하로 적용된다.

**`git diff` 를 하면, 작업영역과 stage 영역간의 차이를 보여준다. `git diff --staged` 를 하면, staged된 변경사항과 지난 커밋간의 차이를 보여준다. (`--cached` 와 `--staged` 는 동의어.)**

**`git commit -v` 를 하게 되면 diff도 같이 나타난다.**

`git commit -m msg` 를 하면 별도 에디터를 열지 않고 커밋 메시지를 (간략하게) 작성할 수 있다.

`git commit -a` 를 하면 `git add` 를 생략하고 tracked된 모든 변경된 파일이 자동적으로 stage된 채로 커밋을 할 수 있게 된다.  편리하지만 원하지 않은 변경사항이 포함될 수 있으므로 주의해야 사용해야 한다.

**`git rm --cached` 를 하면 파일은 내버려두고 stage 영역에서만 지운다.**

**`git rm` 에서 `*` 패턴을 사용할 경우 반드시 그 앞에 `\` 를 넣어서 `\*` 과 같은 식으로 작성해야 함 (그 이유는 햣이 별도의 파일명 확장을 하기 때문이라고 함)**

⇒ untracked인 파일은 터치하지 않기 때문인가?

햣은 파일 이동 및 이름 변경을 명시적으로 추적하지 않지만 스스로 감지할 수 있다고 함. 그래서 `git mv from to` 로 변경하든 `mv from to && git rm from && git add to` 를 하든 상관없음.