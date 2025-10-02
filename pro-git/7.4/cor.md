# 7.4 작업에 서명하기

## 학습목표
- gpg 키를 만드는 방법을 이해한다.
- 작업에 서명하는 방법을 숙지한다.

## 개요
- 인터넷에서 받은 작업이 믿을 수 있는 출처로부터 온 것인지 확인하고 싶을 수 있음
- GPG를 사용해 작업에 서명하거나 작업을 검증할 수 있는 방법을 git에서 제공함

## GPG 사용법
- 서명을 하려면 우선 GPG key가 있어야 함
- `gpg --list-keys` 로 키 목록 확인 가능
- 사용할 키가 없다면 `gpg --gen-key`로 생성 가능
- 사용할 키를 .gitconfig에 작성 => `git config --global user.signingkey <key>`
   - <key> 부분에 들어가야 할 내용은 `gpg --list-keys --keyid-format=long` 을 하면 보이는 듯 (16자리)
   - 맨 마지막 8자리만 해도 되는 것 같음
   - <key> 부분은 gpg에 바로 전달된다는 것 같음. (매뉴얼 참고)
   - <key> 뒤에 느낌표를 붙이면 명시된 primary나 secondary 키를 사용하라고 강제하는 의미인 것 같음 (gpg 매뉴얼 참고)
- 이 키가 커밋과 태그에 서명하는데 사용됨

## 태그에 서명하기
- `-a (--annotate)` 대신 `-s (--sign)` 옵션 사용하면 됨 => `-a`는 unsigned 태그를 만듦
- GPG-서명된 태그를 `git show <tag>` 하면 내 GPG signature가 tag에 첨부되어 있는 것을 확인할 수 있음

## 태그를 검증하기
- GPG를 사용해 signature를 검증하기 => `git tag -v (--verify)`
- signer의 public key가 내 keyring에 있어야 정상 작동함

## 커밋에 서명하기
- 일반 커밋에 서명하기 => `git commit -S (--gpg-sign)`
- 머지 커밋에 서명하기 => `git merge -S (--gpg-sign)`

## 커밋을 검증하기
- 커밋의 signature 검증하기 => `git log --show-signature`
- signature의 상태를 표시하기 => `git log --pretty="format:%G?"`
- signed되지 않았거나 valid하지 않은 커밋이 포함되어 있으면 병합 거부하기 => `git merge/pull --verify-signature <branch>`

## 기타
- 기본적으로 모든 커밋 서명하기 => `git config --local commit.gpgsign true`
- 만들때 서명하지 않았던 커밋도 나중에 rebase를 통해서 서명할 수 있는 것 같음

## 영어 공부
- foolproof: 잘못될 염려가 없는
- signature[시그너처]: 서명; 특징