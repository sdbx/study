# 9.1 클라이언트로서의 깃

## 학습목표
- 깃을 경유해 타 VCS를 사용한다는 개념을 이해한다.

## 깃을 클라이언트로 사용하기
- 팀이 다른 vcs를 쓰고 있더라도 나는 git을 쓸 수 있음
- 그러려면 어댑터를 거쳐야 함. 이런 어댑터를 두고 "브릿지"라고 함

### 깃과 Subversion
- subversion (이하 svn) = 한때 사실상 표준이었던 vcs (이거 이전에는 cvs가 유명했음)
- `git svn`: 깃과 svn간 양방향 브릿지
   - 마치 svn을 로컬에서 사용하고 있는 것처럼 깃의 모든 로컬 기능을 사용 가능
   - 그러나, git과 svn은 아주 다른 체계
   - 브랜칭/머징을 할수는 있지만 왠만해서는 리베이싱해서 이력을 선형적으로 유지하는게 최고
   - 원격 저장소와 interact하는건 피하는게 좋음
   - 이력 재작성 하지마 / 다시 푸쉬하려고 하지마 / 평행한 깃 저장소에 푸쉬하지마
   - svn은 오직 하나의 선형적인 이력만 가질 수 있으며 svn을 혼란스럽게 만드는 것은 매우 쉬움
   - 모두가 svn 서버를 통해 협업하는게 스트레스가 덜할것임
- 보니까 깃의 사용법하고 다소 차이있는 부분이 많은거같음 실제로 git svn 명령어를 쓰게된다면 잘 읽어보고 해야할듯함
- `git svn`은 여러개의 subcommand를 가지고있음
   - **dcommit**, clone, rebase, branch, log, blame, info, create-ignore, show-ignore 등
- **요약**
   - git merge에 의한 머지커밋을 포함하지 않는 선형적인 깃 이력을 유지하라. 리베이스하라.
   - 별도의 깃 서버에서 협업하지 마라. 설령 하더라도 `git-svn-id` 항목이 없는 것을 푸쉬하지 마라.

### 깃과 Mercurial
- 깃만이 유일한 DVCS가 아님. 머큐리얼(이하 hg)도 분산적이고 깃과 hg는 많은 부분에서 비슷함. (mercury = 수은 = Hg = 원자번호 80)
- `git-remote-hg`: 깃과 hg간 양방향 브릿지
- `.git/refs`에 보면 `hg/`가 있는데 여기가 실제 remote ref가 보관되는 곳임
   - git-remote-hg가 내부적으로 사용하는 것으로 보임
- ignore 파일 처리의 경우, `cp .hgignore .git/info/exclude` 하면 끝인 듯 (hg 포맷이 깃과 호환됨)
- 깃에서의 브랜치를 hg에서는 **북마크[bookmark]**라고 하고, hg에서의 "브랜치" 개념이 따로 있음
   - hg에서의 브랜치의 경우, changeset이 만들어진 브랜치가 **changeset과 함께** 기록됨
- hg에서는 이력 재작성이 안되고 오직 추가만 됨
   - 만약 깃에서 인터랙티브 리베이스하고 포스푸시하면 hg에서 작업하는 팀원들이 혼란스러움
   - 하지마라
- **요약**
   - git과 hg는 충분히 유사해서 경계 너머로 작업하는 것이 상당히 고통없음
   - 이미 내 컴퓨터를 떠난 이력을 변경하지만 않으면 됨 (일반적으로 권장됨)

### 깃과 Perforce
- 회사환경에서 아주 유명한 vcs로 1995년부터 있었음
- 사용자가 항상 하나의 단일중앙서버에 연결되어있고 오직 하나의 버전만이 로컬디스크에 유지된다고 가정함
- 퍼포스의 브랜칭 체계는 깃과 전혀 다름
- 퍼포스의 기능과 제약사항들이 몇가지 특정한 문제에는 적합한 것은 사실임
- 깃에서 퍼포스를 쓰는 2가지 방법이 있음
   - Git Fusion: 퍼포스 제작자들이 만든 브릿지로, perforce depot에서 subtree를 read-write 깃 저장소로 노출시킨다.
   - git-p4: 클라측 브릿지. 퍼포스 서버에서 환경설정을 다시 할 필요 없이 깃을 퍼포스 클라이언트로 사용할 수 있게 해준다.
- 깃 퓨전
   - 서버측에서 퍼포스 서버와 깃 저장소를 동기화한다
   - 퍼포스와 깃 사이의 two-way 브릿지
   - **요약**
      - 환경설정을 좀 해야 하긴 하지만 깃과 퍼포스를 이어주는 좋은 방법
      - 이력 재작성하려고 하면 거절될 것임
      - native 처럼 느껴짐
      - 서브모듈 사용 가능하나 퍼포스 유저에게는 이상하게 보일 것
      - 브랜치 병합 가능 (퍼포스 측에서는 integration으로 기록됨)
- git-p4
   - 퍼포스와 깃 사이의 two-way 브릿지
   - 전적으로 나의 깃 저장소 내에서 실행됨
   - 깃 퓨전에 대한 완전한 대안은 아니나 서버환경을 깊게 파고들지 않고 대부분의 것들을 할수있게 해줌
   - 여러가지 subcommand를 사용하는 듯
      - clone, sync, rebase, submit
   - 머지커밋을 submit하려고 하면 알아서 rebase해서 선형적 히스토리 만드는 듯
   - 브랜치를 생성하거나 통합하려면 퍼포스 클라이언트를 사용해야만 한다는 듯
   - **요약**
      - git-p4는 퍼포스 서버에서 git workflow의 사용을 가능케 함
      - 그러나 소스코드를 관리하는건 퍼포스이며 깃은 단지 local에서 작업하기 위해 사용하는 것임
      - 다른 사람들이 쓰는 원격이 있다면 퍼포스 서버에 올라간적이 없는 커밋을 올리지 마라.
      - 정말 자유롭게 퍼포스와 (클라이언트로서의) 깃을 섞어쓰고 싶다면 깃 퓨전을 쓰는 게 좋을 것이다.

## 영어 공부
- in the wild: (비유적으로) 일상적인 상태에 있는
- corporate[코-올퍼럿]: 회사의
- gateway drug: (마약 중독에 이르는) 초기 약물
- much as: although, however much
   - Much as I would like to help you, I'm simply too busy at the moment.
   - Much as I had enjoyed my adventure, it was good to be back.
- litter[리터]: 흩어져 어지럽히다
- cripple[크리플]: 불구자로 만들다; 손상시키다(impair), 무능하게 하다(disable), 약하게 하다(weaken)
- bearable[베러블]: 견딜 만한
- bear[베어]: 참다, 견디다, (책임) 감당하다, (무게) 지탱하다
- enough that: so that
- slew[슬루]: 많음, 다수, 대량
- esque[에스크]: ~풍[식]의. in the style of; resembling
- attend to: deal with
- compatible[컴패터블]: 호환이 되는
- well-suited to[웰 수-티드]: ~에 적합한
- to be sure: 뭔가가 틀림없다, 분명하다
- depot[디포우]: (대규모) 창고
- surface[설피스]: emerge. 수면으로 올라오다; (한동안 숨어있던 것이 갑자기) 드러나다, 표면화되다
- analogy[어낼!러지]: 비유, 유추
- draw/make an analogy between: to compare so as to find a likeness
- likeness[라이크너스]: 유사성, 닮음; (그림) 화상
- first-class: 최고(수준)의, 1등석의
