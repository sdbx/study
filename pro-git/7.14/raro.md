# 7.14 Git Tools - Credential Storage

자격 증명 시스템: HTTP 프로토콜에서 자동으로 인증하는 헬퍼

기본 옵션:

- 기본값: 아무것도 캐시하지 않음
- cache: 일정 시간동안 메모리에 보관
  - `--timeout <seconds>`: 유지되는 시간. 기본값: 900(=15분)
- store: 평문으로 파일에 저장
  - `--file <path>`: 저장하는 위치 지정. 기본값: `~/.git-credentials`
- osxkeychain: macOS 전용. 시스템 계정에 연결된 보안 키체인에 자격 증명을 캐시
- Git Credential Manager: Windows Credential Store에 캐시. WSL에서도 가능

특징:

- 여러 헬퍼 구성 가능. 순서대로 쿼리하고 첫 번째 응답이 제공되면 중단

내부 동작:

- 명령을 인수로 받고 stdin을 통해 더 많은 입력을 받음
- 헬퍼는 Git과 무관한 단일 실행 파일임. cache의 경우엔 `git-credential-cache`임
- 실행 형식: `git-credential-foo [args] <action>`
  - action:
  - `get`: username/password 쌍을 요청
  - `store`: 자격 증명 세트를 저장하라는 요청
  - `erase`: 지정된 속성에 대한 자격 증명을 제거하라는 요청
