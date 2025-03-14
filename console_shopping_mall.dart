import 'dart:io';
import 'dart:convert'; // UTF-8 처리를 위해 추가

// 상품 클래스
class Product {
  String name;
  int price;
  Product(this.name, this.price);
}

// 쇼핑몰 클래스
class ShoppingMall {
  List<Product> products = [
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000)
  ];

  Map<String, int> cart = {};
  int total = 0;

  // 상품 목록 출력
  void showProducts() {
    print("\n판매 상품 목록:");
    for (int i = 0; i < products.length; i++) {
      print("${i + 1}. ${products[i].name} / ${products[i].price}원");
    }
  }

  // 장바구니에 상품 추가 - 번호로 선택하는 방식으로 변경
  void addToCart() {
    showProducts(); // 상품 목록 먼저 보여주기

    print("\n장바구니에 담을 상품의 번호를 입력하세요 (1-5):");
    String? input = stdin.readLineSync();
    if (input == null || input.isEmpty) {
      print("입력값이 올바르지 않아요!");
      return;
    }

    try {
      int productIndex = int.parse(input) - 1;

      if (productIndex < 0 || productIndex >= products.length) {
        print("유효한 상품 번호를 입력해주세요 (1-5)");
        return;
      }

      Product selectedProduct = products[productIndex];
      print("선택한 상품: ${selectedProduct.name}");

      print("상품 개수를 입력하세요:");
      String? quantityInput = stdin.readLineSync();
      if (quantityInput == null || quantityInput.isEmpty) {
        print("입력값이 올바르지 않아요!");
        return;
      }

      int quantity = int.parse(quantityInput);
      if (quantity <= 0) {
        print("0개보다 많은 개수의 상품만 담을 수 있어요!");
        return;
      }

      cart.update(selectedProduct.name,
          (existingQuantity) => existingQuantity + quantity,
          ifAbsent: () => quantity);
      total += selectedProduct.price * quantity;
      print("장바구니에 ${selectedProduct.name} ${quantity}개가 담겼어요!");
    } catch (e) {
      print("입력값이 올바르지 않아요! 숫자만 입력해주세요.");
    }
  }

  // 장바구니 총 가격 출력
  void showTotal() {
    if (cart.isEmpty) {
      print("장바구니에 담긴 상품이 없습니다.");
    } else {
      print("장바구니에 ${total}원 어치를 담으셨네요!");
    }
  }

  // 장바구니 상세 보기
  void showCartDetails() {
    if (cart.isEmpty) {
      print("장바구니에 담긴 상품이 없습니다.");
      return;
    }

    print("장바구니에 다음 상품이 담겨있습니다:");
    cart.forEach((name, quantity) {
      // 해당 상품의 가격 찾기
      var product = products.firstWhere((p) => p.name == name);
      print("$name x $quantity = ${product.price * quantity}원");
    });
    print("총 ${total}원 입니다!");
  }

  // 장바구니 초기화
  void clearCart() {
    if (cart.isEmpty) {
      print("이미 장바구니가 비어있습니다.");
    } else {
      cart.clear();
      total = 0;
      print("장바구니를 초기화합니다.");
    }
  }

  // 프로그램 종료
  void exitProgram() {
    print("정말 종료하시겠습니까? (5 입력 시 종료)");
    String? input = stdin.readLineSync();
    if (input == '5') {
      print("이용해 주셔서 감사합니다 ~ 안녕히 가세요!");
      exit(0);
    } else {
      print("종료하지 않습니다.");
    }
  }
}

void main() {
  // 한글 출력을 위한 인코딩 설정
  stdout.encoding = utf8;
  stdin.encoding = utf8;

  ShoppingMall mall = ShoppingMall();

  while (true) {
    print(
        "\n[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니 목록 및 총 가격 보기 / [4] 프로그램 종료 / [6] 장바구니 초기화");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        mall.showProducts();
        break;
      case '2':
        mall.addToCart();
        break;
      case '3':
        mall.showCartDetails();
        break;
      case '4':
        mall.exitProgram();
        break;
      case '6':
        mall.clearCart();
        break;
      default:
        print("지원하지 않는 기능입니다! 다시 시도해 주세요..");
    }
  }
}
