# 1.3 깃이란 무엇인가?

## 학습목표
- git의 특징에 대해 이해한다.

## 요약
- 깃은 아래의 특징을 가진다.
- 각 파일에 만들어진 "차이"를 저장하는게 아니라 (delta-based), 스냅샷을 찍는다.
   - 커밋할 때마다 (= 프로젝트의 상태를 저장할 때마다), 그 순간에 모든 파일이 어떻게 생겼는지를 "사진 찍고", 그 사진에 대한 참조를 저장
- 거의 모든 작업이 로컬에서 이루어짐
- 깃 내의 모든 것은 저장되기 전에 checksum되며 그 checksum으로 refer된다.
   - 정보에 문제가 생기면 git이 감지 가능
   - 체크섬하기 위해 사용하는 메커니즘 = SHA-1 해시 = 40자의 문자열(0-9, a-f)
   - 파일 내용 혹은 디렉토리 구조에 기반해 계산됨
- 한 번 커밋된 것은 잃어버리기 어려움
- 파일의 3가지 상태: modified, staged, committed
   - modified = 파일을 변경했지만 아직 커밋해서 db에 들어가지는 않은 것
   - staged = modified된 파일이 다음 커밋 스냅샷에 들어가도록 표시된 것.
   - committed = 로컬 db에 저장된 것.
- 깃 프로젝트의 3가지 섹션: working directory(tree), staging area, .git directory(repository)
   - working tree = 프로젝트의 한 버전에 대한 checkout으로, git 디렉토리의 압축된 db에서 꺼내져 disk상에 위치되어 개발자가 사용 및 수정할 수 있게 된다.
   - staging area = 하나의 파일으로, 다음 커밋에 무엇이 들어갈지에 대한 정보를 저장함. 정확한 이름은 **index**임.
   - git directory = 메타데이터와 object db이 저장되는 곳임. clone하면 이것이 복사됨.
- 기본적인 workflow는 다음과 같음.
   1. working tree에서 파일을 modify함.
   2. 다음 커밋에 포함시키고자 하는 변경사항만 stage하여 staging area에 등록시킴.
   3. 커밋을 한다. staging area에 있는 파일들이 취해지며 이 스냅샷이 git directory에 영구적으로 저장된다.
- 어떤 파일의 특정한 버전이 git directory에 있다면, 그 파일은 committed로 간주됨.
- 파일이 modified되고 staging area에 추가되었다면, 그 파일은 staged된 것임.
- 파일이 checkout된 이후로 변경되었지만 staged되지는 않았다면 modified된 것임.

## 영어 공부
- unworldly: 천상의
- parlance: (특정집단의) 말투, 어법, 용어