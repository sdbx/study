# 1.5 깃 설치하기

## 학습목표
- 깃을 설치하는 방법을 숙지한다.
- 깃을 업데이트하는 방법을 숙지한다.

## 요약
- 설치법
   - 패키지로 설치
   - 다른 인스톨러로 설치
   - 소스코드 다운후 직접 컴파일
### 리눅스
- 바이너리 인스톨러로 리눅스상에서 설치하기 => 사용하는 배포판의 패키지 관리툴 이용
   - RPM-based: 페도라, RHEL, CentOS => `sudo dnf install git-all`
   - Debian-based: 우분투 => `sudo apt install git-all`
- 맥OS => `git --version`
- 윈도우즈 => 깃 공식 웹사이트
   - 이는 Git for Windows로 Git과는 별개임
   - 자동화된 설치 => Git Chocolatey package
- 소스코드로부터 설치
   - 가장 최신버전을 얻을수있다는 장점
   - git이 의존하는 라이브러리를 가지고 있어야 함
   - 깃 자신을 통해서 깃을 얻은 후 업데이트 가능