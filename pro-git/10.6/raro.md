# 10.6 Git Internals - Transfer Protocols

## 데이터 전송 방식

### HTTP Dumb 프로토콜

- 읽기 전용
- fetch는 GET 요청들
- 서버 측에 깃에 특화된 코드가 필요하지 않음
- bare 저장소의 파일에 직접 접근하여 필요한 정보를 가져옴
- 권장 X

#### clone 과정

1. `GET info/refs`: 원격의 참조와 SHA-1 목록
1. `GET HEAD`: HEAD 가져오기
1. 나열된 객체 가져오기
   - `GET objects/객체`: loose 포맷 객체 가져오기
   - `GET objects/info/http-alternates`: 다른 주소에 있는 객체 가져오기(fork 등)
   - `GET objects/info/packs`: packfile 목록 가져오기
   - `GET objects/pack/*.{idx,pack}`: packfile 가져오기
1. HEAD를 체크아웃

### Smart 프로토콜

- 로컬 데이터를 읽고, 무엇을 가지고 있고, 무엇이 필요한지 알아내어 맞춤형 packfile을 생성
- 데이터는 청크로 전송. 청크의 길이를 4자의 hex로 표시
- 프로토콜(SSH, HTTP)에 따라 과정은 유사하나 차이가 있음

#### 업로드 과정

1. 클라에서 `send-pack` 실행. 이하 동작을 수행
1. 서버에 접속해서 `receive-pack` 실행. 소유한 참조를 한 줄씩 응답(청크). 첫 줄은 호환성 목록을 포함
1. 서버가 가지고 있지 않은 커밋을 결정
1. 업데이트되는 참조 목록을 `receive-pack`에 전송. 어느 한 쪽에 없는 해시 값은 `0` 40개로 채움
1. 서버에 없는 모든 객체의 packfile 전송

#### 다운로드 과정

1. 클라에서 `fetch-pack` 실행. 이하 동작을 수행
1. 서버에 접속해서 `upload-pack` 실행. 소유한 참조를 한 줄씩 응답. HEAD가 가리키는 것도 다시 보냄(clone일 경우 무엇을 체크아웃해야하는지 명확)
1. 가지고 있는 객체 확인
1. 이미 있는 객체를 have, 필요한 객체를 want로 표기한 해시를 나열, 마지막에 done 표기(청크)한 것을 전달
1. 필요한 정보가 포함된 packfile 전송
