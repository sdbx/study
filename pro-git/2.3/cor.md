# 2.3 커밋 이력 조회하기

## 학습목표
- `git log`에 익숙해진다.
- 출력을 제한시키는 옵션들에 대해 이해한다.
   - `--oneline`, `--author`, `--grep`, `--all-match`, `-S`, `-- path`, `-<n>`, `--no-merges`, `--relative-date`

## 메모
`git log --pretty=format:"..."` 에 다양한 format specifier를 지정해줄 수 있다는 건 예전부터 알고 있었긴 함

`git log --pretty=format` 이 유용한 순간은 **기계적인 파싱을 위해서 출력을 생성**할 때임 (어디에 뭐가 출력될지 지정할 수 있으니까)

**`git log --pretty=format:"%h %s"` 이 두가지 format specifier 정도만 기억하고 있으면 충분할 듯**

**`git log --oneline`** 정도가 외워놓을만 할듯… (이것은 `--pretty=oneline --abbrev-commit` 의 약자임)

`git log` 의 `--author` 와 `--grep` 인자의 경우 **하나 이상을 지정할 수 있으며**, `--grep` 의 경우 `--all-match` 인자를 주어서 모든 조건을 다 만족시키는 커밋을 찾을 수 있다.

**`git log -S str` 은 소위 “pickaxe[pi-kaeks]” 옵션**이라고 불리는 것으로, str의 등장횟수(the number of occurrences)를 변경시킨, 즉 해당 문자열을 추가하거나 삭제한 커밋만을 검색한다.

**`git log ... -- path`** 를 하면 해당 디렉토리나 파일에 변경을 가한 커밋만을 검색할 수 있다. **항상 맨 마지막에 위치**하며, 일반적으로 double dashes 를 그 앞에 적어서 경로를 다른 옵션들로부터 분리시킨다.

이외에 주목할만한 `git log` 의 출력을 제한시키는 옵션들로는:

- `-<n>` 최근 n개의 커밋만 보여줘
- `--since` 혹은 `--after` 이 날짜 이후의 커밋만 보여줘
    - 날짜 양식은 여러개임.
    - 특정일: `2025-08-18`
    - 상대적: `2 years 1 day 3 minutes ago`
    - `--since=2.weeks`
- `--until` 혹은 `--before` 이 날짜 이전의 커밋만 보여줘
- `--author` 이 사람이 작성한 커밋만 보여줘
- `--committer` 이 커밋을 적용한 사람만 보여줘
- `--grep` 이 (패턴에 해당하는) 문자열을 가진 커밋만 보여줘
- `-S` 이 문자열을 추가하거나 제거한 커밋만 보여줘
- `--no-merges` 머지커밋은 빼고 보여줘

참고로, author는 작업을 맨 처음(originally) 한 사람을 뜻하고, committer는 작업을 마지막으로 적용(apply)한 사람을 말함.