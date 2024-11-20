<h1 align="center">
기차 예매 서비스
</h1>

## 프로젝트 개요

### “기차 예매 서비스" 는 필수기능이 적용된 프로그램입니다.

<br/>

## 팀원 구성(개인 과제)

| **박은혜** |
| :--------: |

### 프로젝트 일정

24/11/11 ~ 24/11/20

<br/>

### <트러블 슈팅>

═══ Exception caught by widgets library ═══
Incorrect use of ParentDataWidget.

UI를 구성하는 과정에서 오류가 발생함
이 오류는 특정 위젯들이 올바른 부모 위젯 내에 배치되지 않았을때 나타남

##### 오류 원인

1. <b>Expanded나 Flexible 위젯</b>이 Row, Column, Flex 같은 위젯의 직접적인 자식이 아닐 때 발생
2. <b>Positioned 위젯</b>이 Stack의 직접적인 자식이 아닐 때 발생.
