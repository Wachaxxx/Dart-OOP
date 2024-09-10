import 'dart:io';

class Product {
  String name;
  double price;
  int quantity;

  Product(this.name, this.price, this.quantity);

  void buy(int pon) {
    if (pon > quantity) {
      print("Недостаточно единиц товара, кол-во товаров: $quantity");
    } else {
      quantity -= pon;
      print("Вы успешно продали $pon товара, осталось $quantity единиц товара");
    }
  }

  void addProduct(int add) {
    quantity += add;
    print("Вы пополнили товар на $add единиц");
  }
}

class Store {
  List<Product> products = [];

  void addProduct(Product product) {
    products.add(product);
    print("Товар ${product.name} успешно добавлен");
  }

  void buyProduct(String name, int count) {
    bool found = false;
    for (var product in products) {
      if (product.name == name) {
        product.buy(count);
        found = true;
        break;
      }
    }
    if (!found) {
      print("Товар с именем $name не найден");
    }
  }

  void showProducts() {
    if (products.isEmpty) {
      print("Магазин пуст");
    } else {
      for (var product in products) {
        print('Товар: ${product.name}, Цена: ${product.price}, Количество: ${product.quantity}');
      }
    }
  }

  void removeProduct(String name) {
    bool found = false;
    for (var i = 0; i < products.length; i++) {
      if (products[i].name == name) {
        products.removeAt(i);
        print("Товар $name успешно удален");
        found = true;
        break;
      }
    }
    if (!found) {
      print("Товар с именем $name не найден");
    }
  }

  void addProductStock(String name, int quantity) {
    bool found = false;
    for (var product in products) {
      if (product.name == name) {
        product.addProduct(quantity);
        found = true;
        break;
      }
    }
    if (!found) {
      print("Товар с именем $name не найден");
    }
  }
}

void menu() {
  print("\nЧто вы хотите сделать?");
  print("1. Создать продукт");
  print("2. Продать продукт");
  print("3. Пополнить склад продукта");
  print("4. Посмотреть все продукты");
  print("5. Удалить продукт");
  print("6. Выйти из программы");
}

void handleMenu(int pon, Store store) {
  switch (pon) {
    case 1:
      print("Введите название продукта: ");
      String name = stdin.readLineSync() ?? "Товар";
      print("Введите цену продукта: ");
      double price = double.tryParse(stdin.readLineSync() ?? '0') ?? 0.0;
      print("Введите количество продукта: ");
      int quantity = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
      store.addProduct(Product(name, price, quantity));
      break;

    case 2:
      print("Введите название продукта для продажи: ");
      String productName = stdin.readLineSync() ?? "";
      print("Введите количество для продажи: ");
      int sellQuantity = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
      store.buyProduct(productName, sellQuantity);
      break;

    case 3:
      print("Введите название продукта для пополнения: ");
      String stockProductName = stdin.readLineSync() ?? "";
      print("Введите количество для пополнения: ");
      int stockQuantity = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
      store.addProductStock(stockProductName, stockQuantity);
      break;

    case 4:
      store.showProducts();
      break;

    case 5:
      print("Введите название продукта для удаления: ");
      String deleteProductName = stdin.readLineSync() ?? "";
      store.removeProduct(deleteProductName);
      break;

    case 6:
      print("Выход из программы");
      break;

    default:
      print("Неверный выбор. Пожалуйста, выберите действие от 1 до 6");
  }
}

void main() {
  Store store = Store();
  bool running = true;

  while (running) {
    menu();
    print("Введите номер действия: ");
    var choice = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

    if (choice == 6) {
      running = false;
    } else {
      handleMenu(choice, store);
    }
  }
}
