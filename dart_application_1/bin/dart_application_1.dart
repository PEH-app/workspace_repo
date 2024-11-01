import 'dart:convert';
import 'dart:io';

import 'package:dart_application_1/dart_application_1.dart'
    as dart_application_1;

//쇼핑몰 정의
class ShoppingMall {
  List<Product> listName = []; // 판매하는 상품 목록
  int cartTotal = 0; //장바구니에 담은 상품들의 총 가격

  ShoppingMall(this.listName, this.cartTotal);

//상품 목록을 출력하는 메서드
  void showProducts() {
    for (int i = 0; i < listName.length; i++) {
      print('${listName[i].productName} / ${listName[i].price}원');
    }
  }

//상품을 장바구니에 담는 메서드
  void addToCart() {
    print('상품 이름을 입력해 주세요 !');
    String? addName = stdin.readLineSync(
        encoding:
            Encoding.getByName('utf-8')!); //한글입력시 깨짐 해결 + 프롬프트에 chcp 65001

    print('상품 개수를 입력해 주세요 !');
    String? addCount = stdin.readLineSync()!;

    bool b = listName.any((n) {
      return n.productName == addName;
    });

    int count = 0;
    if (!b) {
      print('입력값이 올바르지 않아요 !');
      return;
    } else {
      try {
        count = int.parse(addCount);
        if (count <= 0) {
          print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
          return;
        }
      } catch (e) {
        print('입력값이 올바르지 않아요 !');
        return;
      }
    }

    cartTotal += listName.firstWhere((n) {
          return n.productName == addName;
        }).price *
        count;

    print('장바구니에 상품이 담겼어요 !');
  }

// 장바구니에 담은 상품의 총 가격을 출력하는 메서드
  void showTotal() {
    print('장바구니에 $cartTotal원 어치를 담으셨네요 !');
  }
}

// 상품 정의
class Product {
  String productName = ''; // 상품 이름
  int price = 0; // 상품 1개당 가격

  Product(this.productName, this.price);
}

void printShopping() {
  print(
      '------------------------------------------------------------------------------------------------');
  print('[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료');
  print(
      '------------------------------------------------------------------------------------------------');
}

void main(List<String> arguments) {
  ShoppingMall shoppingMall = ShoppingMall([
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000)
  ], 0);

  bool quit = false;

  while (!quit) {
    printShopping();
    String? str = stdin.readLineSync();

    switch (str) {
      case '1':
        shoppingMall.showProducts();
        break;
      case '2':
        shoppingMall.addToCart();
        break;
      case '3':
        shoppingMall.showTotal();
        break;
      case '4':
        print('[5] 정말 종료하시겠습니까?');
        String? str2 = stdin.readLineSync();
        if (str2 == '5') {
          quit = true;
          print('이용해 주셔서 감사합니다 ~  안녕히 가세요 !');
        } else {
          print('종료하지 않습니다.');
        }
        break;
      default:
        print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
    }
  }
}
