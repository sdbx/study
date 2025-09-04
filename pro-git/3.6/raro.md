# 3.6 Git Branching - Rebasing

## Rebase 요약

rebase는 말 그대로 base를 재설정(옮기는)하는 것

### rebase 이해

- target, base, topic 브랜치가 있다고 하면 (깃 용어는 아님)
- rebase = topic을 base를 기준으로 분리해서 target에 가져다 놓음
- `git rebase [--onto target] <base> [topic]`
- target의 기본값은 base
- topic의 기본값은 현재 브랜치

#### 예시

```bash
# 현재 브랜치를 main을 기준으로 main으로 옮김
git rebase main

# client 브랜치를 main을 기준으로 main으로 옮김
git rebase main client

# 현재 브랜치를 main을 기준으로 dev로 옮김
git rebase --onto dev main

# client 브랜치를 server를 기준으로 main으로 옮김
git rebase --onto main server client
```

### 실수 방지 및 복구

- 로컬을 벗어나서 다른 사람이 작업할 수 있는 커밋은 rebase하지 않기
- 이미 저질렀다면
  - `git rebase origin/xxx`를 하면 실수로 rebase한 것을 다시 선형으로 만들 수 있음
    1. 서버에 없는 커밋들 중
    2. 병합 커밋이 아니고
    3. 서버 커밋과 patch-id가 다른 커밋만
    4. 모아서 origin/xxx 위에 적용
  - patch-id: 변경 사항에 대한 checksum

## 영어 공부

- end up with A: (결국) A를 가지게 되다 / A와 함께하게 되다
- whether A or B: A든 B든
- whereas: 앞은 ~인 반면에 뒤는 ~이다.
- as if A: A인 것처럼
- peril [ˈperəl]: (명) 위험, 위험성
- bliss [blɪs]: (명) 지복, 더없는 행복
- sum up: 요약하다
- scorn [skɔːrn]: (명) 경멸(감), (동) 경멸하다
- in a pickle: 곤경에 처한
- in the first place: 애초에
- find oneself: (나도 모르게) ~한 사실을 깨닫다
- turn out: ~한 것으로 판명나다
- frustrating [ˈfrʌstreɪtɪŋ]: (형) 불만스러운
- blasphemous [ˈblæsfəməs]: (형) 불경스러운, 모독적인
