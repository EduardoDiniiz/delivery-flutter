import 'package:delivery/datas/product_data.dart';
import 'package:delivery/models/user_model.dart';
import 'package:delivery/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  bool  verificarRestricoes(List<String> restricoes, List<String> ingredientes){
    var value = false;
    restricoes.forEach((rt){
      ingredientes.forEach((ing){
        if(rt == ing){
          value = true;
        }
      });
    });
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProductScreen(product)));
      },
      child: Card(
        child: type == "grid" ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: Image.network(
                product.imagens[0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(product.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.error,
                          color: verificarRestricoes(product.ingredients.map((ingred){
                            return ingred.toString();
                          }).toList(),
                              UserModel.of(context).restrictions.map((rtx){
                                return rtx.toString();
                              }).toList()) ? Theme.of(context).errorColor : Colors.transparent,
                        )
                      ],
                    ),
                    Text(
                      "R\$ ${product.price.toStringAsFixed(2)}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold
                    ))
                  ],
                ),
              ),
            )
          ],
        ) :
        Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                product.imagens[0],
                fit: BoxFit.cover,
                height: 100.0,
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(product.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Icon(
                          Icons.error,
                          color: verificarRestricoes(product.ingredients.map((ingred){
                            return ingred.toString();
                          }).toList(),
                              UserModel.of(context).restrictions.map((rtx){
                            return rtx.toString();
                          }).toList()) ? Theme.of(context).errorColor : Colors.transparent,
                        )
                      ],
                    ),
                    Text(
                        "R\$ ${product.price.toStringAsFixed(2)}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
