// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  
  final int id;
  final String name;
  final double price;
  const Product({
    required this.id,
    required this.name,
    required this.price,
  });
  
  @override
  List<Object?> get props => [id, name, price];
 
}
