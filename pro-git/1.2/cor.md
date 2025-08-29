# 1.2 git의 간략한 역사

## 학습목표
- 깃의 탄생 배경 알기
- 깃이 지향하는 철학 알기

## 원문 번역
```
삶에서의 많은 훌륭한 것들과 같은 방식으로, git은 약간의 창조적인 파괴와 열화와 같은 논란과 함께 시작되었다.

리눅스 커널은 상당히 큰 규모의 오픈소스 소프트웨어 프로젝트이다. 리눅스 커널 유지보수의 이른 시절 (1991-2002) 동안, 이 소프트웨어에 대한 변경사항은 패치와 아카이브 파일로 전파되었다. 2002년에, 리눅스 커널 프로젝트는 BitKeeper라는 사유 DVCS를 사용하기 시작했다.

2005년에, 리눅스 커널을 개발했던 커뮤니티와 BitKeeper를 개발했던 영리회사 사이의 관계가 끝났고, 이 프로그램의 무료 사용 상태가 폐지되었다. 이는 리눅스 개발 커뮤니티 (그리고 특히 리눅스의 창조자인 리누스 토르발스) 로 하여금 그들만의 프로그램을 그들이 BitKeeper를 사용하는 동안 배운 경험들의 일부에 기반해 개발하도록 촉구하였다. 이 새로운 시스템의 목표 중 일부는 다음과 같다.

- 속도
- 단순한 설계
- 비선형적 개발에 대한 강력한 지원 (수천개의 병행하는 브랜치들)
- 완전히 분산됨
- 리눅스 커널과 같은 큰 프로젝트를 효율적으로 다룰 수 있음 (속도와 데이터 크기)

2005년에 git이 탄생한 이래로, git은 사용하기 쉽게 진화해왔고 성숙해졌으며 아직 이 초기의 특징들을 보유하고 있다. git은 놀랍도록 빠르고, git은 거대한 프로젝트에 대해 매우 효율적이며, git은 비선형적 개발에 대해서 믿을 수 없을 정도로 좋은 브랜칭 시스템을 가지고 있다. (브랜칭 시스템에 대해서는 3장 참조)
```
### 영어 공부
- as with = in the same way as
- pass sth around = to offer sth to each person in a group of people
- proprietary[프러프라이어테리] = 사유의. relating to an owner or ownership
- break down = 중단되다. (of a relationship, agreement, or process) cease to continue; collapse
- revoke = 폐지하다. put an end to the validity or operation of (a decree, decision, or promise)
- prompt = 촉구하다. (of an event or fact) cause or bring about (an action or feeling)

## 요약
### 탄생 배경
git은 2005년에 리누스 토르발스가 만들었으며 만들어진 이유는 사용할 새로운 버전관리시스템이 필요해졌기 때문임.

### 철학
속도, 비선형적 개발, 분산