import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/user_model.dart';
import 'package:delivery/screens/login_screen.dart';
import 'package:delivery/tiles/order_tile.dart';
import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if(UserModel.of(context).isLoggedIn()){

      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("users").document(uid)
            .collection("orders").getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return ListView(
              children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList()
                  .reversed.toList(),
            );
          }
        },
      );

    } else {

      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.view_list,
              size: 80.0, color: Color.fromARGB(255, 246, 85, 63),),
            SizedBox(height: 16.0,),
            Text("Faça o login para acompanhar!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 246, 85, 63)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0,),
            RaisedButton(
              child: Text("Entrar", style: TextStyle(fontSize: 18.0),),
              textColor: Colors.white,
              color: Color.fromARGB(255, 246, 85, 63),
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>LoginScreen())
                );
              },
            )
          ],
        ),
      );

    }

  }
}
