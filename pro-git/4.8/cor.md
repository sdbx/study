# 4.8 GitLab

## 학습목표
- GitLab이 무엇인지 이해한다.

## 요약
- GitLab은 현대적이고 기능이 다 갖춰진 git 서버임
- 데이터베이스를 사용하는 웹 어플리케이션
- 깃랩 서버를 사용하는 모든 사람은 계정이 필요함
- 각 유저 계정은 namespace를 가지고 있으며, 이 유저에게 속한 프로젝트들의 논리적 분류임.
   - 예: http://server/cor/emdee
- 유저 차단/삭제 가능
- gitlab group이란 프로젝트들의 모임임.
   - 예: http://server/mygroup/study
- hook 기능이 있어서 관련된 event가 발생했을때 http post를 수행함. 개발 자동화에 유용함 (채팅방, 개발툴 등)
- merge request 기능을 사용하면 제어된 방식으로 협업할 수 있음
   - 어떤 프로젝트에 push permission이 없다면 해당 프로젝트를 fork하여 자신만의 copy를 생성
   - 해당 copy에서 작업 및 커밋 생성
   - 해당 fork에서 원본 프로젝트에 merge request를 생성
   - 즉, 관리자로 하여금 무엇이 언제 repo로 들어가는지 full control하므로 untrusted user와도 협업을 가능하게 함
- mr과 issue는 long-lived discussion
   - 각 mr은 line-by-line discussion이 가능 (가벼운 코드리뷰)
   - 전체적인 discussion thread 존재
   - mr과 issue 둘다 user에 할당될수도, milestone으로 구조화될수도 있음
- 이밖에 git과 관련되지 않은 기능도 있음
   - project wiki
   - system maintenance tool

## 영어 공부
- simplistic: 지나치게 단순화한 (복잡한 문제를 실제보다 단순하게 여기는 것)
- involved: 복잡한 (difficult to comprehend; complicated)
- tweak: 기계나 수치같은걸 약간 수정하다