import 'package:azuralabs_flutter/models/product.dart';
import 'package:azuralabs_flutter/pages/products/product_item.dart';
import 'package:azuralabs_flutter/services/product_service.dart';
import 'package:azuralabs_flutter/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme.dart';

class ProductsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  final _productService = ProductService();
  List<DFProduct> _filteredProducts, _products;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  _fetchProducts() async {
    final snapshots = await _productService.products();
    final products =
        snapshots.map((product) => DFProduct.fromSnapshot(product)).toList();
    setState(() {
      _products = products;
      _filteredProducts = products.where((product) => product.isPopular == true).toList();
    });
  }

  void _onSubmitSearch(text) {
    setState(() {
      if (text == '') {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products
          .where((product) => product.name.toLowerCase().contains(text))
          .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Column(
            
            children: <Widget>[
              _header(),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Column(
                          children: _products == null
                            ? [Loading()]
                            : _filteredProducts
                              .map((product) => ProductItem(product: product))
                              .toList()
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.only(top: 25.0, right: 15, left: 15, bottom: 10),
      color: ThemeColor.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image(
                      height: 48,
                      image: AssetImage('assets/images/logo.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        'dapurfresh',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Image(height: 24, image: AssetImage('assets/images/help.png'))
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: _buildInputSearch(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSearch() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
        border: Border.all(color: Colors.grey)
      ),
      child: TextField(
        onChanged: _onSubmitSearch,
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: 'Cari sayur, bumbu dapur, lauk pauk...',
        ),
      ),
    );
  }
}
