import 'package:cached_network_image/cached_network_image.dart';
import 'package:azuralabs_flutter/helpers/string.dart';
import 'package:azuralabs_flutter/models/product.dart';
import 'package:flutter/material.dart';
import '../../theme.dart';

class ProductItem extends StatelessWidget {
  ProductItem({@required this.product});

  final DFProduct product;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6)),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(1, 1)),
          ]
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
              future: product.getImageUrl(),
              builder: (context, snapshot) {
                return Container(
                  width: 90,
                  margin: EdgeInsets.only(right: 12),
                  height: 90,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(8.0),
                    child: snapshot.data == null
                        ? Image(image: AssetImage('assets/images/placeholder.jpg'))
                        : CachedNetworkImage(
                            imageUrl: snapshot.data,
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(product.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                Padding(padding: EdgeInsets.only(top: 4)),
                Text(
                  '${StringHelper.currency(product.sellingPrice)} ',
                  style:TextStyle(fontSize: 15, fontWeight: FontWeight.w600)
                ),
                buildButton(context),
              ],
            ),
          ],
        ));
  }

  Widget buildButton(BuildContext context) {
    return Row(
      children: <Widget>[
        ButtonTheme(
          height: 28,
          child: RaisedButton(
            color: ThemeColor.primary,
            textColor: Colors.white,
            child: Text('Tambah', style: TextStyle(fontSize: 14)),
            onPressed: () {},
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 6),
          child: Text(
            'x ${product.unit}',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)
          ),
        )
      ],
    );
  }
}
