# A3.5 프로젝트 공유와 갱신

## 학습목표
- 다음의 명령어들을 복습한다.
```bash
git fetch
git pull
git push
git remote
git archive
git submodule
```

## 요약
- git fetch
   - 원격 서버와 통신해 서버에는 있는데 내쪽에는 없는 것을 받아와 로컬 데이터베이스에 저장
   - 풀리퀘스트를 받아올수도 있고 번들파일에서 받아올수도 있음
- git pull
   - 일반적으로 fetch와 merge의 조합
   - `--verify-signatures`
- git push
   - 내쪽엔 있는데 상대쪽엔 없는것을 전송
   - 쓰기권한과 일반적으로 인증을 요구
   - `--delete` => 원격 브랜치 삭제
- git remote
   - 원격저장소에 대한 정보 관리
- git archive
   - 프로젝트의 특정 스냅샷의 압축파일을 만들기
- git submodule
   - 한 저장소 내에서 외부 저장소 관리하기
