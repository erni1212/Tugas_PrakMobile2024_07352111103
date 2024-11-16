import 'dart:async';

// Enum untuk menentukan role pengguna
enum Role { Admin, Customer }

// Kelas Product untuk merepresentasikan produk di dalam sistem
class Product {
  String productName;
  double price;
  bool inStock;

  Product({
    required this.productName,
    required this.price,
    required this.inStock,
  });
}

// Kelas User sebagai parent class untuk AdminUser dan CustomerUser
class User {
  String name;
  int age;
  List<Product>? products = []; // Inisialisasi dengan daftar kosong
  Role? role;

  User({required this.name, required this.age, this.role});
}

// Subclass AdminUser yang mewarisi dari User
class AdminUser extends User {
  AdminUser({required String name, required int age})
      : super(name: name, age: age, role: Role.Admin);

  // Fungsi untuk menambahkan produk ke daftar produk
  void addProduct(Product product) {
    // Exception handling untuk produk yang tidak tersedia
    try {
      if (!product.inStock) throw Exception("Produk ${product.productName} tidak tersedia di stok.");
      products ??= []; // Inisialisasi list jika null
      products!.add(product);
      print("Produk ${product.productName} berhasil ditambahkan.");
    } on Exception catch (e) {
      print("Kesalahan: ${e.toString()}");
    }
  }

  // Fungsi untuk menghapus produk dari daftar produk
  void removeProduct(Product product) {
    products?.remove(product);
    print("Produk ${product.productName} berhasil dihapus.");
  }
}

// Subclass CustomerUser yang mewarisi dari User
class CustomerUser extends User {
  CustomerUser({required String name, required int age})
      : super(name: name, age: age, role: Role.Customer);

  // Fungsi untuk menampilkan daftar produk
  void viewProducts() {
    if (products != null && products!.isNotEmpty) {
      print("Daftar Produk:");
      for (var product in products!) {
        print("${product.productName} - ${product.price}");
      }
    } else {
      print("Tidak ada produk yang tersedia.");
    }
  }
}

// Fungsi async untuk mensimulasikan pengambilan data produk dari server
Future<Product> fetchProductDetails(String productName) async {
  print("Mengambil data produk $productName dari server...");
  await Future.delayed(Duration(seconds: 2)); // Simulasi penundaan
  return Product(productName: productName, price: 100.0, inStock: true);
}

void main() async {
  // Membuat produk dengan Map untuk mencegah duplikasi
  var productMap = <String, Product>{};
  var productSet = <Product>{};

  // Menambahkan produk
  var newProduct = Product(productName: "Laptop", price: 1500.0, inStock: true);
  productMap[newProduct.productName] = newProduct;
  productSet.add(newProduct);

  var anotherProduct = Product(productName: "Smartphone", price: 800.0, inStock: false);
  productMap[anotherProduct.productName] = anotherProduct;
  productSet.add(anotherProduct);

  // Menampilkan produk yang ada di dalam Map
  print("Produk yang tersedia:");
  productMap.forEach((key, product) {
    print("$key: \$${product.price} - ${product.inStock ? "Tersedia" : "Habis"}");
  });

  // Membuat objek AdminUser dan CustomerUser
  var admin = AdminUser(name: "Erni", age: 21);
  var customer = CustomerUser(name: "Budi", age: 22);

  // Menambahkan produk ke daftar produk admin
  admin.addProduct(newProduct);
  admin.addProduct(anotherProduct); // Ini akan memicu exception karena stok habis

  // Menampilkan produk untuk customer
  customer.products = admin.products;
  customer.viewProducts();

  // Contoh penggunaan asynchronous untuk fetchProductDetails
  var fetchedProduct = await fetchProductDetails("Tablet");
  print("Produk ${fetchedProduct.productName} berhasil diambil dengan harga \$${fetchedProduct.price}.");
}
