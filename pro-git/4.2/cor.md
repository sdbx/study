# 4.2 서버에 깃 구축하기

## 학습목표
- 서버에 깃을 설치하는 방법을 이해한다.
- 4장 1절에서 다룬 프로토콜들을 구축하는 방법을 이해한다.

## 순서
1. bare repo를 획득한다.
2. 획득한 bare repo를 서버에 놓는다.
3. 프로토콜을 설정한다.

## bare repo 획득법
- 먼저 기존 repo를 bare repo로 export해야 함.
- 관습적으로 bare repo가 들어있는 디렉토리명은 `.git` 으로 끝남.
- `git clone --bare <proj_name> <proj_name>.git`
- clone에 bare옵션을 주는 대신, `cp -Rf` (recursive, force) 로 `.git` 자체를 복사하면 설정 파일에 약간의 차이가 있다고 하나 거의 비슷하다고 함.

## 서버에 놓기
- 내가 ssh 접근을 할 수 있는 `git.example.com` 이라는 서버가 있다고 가정하자.
- 서버의 `/srv/git` 디렉토리에 bare repo 복사하기
   - `scp -r <proj_name>.git user@git.example.com:/srv/git`
- 이 시점에서 위 디렉토리에 대해 ssh 기반 read 접근을 할 수 있는 사용자는 이 repo를 clone할 수 있다
   - `git clone user@git.example.com:/srv/git/<proj_name>.git`
- `/srv/git/<proj_name>.git` 디렉토리에 write 접근을 할 수 있는 사용자는 자동적으로 push 접근도 할 수 있다.
- repo에 group write 권한 부여하기
   - `ssh user@git.example.com`
   - `cd /srv/git/<proj_name>.git`
   - `git init --bare --shared`
- 이게 끝임. 즉, private project 상에서 협업하기 위해 필요한 것은 ssh 서버와 bare repo임.

## 기타 설정
- git 서버를 구축함에 있어 복잡한 것들 중 하나는 유저 관리
- 협업자에게 ssh 접근을 할 수 있게 하는 여러가지 방법들이 있는데 네트워크 관련 지식이 없어서 이해하기 어려움

## 영어 공부
- IT infrastructure: 어떤 it 서비스의 기반인 it 요소들의 집합
- outfit: (비격식) (함께 작업하는) 팀