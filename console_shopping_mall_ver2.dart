import 'dart:io';

// Product class to define products
class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

// ShoppingMall class to manage the shopping mall functionality
class ShoppingMall {
  List<Product> products = [];
  int total = 0;
  List<String> cartItems =
      []; // For storing names of items in cart (challenge feature)
  Map<String, int> cartItemsCount =
      {}; // For storing item counts (additional feature)

  // Constructor to initialize products
  ShoppingMall() {
    // Initialize with at least 5 products
    products.add(Product('셔츠', 45000));
    products.add(Product('원피스', 30000));
    products.add(Product('반팔티', 35000));
    products.add(Product('반바지', 38000));
    products.add(Product('양말', 5000));
  }

  // Method to show products
  void showProducts() {
    for (var product in products) {
      print('${product.name} / ${product.price}원');
    }
  }

  // Method to add product to cart
  void addToCart() {
    print('장바구니에 담을 상품 이름을 입력하세요:');
    String? productName = stdin.readLineSync();

    if (productName == null || productName.isEmpty) {
      print('입력값이 올바르지 않아요 !');
      return;
    }

    // Check if product exists
    bool productExists = false;
    Product? selectedProduct;

    for (var product in products) {
      if (product.name == productName) {
        productExists = true;
        selectedProduct = product;
        break;
      }
    }

    if (!productExists) {
      print('입력값이 올바르지 않아요 !');
      return;
    }

    print('구매할 개수를 입력하세요:');
    String? countInput = stdin.readLineSync();

    try {
      int count = int.parse(countInput ?? '0');

      if (count <= 0) {
        print('0개보다 많은 개수의 상품만 담을 수 있어요 !');
        return;
      }

      // Add to cart
      total += selectedProduct!.price * count;

      // Add to cart items list (for challenge feature)
      if (!cartItems.contains(productName)) {
        cartItems.add(productName);
      }

      // Update item count in cart (additional feature)
      if (cartItemsCount.containsKey(productName)) {
        cartItemsCount[productName] = cartItemsCount[productName]! + count;
      } else {
        cartItemsCount[productName] = count;
      }

      print('장바구니에 상품이 담겼어요 !');
    } catch (e) {
      print('입력값이 올바르지 않아요 !');
    }
  }

  // Method to show total price
  void showTotal() {
    // Challenge feature: Show cart items and their total price
    if (cartItems.isEmpty) {
      print('장바구니에 담긴 상품이 없습니다.');
      return;
    }

    // Simple output for required feature
    // print('장바구니에 ${total}원 어치를 담으셨네요 !');

    // Enhanced output for challenge feature
    String itemsList = cartItems.join(', ');
    print('장바구니에 ${itemsList}가 담겨있네요. 총 ${total}원 입니다!');

    // Additional feature: Show detailed cart with item counts
    print('\n--- 장바구니 상세 내역 ---');
    cartItemsCount.forEach((key, value) {
      int itemPrice = 0;
      for (var product in products) {
        if (product.name == key) {
          itemPrice = product.price;
          break;
        }
      }
      print('$key: $value개 (${itemPrice * value}원)');
    });
  }

  // Challenge feature: Clear cart
  void clearCart() {
    if (total == 0) {
      print('이미 장바구니가 비어있습니다.');
      return;
    }

    total = 0;
    cartItems.clear();
    cartItemsCount.clear();
    print('장바구니를 초기화합니다.');
  }
}

void main() {
  ShoppingMall shoppingMall = ShoppingMall();
  bool isRunning = true;

  while (isRunning) {
    print(
        '\n[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료 / [6] 장바구니 초기화');
    String? input = stdin.readLineSync();

    switch (input) {
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
        print('정말 종료하시겠습니까? (5: 예, 다른 키: 아니오)');
        String? confirmExit = stdin.readLineSync();
        if (confirmExit == '5') {
          print('이용해 주셔서 감사합니다 ~ 안녕히 가세요 !');
          isRunning = false;
        } else {
          print('종료하지 않습니다.');
        }
        break;
      case '6':
        shoppingMall.clearCart();
        break;
      default:
        print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..');
    }
  }
}
