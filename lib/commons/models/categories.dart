// ignore_for_file: public_member_api_docs, sort_constructors_first
class Categories {
  static List<Categ> categories = [
    Categ(name: "Air Pods", image: "assets/images/airpods.png"),
    Categ(name: "Apple Watch", image: "assets/images/apple_watch.png"),
    Categ(name: "Keyboards", image: "assets/images/Magic Keyboard - US English.jpg"),
    Categ(name: "Power & Cables", image: "assets/images/USB-C Digital AV Multiport Adapter.jpg"),
    Categ(name: "AirTag  & Accessories", image: "assets/images/AirTag Leather Loop - (PRODUCT)RED.jpg"),
    Categ(name: "Iphone", image: "assets/images/iphone.png"),
    Categ(name: "Cases & Protection", image: "assets/images/mac.png"),
    Categ(name: "Mice & Trackpads", image: "assets/images/Magic Mouse - Black Multi-Touch Surface.jpg"),
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
