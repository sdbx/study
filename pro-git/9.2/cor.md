# 9.2 깃으로 전환하기

## 학습목표
- 타 VCS에서 git으로 migrate하는 방법에 대해 알아본다.
- 커스텀 임포터 구축방법에 대해 알아본다.

## 서브버전의 경우
- 이전 장에서 설명된대로 `git svn clone`한뒤 새로운 깃 서버에 푸쉬하면 됨
- 이력도 import하려면 다소 시간이 걸리며 불완전하므로 처음부터 제대로 하는 것이 좋겠음
   - author 정보를 제대로 가져오려면 svn 유저와 git author를 대응시키는 매핑파일 준비해야함
   - svn 메타데이터 (git-svn-id 등) 을 제외하고 가져오려면 `--no-metadata`를 clone이나 init에 제공
- import를 한 뒤에 뒷정리를 좀 해줄필요가 있음
   - 태그와 브랜치를 정리
   - `@xxx`가 붙은 브랜치는 svn의 기능인 peg-revision의 흔적으로 필요없으면 지워라
   - truck를 master로 이름을 바꿔라

## 머큐리얼의 경우
- hg-fast-export 툴을 사용한다
- author 매핑파일을 준비한다
- 브랜치나 태그명의 rename이 필요할때도 같은 양식의 매핑파일이 사용됨

## 퍼포스의 경우
### 깃 퓨전을 통해
관련된 환경설정을 한 뒤 클론하면 된다.

### git-p4를 통해
- 필요시 `--detect-branch`를 `git p4 clone`에 전달해 모든 브랜치 import
- 커밋메시지에 남아있는 식별자를 지우고 싶으면 `git filter-branch --msg-filter` 활용

## 사용자 정의 import
- 정말 사용자 정의 import 절차가 필요할 경우 `git fast-import` 명령어가 존재함
- git-fast-import는 stdin에서 명령을 읽어서 특정한 git data를 작성함
- 이 명령어에서 사용되는 mark라는 용어의 뜻 = 커밋에 주는 식별자로, 정수임.
- 내 상황에 맞춰 적절하게 명령어를 생성하고 그걸 fast-import에 pipe하면 되는 구조인 것으로 보임
- 주의점으로, fast-import는 오직 lf만을 기대하기 때문에 crlf를 사용하면 안됨
- 이외에도 다양한 기능이 fast-import에 있음

## 영어 공부
- one way or another: 어떻게 해서든지
- come by: (간신히) 얻다. manage to acquire or obtain something.
- (and) that's all there is to it: 그게 전부다
- en masse[언 매스]: 집단으로
