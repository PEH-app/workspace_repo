<h1 align="center">
전투 RPG 콘솔 게임
</h1>

<img alt="브로셔 이미지" src="https://github.com/PEH-app/workspace_repo/blob/main/dart_game/assets/images/game_1.png">
<br>
<img alt="브로셔 이미지" src="https://github.com/PEH-app/workspace_repo/blob/main/dart_game/assets/images/game_2.png"/>
<br>
<img alt="브로셔 이미지" src="https://github.com/PEH-app/workspace_repo/blob/main/dart_game/assets/images/game_3.png"/>

## 프로젝트 개요

### “전투 RPG 게임" 은 필수기능 + 도전기능(1번까지)이 적용된 콘솔 프로그램 입니다.

#### 💡 아래의 기능이 들어있습니다.

> [1] 파일로부터 데이터 읽어오기 기능

> [2] 사용자로부터 캐릭터 이름 입력받기 기능

> [3] 게임 종료 후 결과를 파일에 저장하는 기능

> [4] 주의사항 적용

> [5] 도전 : 캐릭터의 체력 증가 기능 추가

<br/>

## 팀원 구성(개인 과제)

| **박은혜** |
| :--------: |

### 프로젝트 일정

dart 심화 <br>
24/11/04 ~ 24/11/08

<br/>

### <트러블 슈팅>

#### TXT파일의 경로설정 문제

> **🔍`[문제발생]`**
>
> - IDE 디버그 콘솔에서는 정상 작동
> - 명령프롬프트에서는 문제가 발생

<br>
문제는 바로 수정하긴 했지만 글로 정리해 보았다.
<br>

---

**🔍`[적용]`**

명령 프롬프트와 디버그 콘솔에서 파일 경로가 다르게 작동하는 이유는 주로 **현재 작업 디렉토리(current working directory) 차이** 때문.

- 디버그 콘솔: 일반적으로 IDE(예: vs code)에서 디버깅을 할 때, 현재 작업 디렉토리는 **프로젝트의 루트 디렉토리**로 설정된다. 따라서 상대 경로로 파일을 참조할 때, 프로젝트 루트에서 시작하게 된다.

- 명령 프롬프트: 명령 프롬프트에서 프로그램을 실행할 때, 현재 작업 디렉토리는 **명령을 실행한 위치**가 된다. 만약 프로젝트 루트가 아닌 다른 디렉토리에서 실행했다면(bin 폴더에서 dart run 하는 경우), 경로가 올바르지 않을 수 있다.
  명령 프롬프트에서 프로그램을 실행할 때 프로젝트 루트 디렉토리에서 실행하는 방법 : (dart run bin/game_project.dart)

<br>

**프로젝트 구조**

```
game_project/
├── bin/
│   └── dart_game.dart
├── asset/
│   ├── monsters.txt
│   └── characters.txt
└── lib/
```
