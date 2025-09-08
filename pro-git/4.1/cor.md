# 4.1 프로토콜

## 학습목표
- 원격 git 레포지토리의 필요성 이해하기
- git 서버 운영에 사용되는 프로토콜의 종류 숙지하기
- 각 프로토콜의 장단점 알기

## 원격 레포지토리의 필요성
- 개개인의 레포지토리에 push나 pull할 수 있지만 이러한 방식은 부주의할 경우 혼란을 일으키기 쉽기 때문에 권장되지 않음.
- 또한, 내 컴퓨터가 오프라인이더라도 동료들이 내 레포지토리에 접근하기를 원할 수 있음.
- 이에, 선호되는 방식은 협업자들이 모두 접근/push/pull할 수 있는 **"중간 서버"**를 두는 것임.
- `bare repository` 라는 말의 뜻 = **작업 영역이 없는** git 레포지토리. 그냥 `.git` 만 있는 것.

## 프로토콜
햣은 4가지의 각기 다른 프로토콜을 사용해 데이터를 전송함. (1) 로컬 (2) http (3) 시큐어 쉘[ssh] (4) git
### local 프로토콜
원격 저장소가 같은 장치상의 다른 디렉토리에 있음. nfs 마운트와 같은 공유 파일시스템에 협업자들이 접근할 수 있거나, 협업자들이 모두 같은 컴퓨터에 로그인하는 경우에 종종 사용됨.
```bash
git clone <url-to-repo>
git clone file://<url-to-repo>
```
`file://` 을 붙이지 않으면 git은 hardlink를 사용하거나 필요한 파일을 직접 복사함. 만약 붙이면, 네트워크를 통해 데이터를 전송하기 위해 사용하는 프로세스를 사용함. 따라서 후자는 비효율적이나, 관련없는 레퍼런스나 오브젝트를 배제한 채로 레포지토리를 clean copy하고 싶은 경우 사용될 수 있음.
#### 장점
- 파일 기반 레포지토리는 단순하며 기존의 파일 권한과 네트워크 접근을 사용함. 이미 공유 파일시스템을 가지고 있다면 레포지토리를 설립하는 것이 쉬움.
- 동료의 레포지토리에서 check out하는 것이 (동료가 서버에 올리고 내가 곧바로 fetch하는 것에 비해) 간편함.
#### 단점
- shared access는 기본적인 네트워크 기반 접근에 비해 일반적으로 설립하기도 어렵고 다수의 장소에서 접근하기도 어려움.
- 또한 로컬 프로토콜은 실수로 인한 손상에 대해 원격 저장소를 보호하지 않음.
- 로컬 레포지토리가 빠른 것은 내가 데이터에 대해 빠른 접근을 가지고 있고 오직 그 경우에만 빠름. nfs상에 있는 레포지토리는 종종 동일 서버에 있는 ssh를 통한 레포지토리에 비해 느린데, git이 각 시스템에 있는 로컬 디스크를 복사할 수 있게 하기 때문임.

### http 프로토콜
두가지 모드로 동작함. 보통 둘 중 하나만 사용함.
- `smart http`: 1.6.6에 도입된 새로운 프로토콜. 지능적으로 데이터 전송을 negotiate함 (ssh이나 git 프로토콜과 유사).
   - 표준 https 포트에서 동작하고 다양한 http authentication mechanism을 사용 가능. => ssh같은 것보다 종종 사용하기 쉬움 (키를 만들 필요 없음).
   - `git://` 프로토콜처럼 익명으로 serve할수도 있고 ssh 프로토콜처럼 authentication과 encryption을 가지고 push될 수도 있음.
- `dumb http`: 1.6.6 이전에 사용되던 프로토콜. 단순하고 일반적으로 읽기 전용.
   - bare git repo가 일반 파일처럼 serve될 것이라고 간주함
   - 이 프로토콜은 설정하기가 단순함. http doc root에 bare repo를 두고 특정한 post-update hook을 설치해두면 됨.
