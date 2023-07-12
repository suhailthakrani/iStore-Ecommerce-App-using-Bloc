// ignore_for_file: public_member_api_docs, sort_constructors_first
class Categories {
  static List<Categ> categories = [
    Categ(name: "Airpods", image: "assets/images/airpods.png"),
    Categ(name: "Apple Watch", image: "assets/images/apple_watch.png"),
    Categ(name: "Apple TV 4K", image: "assets/images/appletv_4k.png"),
    Categ(name: "Home Pods", image: "assets/images/home_pd.png"),
    Categ(name: "iPads", image: "assets/images/ipad.png"),
    Categ(name: "iPhones", image: "assets/images/iphone.png"),
    Categ(name: "Macbooks", image: "assets/images/mac.png"),
  ];
}
class Categ {
  final String name;
  final String image;
  Categ({
    required this.name,
    required this.image,
  });
}
