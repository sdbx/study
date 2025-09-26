# 6.3 GitHub - Maintaining a Project

## 새 레포 만들기

- HTTPS와 SSH 제공
- HTTPS 읽기는 깃헙 계정조차 필요 X

## Collaborator 추가하기

- push 권한을 줌

## PR 관리

- 기여자와 지속적인 대화 가능
- 병합을 원한다면 "non-fast-forward"하는 "Merge" 버튼 클릭 or 로컬에서 병합
- 원하지 않는다면 닫기
- 어떤 브랜치든 대상으로 가능. 심지어 PR도 가능

### PR 참조

- PR은 pesudo-branch. `refs/pull/` 아래에 있음.
- 참고로 브랜치는 `refs/heads/` 아래에 있음
- `refs/pull/#/head`: PR 브랜치의 마지막 커밋을 가리킴
- `refs/pull/#/merge`: merge 버튼을 눌렀을 때 결과를 가리킴

### PR 참조 활용

```.git/config
[remote "origin"]
  url = ...
  fetch = +refs/heads/*:refs/remotes/origin/*
  fetch = +refs/pull/*/head:refs/remotes/origin/pr/*

```

- `fetch =`는 원격 참조를 로컬 참조와 대응시킴. `+서버:로컬`인 것 같음.
- 이제 fetch 하면 모든 PR을 가져옴
- `git switch pr/2`처럼 사용 가능

## 멘션

- `@`와 자동완성으로 멘션 가능
- 멘션 당하면 PR이나 이슈를 자동으로 구독

## 알림

- 깃헙 내 이벤트가 발생하면 알림이 발생
- 웹과 메일을 지원
- 이메일
  - 필터링을 위한 여러 메타데이터 포함
  - PR이나 이슈인 경우 답장하면 comment가 생김

## 특수 파일

### README

- prose로 인식할 수 있는 거의 모든 유형을 지원
- 깃헙에서 랜딩페이지로 렌더됨
- 보통 다음을 포함:
  - 무엇을 위한 프로젝트인지
  - 어떻게 설정하고 설치하는지
  - 어떻게 쓰는지, 어떻게 실행하는지
  - 프로젝트의 라이센스
  - 어떻게 기여하는지

### CONTRIBUTING

- 아무 확장자 다 가능
- PR을 열 때 참조할 수 있음

## 프로젝트 관리

### 기본 브랜치 변경

- 대부분의 주요 동작이 이 기본 브랜치를 기준으로 동작
  - 기본으로 보이는 브랜치
  - PR의 대상 브랜치
  - 등

### 프로젝트 전송

- 깃헙 내 다른 사용자나 조직으로 이동
- 프로젝트 내용, watcher, star 등을 옮기고 새 주소로 URL redirect도 함
