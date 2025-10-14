# 8.2 Customizing Git - Git Attributes

## Git Attributes

- 특정 경로에 설정을 거는 것
- 위치: `.gitattributes` (버전관리됨) or `.git/info/attributes`
- 구조:

  ```.gitattributes
  경로 설정
  ```

### 바이너리로 취급

```.gitattributes
*.pbxproj binary
# CRLF 변환, 수정 X
# diff 계산, 출력 X
```

### 바이너리를 diff 가능하게 변환

```.gitattributes
*.docx diff=word
# git config diff.word.textconv docx2txt
# 참고: docx2txt는 커스텀 스크립트. 변환할 파일 이름을 인자로 전달 받음

*.png diff=exif
# git config diff.exif.textconv exiftool
```

### 키워드 확장

```.gitattributes
# $Id$에 blob 체크섬 주입
*.txt ident
```

#### 필터

- smudge: 체크아웃하기 직전에 파일 처리
- clean: stage하기 직전에 파일 처리

```.gitattributes
*.c filter=indentation
# git config --global filter.indentation.clean indent
# git config --global filter.indentation.smudge cat
```

stdin으로 파일 내용 전달, stdout이 파일 내용이 됨

드라이버(`indentation`)가 환경마다 없을 수 있으므로, 필터를 디자인 할 때 실패해도 문제 없도록 설계하는 것이 중요

### 레포지토리 내보내기

```.gitattributes
# git archive가 해당 파일을 제외하도록 설정
test/ export-ignore

# 키워드 확장 처리
LAST_COMMIT export-subst
# cat LAST_COMMIT
# Last commit date: $Format:%cd by %aN$
# to be
# Last commit date: Tue Apr 21 08:38:48 2009 -0700 by Scott Chacon
```

### 병합 전략(응용)

```.gitattributes
# 충돌시 ours만 사용
database.xml merge=ours
# git config --global merge.ours.driver true
```

병합이 항상 성공하도록 만듦. 실제 병합 전략과 무관
