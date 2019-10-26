import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DFProduct {
  final String id;
  final String name;
  final String imageFilename;
  final String imageType;
  String imageUrl;
  final String unit;
  final int originalPrice;
  final int sellingPrice;
  final bool isPopular;
  final List<String> tags;

  DFProduct({
    this.id,
    this.name,
    this.imageFilename,
    this.imageType,
    this.unit,
    this.originalPrice,
    this.sellingPrice,
    this.tags,
    this.isPopular
  });

  factory DFProduct.fromSnapshot(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data;
    data['id'] = documentSnapshot.documentID;
    return DFProduct.fromMap(data);
  }

  factory DFProduct.fromMap(Map<String, dynamic> map) {
    int sellingPrice = 0;
    if (map['sellingPrice'] != null) {
      sellingPrice = map['sellingPrice'] is String
          ? int.parse(map['sellingPrice'])
          : map['sellingPrice'];
    }
    return DFProduct(
      id: map['id'],
      name: map['name'] ?? '',
      imageFilename: map['imageFileName'] ?? '',
      imageType: map['imageType'] ?? 'jpg',
      unit: map['unit'] ?? '',
      originalPrice: map['originalPrice'] ?? 0,
      sellingPrice: sellingPrice,
      tags: map['tags'] != null ? map['tags'].cast<String>() : [],
      isPopular: map['isPopular'] != null ? map['isPopular'] : false,
    );
  }

  Future<String> getImageUrl() async {
    if (imageUrl != null) {
      return imageUrl;
    }

    final path = '/products/$imageFilename.$imageType';

    try {
      final String jpgUrl = await FirebaseStorage().ref().child(path).getDownloadURL();
      imageUrl = jpgUrl;
      return jpgUrl;
    } catch (error) {
      return null;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageFilename': imageFilename,
      'imageType': imageType,
      'unit': unit,
      'sellingPrice': sellingPrice,
      'isPopular': isPopular
    };
  }
}
