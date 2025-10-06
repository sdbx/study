# 7.10 Git Tools - Debugging with Git

## blame

`git blame <file>`: 파일 각 줄이 언제 수정되었는지 보여줌

- 문제가 발생한 위치를 알고 있을 때 유용
- 마지막으로 수정한 커밋의 SHA-1 일부, author name, authored date, 줄 번호, 줄 내용 표시
- SHA-1앞에 `^`가 붙으면 저장소의 맨 첫 커밋이라는 뜻
- `-L <range>`: 주어진 범위의 줄만 표시, 또는 `:<funcname>`. 여러번 지정 가능
- `-M`: 같은 파일 안에서 이동한 줄 감지
- `-C`: `-M`에 추가로, 같은 커밋에서 수정된 다른 파일에서 이동한 줄 감지

## bisect

`git bisect`: 이진 탐색으로 버그가 발생한 커밋을 빠르게 찾는 도구

- 문제가 발생한 커밋을 모를 때 유용
- `start [<bad> [<good>]]`: 시작. bad 커밋과 good 커밋을 미리 지정 가능
- `bad [<rev>]`: 커밋을 bad로 표시
- `good [<rev>]`: 커밋을 good으로 표시
- `skip [(<rev>|<range>)...]`: 테스트 할 수 없는 경우 건너뛰기
- `run <cmd> [<arg>...]`: 테스트 스크립트를 자동 실행. 0으로 종료되는 경우 good, 125로 종료되는 경우 skip, 나머지는 bad로 표시
- `reset`: 끝난 후, 이진 탐색 상태를 정리하고, 처음 HEAD로 돌아감
