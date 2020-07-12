import 'package:delivery/models/user_model.dart';
import 'package:flutter/material.dart';

class RestrictionsList extends StatelessWidget {

  final void Function(String) onDelete;
  final List<String> restrictions;

  RestrictionsList(this.restrictions, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: restrictions.length,
        itemBuilder: (ctx, index){
          final rt = restrictions[index];
          return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text("Restrição a " + rt,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white,
                      ),),
                    margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 246, 85, 63),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      UserModel.of(context).removeRestrictions(rt);
                      onDelete(rt);
                    }
                  ),
                ],
              ),
          );
        },
      ),
    );
  }
}