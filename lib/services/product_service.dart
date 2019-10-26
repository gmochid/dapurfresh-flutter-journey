import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  Future<List<DocumentSnapshot>> products() async {
    final snapshot =
        await Firestore.instance.collection('products').getDocuments();
    return snapshot.documents;
  }
  Future<List<DocumentSnapshot>> categories() async {
    final snapshot =
    await Firestore.instance.collection('categories').getDocuments();
    return snapshot.documents;
  }
}
