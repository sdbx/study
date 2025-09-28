# 6.5 GitHub - Scripting GitHub

## 외부와 통합하기

### 서비스

- 미리 정의된 상업 혹은 오픈소스 시스템과 통합하는 기능
- 없어짐

### 웹훅

- 이벤트가 발생할 때마다 제공된 URL로 HTTP 페이로드를 전송

### GitHub API

- 웹사이트에서 할 수 있는 거의 모든 것을 할 수 있음
- 공식 SDK: Octokit

#### 비인증

- 공개적으로 볼 수 있는 읽기 전용
- 예시
  - `GET /users/<user>`
  - `GET /gitignore/templates/<template>`

#### 인증

- 상호작용 또는 비공개 읽기, 상호작용
- 인증 방식
  - username & password를 통한 인증
  - PAT를 통한 인증(권장)
    - 스코프 제한
    - 언제든지 무효화 가능
- 비인증에 비해 rate limit가 널널함
- 예시
  - `POST /repos/<user>/<repo>/issues/<num>/comments`
  - `POST /repos/<user>/<repo>/statuses/<commit_sha>`
