# 7.14 자격증명 보관소

## 학습목표
- `git credential`으로 credential storage 기능을 사용하는 방법을 숙지한다.

## 개요
- ssh를 사용해 서버와 통신한다면 비번 없는 key 가지기 가능
- 그러나 http는 아뒤비번을 매번 요구하고, 2fa의 경우 비번이 랜덤생성되고 unpronounceable함 (외우기 힘들다는 의미인듯)
- 이런 번거로움을 해결할 수 있는 credential-helper system이 있음
   - 기본값 = 캐시 안하기 (매번 아뒤 비번 치기)
   - "cache" 모드 = 메모리에 자격증명을 일정기간 저장. 비번은 절대 disk에 저장되지 않고 15분 지나면 사라짐.
   - "store" 모드 = 자격증명을 disk상에 plaintext로 저장. 만료되지 않음. **home 디렉토리 내 일반파일에 평문으로 저장됨.**
   - macOS의 경우, "osxkeychain" 모드 = 시스템계정에 딸린 secure keychain에 저장. disk에 저장 / 만료 X / 암호화됨
   - Windows의 경우, "Git Credential Manager" 활성화 가능 => osxkeychain과 유사하나 Windows Credential Store 사용 / WSL에서도 사용 가능

## 헬퍼 설정법
- `git config --global credential.helper <helper>`
- 이러한 helper들 중에는 옵션을 취하는 것도 있음
- store 헬퍼의 경우 기본적으로 `~/.git-credentials`에 저장하나 `--file <path>`로 경로 지정 가능
- cache 헬퍼의 경우 기본적으로 900초동안 데몬이 돌아가나 `--timeout <seconds>`로 시간 지정 가능
- 여러개의 헬퍼를 지정할수도 있음
   - 자격증명을 질의할때는 순차적으로 진행되고 첫번째 답변이 제공되면 멈춤
   - 자격증명을 저장할때는 모든 헬퍼에 아뒤/비번을 보냄
- `credential.helper` 값이 해석되는 방식
   - `prog --opt=test` => `git credential-prog --opt=test`
   - `/path/prog -opt` => 해당 경로의 프로그램을 실행
   - `!f() { echo "password=s3cre7"; } f` => `!` 뒤의 코드가 쉘에서 평가됨

```bash
# 예시 설정
# usb가 안 꽂혀있으면 in-memory cache 사용하도록 설정됨
[credential]
   helper = store --file /mnt/thumbdrive/.my-secret-cred
   helper = cache --timeout 30000
```

## credential 명령어
- `git credential (fill|approve|reject|capability)`
- cred-helper system의 root 명령어
- subcommand를 인자로 받고 stdin로부터 "credential description"을 읽음
- helper를 실행하는데 이것은 git과는 별도의 프로그램임
- 어떤 helper를 어떻게 실행할지는 `credential.helper` 값에 달려있음

### fill 하위명령어
- `fill`은 config 파일을 읽거나, 설정된 자격증명 헬퍼를 실행하거나, 사용자에게 물어봄으로써 "username"과 "password" 항목을 description에 추가하려고 시도함
- 먼저 내가 알고 있는 정보로 credential description을 작성해야 함
- 한 줄에 하나의 필드=값을 지정하고, 알고있는 모든 정보를 다 쓴 뒤에는 빈 줄을 배치하면 됨
- git이 아뒤/비번을 알고있을 경우 여기에 관련된 정보가 다 나옴
- 모를 경우 입력이 prompt됨

## 헬퍼 프로그램
### 사용법
- `git credential`과 동일한 stdin/stdout 프로토콜 사용
- `git-credential-prog [args] <action>`
   - `get`: 아뒤 및 비번 요청 / 아는 바가 있다면 저장되어있는 정보에 제공된 정보를 포함해 응답 / 없다면 응답 없어도 됨
   - `store`: 본 헬퍼의 메모리에 자격증명을 저장하라는 요청 / 응답이 요구되지 않음
   - `erase`: 주어진 property에 대해 본 헬퍼의 메모리에서 자격증명을 삭제 / 응답이 요구되지 않음

### 기타
- osxkeychain과 wincred는 별도 native format 사용
- cache는 별도 in-memory format 사용 (다른 프로세스가 읽을 수 없음)

## 사용자 정의 헬퍼 프로그램
- 내 상황에 맞는 헬퍼 프로그램을 작성해서 사용 가능
- 작성시 유의할 점:
   - `get`, `store`, `erase` 를 구현
   - store와 erase는 write 작업
   - 공유되는 자격증명 파일의 format은 `git-credential-store`에서 사용되는 것과 일치
   - 자격증명 파일의 경로를 옵션으로 지정할 수 있도록 처리
- 특정한 언어로 프로그램을 작성해야 하는 것은 아니며 최종 결과물을 깃이 실행할수만 있으면 됨
- 프로그램명을 `git-credential-<name>`으로 지은 후 환경변수(PATH)에 해당 프로그램이 있는 경로를 지정하고 실행파일로 지정한다
   - 프로그램명이 `git-sth`이고 PATH에서 찾을 수 있으면 `git sth`로 해당 프로그램을 호출할 수 있는 것으로 보임
   - 프로그램명이 `git-credential`로 시작하니까 `credential.helper`에 `<name> <opt>` 양식으로 값을 지정할 수 있는 것으로 추정됨 (gitcredentials 문서 참조)

## 영어 공부
- unpronounceable[언프러나운서블]: 발음하기 너무 힘든
- augment[오그멘트]: 늘리다, 증가시키다
- take over (from sb): ~로부터 ~를 인계받다
- purge[펄쥐]: <purge+목+of+명>
   - (sb나 sth에게서) 원치 않는 성질, 조건, 감정 따위를 없애다(자유롭게 하다)
   - (조직이나 장소에서 원하지 않는 사람을 갑작스럽거나 폭력적인 방식으로) 제거하다; 숙청
- rid[리드]: <rid+목+of+명> (sb나 sth을 골칫거리나 원하지 않는 사람/사물로부터) 자유롭게 하다
- clear[클리얼]: <clear+목+of+명> <clear+목+from/off+명> A에서 B를 치우다
