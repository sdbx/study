# 7.12 번들링

## 학습목표
- 번들링을 통해 깃 데이터를 주고받는 방법을 이해한다.

## 번들링이란
- 깃 데이터를 전달할 수 있는 방법 중 하나
- 번들링을 통해 (통상적으로는 git push로 전송될) 깃 데이터를 하나의 바이너리 파일로 만들 수 있음
- bundle => 전송(이메일이든 usb든) => un-bundle
- 공유된 레포지토리가 없거나 적절한 네트워크가 없을 때 내 작업을 공유하고 네트워크가 연관된 작업을 하는데 유용함

## 번들링하는 법
```bash
$ git bundle create <name> [HEAD] <branch>...
```
- 예를 들어 master 브랜치를 명시하면 master 브랜치를 재생성하는데 필요한 모든 데이터가 들어감
- 포함하고자 하는 레퍼런스나 특정 범위의 커밋들을 지정해야 함
   - 범위 지정은 이전에 배웠던대로 `origin/main..main` 이나 `main ^origin/main` 이런식으로 하면 됨
- 이 번들링이 clone될 의도라면 HEAD를 레퍼런스로 지정해줘야 함

## 번들 검사하기
```bash
# 뭐가 들어 있는지 점검
# 유효한 번들인지, 번들을 재구성하는데 필요한 조상커밋을 내가 가지고 있는지
$ git bundle verify <bundle>

# 번들에 포함된 브랜치 목록 보기
$ git bundle list-heads <bundle>
```

## 번들에서 데이터 꺼내기
```bash
# 번들 clone하기
# HEAD가 포함되어 있지 않다면 `-b <branch>`로 checkout할 브랜치를 지정해줘야 함
$ git clone <bundle> <dirname>

# 번들에서 fetch 및 pull 가능
# import된 커밋들이 bundle-main 브랜치에 있게 됨
$ git fetch <bundle> main:bundle-main
```
