# 8.2 깃 어트리뷰트

## 학습목표
- `.gitattributes` 파일의 역할에 대해서 이해한다.
- smudge 필터와 clean 필터가 무엇인지 설명할 수 있다.

## 개요
- git attribute = 서브디렉토리나 파일의 subset에만 적용할 수 있는 설정 (path-specific)
- 어트리뷰트를 저장하는 파일
   - 디렉토리 중 하나 (일반적으로 프로젝트 root) 내의 `.gitattributes` 파일
   - 혹은 `.git/info/attributes`에 저장해 커밋하지 않을 수 있음
- 어트리뷰트를 사용해 할 수 있는 것
   - 개별 파일이나 디렉토리에 대해 별도의 병합 전략 지정
   - 비 텍스트 파일에 대한 diff 방법 지정
   - 컨텐츠를 깃에 checkin 혹은 checkout할 때 filter하게 하기

## 이진 파일
- 특정 유형의 파일을 이진데이터로 취급하려면, `.gitattributes` 파일에 `*.format binary` 와 같은 식으로 작성한다.
- (이진으로 취급되어) diff가 안 되는 파일을 비교하려면, "필터" 역할을 하는 프로그램을 설정하면 된다.
   - `*.format diff=myformat` 을 .gitattributes에 작성
   - .gitconfig 파일 내의 `diff.word.textconv` 옵션에 myformat-converter 프로그램 지정

## 키워드 확장(대체)
- 파일이 checkout됐을때 특정 텍스트를 파일에 삽입하고 파일이 staging area에 들어가기 전에 그 텍스트를 제거할 수 있음
   - 예시: ident
      - 어트리뷰트 파일에 `*.txt ident` 라고 명시하고
      - 임의의 텍스트파일에 `$Id$`를 적어놓으면
      - 해당 파일을 checkout했을때 해당 "blob"의 sha-1로 해당 문자열이 확장되어 있음
- 이러한 역할을 하는 "필터"를 직접 작성 가능
   - smudge 필터: checkout되기 전에 키워드 확장
   - clean 필터: stage되기 전에 키워드 제거
- 사용법
   - 어트리뷰트 파일에 `*.c filter=waifu` 같은 식으로 작성
   - 컨피그 파일에 `filter.waifu.clean remove-waifu` `filter.waifu.smudge show-waifu` 같은 식으로 작성

## 프로젝트 export
- `export-ignore`: git archive 명령을 통해 압축파일을 만들때 특정 path를 포함하지 않도록 만듦
- `export-subst`: 특정 파일에 git log의 포매팅 및 키워드 확장 적용
   - 커밋 메시지 및 `git notes` 등도 포함 가능

## 병합 전략
- 특정 파일에 대해서만 별도의 병합 전략을 사용토록 할 수 있음
- 사용법
   - 어트리뷰트 파일에 `file.txt merge=mymerge` 라고 작성
   - 컨피그 파일에 `merge.mymerge.driver <program> <args>...` 라고 작성
   - 만약 driver를 true로 지정하면 그냥 현재 위치한 브랜치의 파일이 사용되는 듯? (추측임)

## 새롭게 알게 된 것
- `git notes` 명령어: 이미 만든 커밋에 노트 붙이기
- tar 프로그램의 인자
   - x: 추출
   - O: stdout으로 추출
   - f: 아카이브 파일 사용
   - C: 지정된 디렉토리로 먼저 이동 후 작업
   - `-`: stdin
- `@` = `HEAD`

## 영어 공부
- to[for] all intents (and purposes): 모든 점에서, 사실상[practically]
- (every) once in a while: 가끔, 이따금, 때때로
- what good (is it / does it do): 무언가가 유용하거나 할 가치가 있다고 생각하지 않을 때 사용
- smudge[스멋쥐]: (자국, 얼룩) 더럽게 하다, 번지다
