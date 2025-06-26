import 'dart:io';

class ShoppingMall {
  List<Product> items = [];
  int totalPrice = 0;
  List<CartItem> cartItems = [];

  showProduct() {
    for (var item in items) {
      print('${item.name} / ${item.price}원');
    }
  }

  addToCart(Product product, int quantity) {
    print('${product.name}을 $quantity 개 담았습니다');
    cartItems.add(CartItem(product, quantity));
  }

  showTotal() {
    int totalPrice = 0;
    for (var item in cartItems) {
      int price = item.quantityAdded * item.product.price;
      print(
        '제품명: ${item.product.name} \n개수: ${item.quantityAdded}개 \n금액:$price원 \n',
      );
      totalPrice += price;
    }
    print('장바구니에 $totalPrice원 어치를 담으셨습니다.');
  }
}

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class CartItem {
  Product product;
  int quantityAdded;

  CartItem(this.product, this.quantityAdded);
}

void main() {
  var mall = ShoppingMall();
  mall.items = [
    Product('shirt', 45000),
    Product('dress', 30000),
    Product('short-sleeved shirt', 35000),
    Product('shorts', 38000),
    Product('socks', 5000),
  ];
  bool isRunning = true;
  while (isRunning) {
    print(
      '-----------------------------------------------------------------------------------------------------------------------------',
    );
    print(
      '[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료 [6] 장바구니 초기화',
    );
    print(
      '-----------------------------------------------------------------------------------------------------------------------------',
    );

    var input = stdin.readLineSync();

    switch (input) {
      case '1':
        mall.showProduct();
        break;
      case '2':
        Product selected;
        while (true) {
          print('상품 이름을 입력하시오');
          var inputName = stdin.readLineSync()?.trim();
          //상품 찾기 시도
          try {
            selected = mall.items.firstWhere((item) => item.name == inputName);

            break;
          } catch (e) {
            print('입력값이 올바르지 않아요');
            continue; //상품을 못찾을 경우 처음으로 돌아감
          }
        }

        while (true) {
          print('상품의 개수를 입력하시오');
          var inputQuantity = stdin.readLineSync()?.trim();
          var quantity = int.tryParse(inputQuantity ?? "");

          if (quantity == null) {
            print('입력값이 올바르지 않아요');
            continue;
          } else if (quantity <= 0) {
            print('0 보다 많은 개수의 상품만 담을 수 있어요');
            continue;
          } else {
            print('장바구니에 상품이 담겼어요');
            mall.addToCart(selected, quantity);
          }
          break;
        }

      case '3':
        if (mall.cartItems.isEmpty) {
          print('장바구니에 담기 상품이 없습니다.');
        } else {
          mall.showTotal();
        }
        break;

      case '4':
        while (true) {
          print('정말 종료하시겠습니까? \n 아니오(4) / 네(5)');
          var off = stdin.readLineSync();
          if (off == '5') {
            print('이용해 주셔서 감사합니다. 안녕히 가세요.');
            isRunning = false;
          } else if (off == '4') {
            print('종료하지 않습니다.');
          } else {
            print('유효하지 않는 키를 입력하셨습니다. 다시 입력해주세요.');
            continue;
          }
          break;
        }
        break;
      case '6':
        if (mall.cartItems.isEmpty) {
          print('이미 장바구니가 비어있습니다.');
        } else {
          print('장바구니를 초기화합니다.');
          mall.cartItems.clear();
        }
        break;

      default:
        print('지원하지 않는 기능입니다. 다시 시도하세요!');
    }
  }
}
