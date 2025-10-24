# 10.6 전송규약

## 학습목표
- HTTP 프로토콜의 내부 동작에 대해 둘러본다.

## Dumb Protocol
- HTTP를 통해 read-only로 제공되는 서버라면 dumb protocol이 사용될 가능성이 높음
- 한편 요즘에는 dumb protocol은 거의 사용되지 않음
- `git http-fetch`: Download from a remote Git repository via HTTP
- `git update-server-info`: Update auxiliary info file to help dumb servers
- 서버에 `GET info/refs`, `GET HEAD` 같은 요청을 해서 필요한 정보를 받아옴
- 그리고 얻은 정보를 가지고 커밋을 walk하는 것으로 보임

## Smart Protocol
- 데이터를 전송하기 위한 두 묶음의 절차들이 있음.
- 각 절차에서 데이터를 주고받는 양식?이 있는 것으로 보임
   - 첫 4글자는 자신을 포함한 데이터의 길이라든지, 한줄에 하나의 정보라든지 하는 식임
- 아래에 적어둔 명령어들은 end user가 직접 사용하는 것이라기보다는 내부적으로 사용되는 듯

### 데이터 업로드
- handshake라는 말의 뜻: 커뮤니케이션의 시작과정에서 두 참여자가 정보를 교환하는 것을 이르는 개념인 듯
- `git send-pack`: Push objects over Git protocol to another repository
- `git receive-pack`: Receive what is pushed into the repository

### 데이터 다운로드
- `git fetch-pack`: Receive missing objects from another repository
- `git upload-pack`: Send objects packed back to git-fetch-pack

## 기타
- 위에서 소개된 것 말고도 전송규약에는 다양한 기능들이 있음
   - `multi-ack`, `side-band` capability 등
- 이런 것에 대해 더 자세히 알아보려면 git 소스코드를 참조하라고 함

## 영어 공부
- premises[프레미시즈]: (한 사업체가 소유하는) 부지, 구내
- on-premise: 기업이 서버를 클라우드 환경이 아닌 자체 설비로 보유하고 운영하는
- capability[케이퍼빌러티]: 능력, 역량
