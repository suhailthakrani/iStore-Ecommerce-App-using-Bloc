class ProductsModel {
  List<Category> products = [];

  ProductsModel({required this.products});

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    List<Category> products = (json['products'] as List<dynamic>)
        .map((productJson) => Category.fromJson(productJson))
        .toList();
    return ProductsModel(products: products);
  }

  Category getProductsByCategory(String category) {
    for (Category productCategory in products) {
      if (productCategory.category == category) {
        return productCategory;
      }
    }

    return Category.empty();
  }
}

class Category {
  String id = "-1";
  String category = '';
  List<CategoryProduct> categoryProducts = [];

  Category({
    required this.id,
    required this.category,
    required this.categoryProducts,
  }); 
  Category.empty(){
   id = "";
   category = '';
    categoryProducts = [];
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();
    String category = json['category']??"";
    List<CategoryProduct> categoryProducts =
        (json['categoryProducts'] as List<dynamic>)
            .map((productJson) => CategoryProduct.fromJson(productJson))
            .toList();
    return Category(
      id: id,
      category: category,
      categoryProducts: categoryProducts,
    );
  }
}

class CategoryProduct {
  String id = '-1';
  String name = '';
  String image = '';
  String price = '';
  String reviews = '';
  String description = '';
  String rating = '';
  int quantity = 1;

  CategoryProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.reviews,
    required this.description,
    required this.rating,
    this.quantity = 1,
  });
  CategoryProduct.empty() {
    id = "";
    name = '';
    image = '';
    price = '';
    reviews = '';
    description = '';
    rating = '';
    quantity = -1;
  }
  factory CategoryProduct.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();
    String name = json['name'];
    String image = json['image'];
    String price = json['price'];
    String reviews = json['reviews'];
    String description = json['description'];
    String rating = json['rating'];
    int quantity = 1;
    return CategoryProduct(
      id: id,
      name: name,
      image: image,
      price: price,
      reviews: reviews,
      description: description,
      rating: rating,
      quantity: quantity,
    );
  }
  CategoryProduct copyWith({
    String? id,
    String? name,
    String? image,
    String? price,
    String? reviews,
    String? description,
    String? rating,
    int? quantity,
  }) {
    return CategoryProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      reviews: reviews ?? this.reviews,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['price'] = price;
    data['reviews'] = reviews;
    data['description'] = description;
    data['rating'] = rating;
    return data;
  }
}