#### 장점
- 한가지 URL로 모든 유형의 접근에 대응 가능하고, 필요시에 아뒤/비번으로 authentication할 수 있는 것이 편리한 장점임. 또한 매우 빠르고 효율적임.
- 데이터 전송을 https로 encrypt 가능. signed된 ssl certificate를 사용하게 할 수도 있음.
- corporate firewall을 설치하여 port를 통한 트래픽을 허용할 수 있음.
#### 단점
- git over https는 어떤 서버 상에서는 ssh에 비해 설치하기가 까다로울 수 있음. 이것 말고는, 다른 프로토콜들이 git content를 전송함에 있어 smart http에 대해 가지는 이점은 적음.
- http를 사용해 authenticated push를 한다면, credential를 제공하는 것이 때때로 ssh의 key를 사용하는 것보다 복잡할 수 있으나 여러가지 credential cache 툴을 사용해 이 단점을 경감시킬 수 있음.

### ssh 프로토콜
self-host할 때 일반적인 전송 프로토콜임. ssh는 authenticate된 네트워크 프로토콜이며, 아주 흔하기 때문에 일반적으로 설치와 사용이 쉬움.
```bash
# ssh 사용 예시
git clone ssh://[user@]server/project.git
git clone [user@]server:project.git
```
optional username을 생략하면 현재 로그인되어있는 사람으로 추정됨.
#### 장점
- 설치하기 쉽고 사용해본 사람도 많고 관련 툴도 많음
- secure함 => 모든 데이터 전송은 encrypt 및 authenticate됨
- 효율적임 => 데이터 전송 전에 데이터를 가능한 한 compact하게 만듦
#### 단점
- 익명 접근을 지원하지 않음 (read-only 포함) => 오픈소스 프로젝트에 부적합

### git 프로토콜
깃에 기본적으로 들어있는 특별한 데몬임. ssh 프로토콜과 유사한 기능을 제공하는 dedicated port (9418) 을 listen 함. 그러나 authentication이나 cryptography가 없음. git 프로토콜을 사용해 repo를 serve하려면 반드시 `git-daemon-export-ok` 파일을 생성해야 함. push access를 활성화할 수 있지만 authentication이 없다는 점을 고려할 때 인터넷상의 누구나 push할 수 있으므로 일반적으로 git 프로토콜을 통한 push는 없다.
#### 장점
- 종종 가장 빠른 network transfer protocol임.
- ssh protocol과 동일한 데이터 전송 mechanism을 사용하나 인증과 암호화에 대한 overhead가 없음.
#### 단점
- TLS[transfer layer security]나 다른 암호화가 없음 => `git://` 을 통한 clone은 임의 코드 실행 취약점으로 이어질 수 있음.
   - 따라서 `git clone git://` 과 `git clone http://` 는 지양되어야 함.
   - 공격자가 tls certificate를 provide할 수 있는게 아니라면 `git clone https://` 는 이 문제로부터 자유로움.
   - 잘못된 ssh key fingerprint를 accept하지 않는다면 `git clone git@...` 도 이 문제로부터 자유로움.
- 설정하기 가장 어려운 프로토콜 => 데몬을 실행해야 해서 xinetd나 systemd같은 설정을 해야 하는데 이게 쉽지 않음
- port 9418에 대한 firewall access를 필요로 하는데 standard port가 아니어서 일반적으로 block됨

## 영어 공부
- hassle: 귀찮은 일
- the ins and outs (of sth): (복잡한 일의) 자초지종[자세한 내용]
- bare: 벌거벗은, 맨-
- fire sth up: 작동시키다
- set up: 설립하다
- run off: 복사하다
- ubiquitous: 어디에나 있는
- commonplace: 아주 흔한
- conducive: ~에 좋은
- suffice (it) to say (that): ~라고만 해도 충분할 것이다
- a walk in the park: (비격식) 달성하기 매우 쉬운 것