# 3.4 브랜치를 사용한 작업 흐름

## 학습목표
- 브랜치를 활용한 개발 흐름을 이해한다.
- 이러한 개발 흐름이 완전히 local이어서 서버와 통신하지 않음을 이해한다.

## "점진적 안정성 브랜칭 모델"
- master 브랜치, develop 브랜치, topic 브랜치로 구분
- master 브랜치와 develop 브랜치는 장기적으로 유지되는 브랜치인 반면 topic 브랜치는 짧게만 존재하는 브랜치
- master 브랜치에는 완전히 안정적인 코드만 유지
- develop 브랜치에는 작업하는 코드가 있음. 안정적인 상태가 되면 master 브랜치에 병합됨.
- topic 브랜치에는 특정한 작업에 대한 코드가 있음. 준비가 되면 develop 브랜치에 병합됨.
- 한마디로 각 브랜치는 일종의 저장창고이며 일정수준이 되면 다음 창고로 진급하는 것임
- 위와 같은 "3개의 안정성 수준" 말고도, 이론상 n개의 안정성 수준을 사용할수도 있음. 예: pu 브랜치를 master와 develop 사이에 유지.
- 이와 같은 모델을 반드시 써야하는것은 아님. 그러나 때때로 도움이 될 수 있음.

## "토픽 브랜치 모델"
- 프로젝트의 규모에 상관없이 유용
- 하나의 특정한 기능에 대해 사용하는, 짧게 존재하는 브랜치.
- 작업하고 있는 내용이 별도의 "창고"에 들어있는 것이므로, 작업 간에 맥락 전환이 자유로움

## 영어 공부
- incorporate = 포함하다. take in or contain (something) as part of a whole; include.
- embrace = 수용하다. accept or support (a belief, theory, or change) willingly and enthusiastically.
- silo[사일로] = 저장고