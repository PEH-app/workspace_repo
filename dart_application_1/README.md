
<h1 align="center">
ShoppingMall console program
</h1>
<p align="center">
</p>
    <img alt="브로셔 이미지" src="https://github.com/PEH-app/workspace_repo/blob/main/dart_application_1/assets/image/11.png"/>

## 프로젝트 개요

### “ShoppingMall" 은 필수기능 + 도전기능(1번까지)이 적용된 콘솔 프로그램 입니다.

#### 💡 아래의 기능이 들어있습니다.

> [1] 판매하는 상품 목록을 볼 수 있는 기능

> [2] 구매자가 구매하고 싶은 상품들을 장바구니에 담을 수 있는 기능

> [3] 구매자가 장바구니에 담은 상품들의 총 가격을 볼 수 있는 기능

> [4] 쇼핑몰 프로그램을 종료할 수 있는 기능

> [5] 도전 : 쇼핑몰 프로그램을 종료할 시 한번 더 종료할 것인지 물어보는 기능

<br/>

## 팀원 구성(개인 과제)

| **박은혜** |
| :--------: |

### 프로젝트 일정

캠프 1주차
dart 문법 기초
24/10/28 ~ 24/11/1

<br/>

<br/>

## TroubleShooting

#### 윈도우 프롬프트에서 한글 입력시 깨짐 문제

- 문제 : 장바구니에 담을 상품 입력 시 정상 입력임에도 작동이 되지 않음
- 해결 시도: print해보니 입력한 한글 글자가 깨져서 입력됨
- 해결책 <br/>
  (1) 구글 검색 결과 프롬프트 자체 encoding 문제일 수 있다며 chcp 949를 chcp 65001로 입력하여 UTF-8로 변경해야 함을 알게 됨<br/>
  (2) 그래도 되지 않아서 또다시 검색 결과 stdin.readLineSync(encoding:Encoding.getByName('utf-8')!); 이런 코드를 알게 됨<br/>
  (3) 각자 해봤음에도 되지않아서 어려움을 겪던 와중에 두개를 동시에 적용해보니 한글 깨짐이 해결됨<br/>
