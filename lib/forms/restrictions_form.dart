import 'package:flutter/material.dart';

class RestrictionsForm extends StatefulWidget {

  final void Function(String) onSubmit;

  RestrictionsForm(this.onSubmit);

  @override
  _RestrictionsFormState createState() => _RestrictionsFormState();
}

class _RestrictionsFormState extends State<RestrictionsForm> {
  final newRestriction = TextEditingController();

  submitForm() {
    if(newRestriction.text.isNotEmpty){
      this.widget.onSubmit(newRestriction.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: newRestriction,
                onSubmitted: (_) => submitForm(),
                decoration: InputDecoration(
                    labelText: 'Restrição'
                ),
              ),
              SizedBox(height: 15,),
              FlatButton(
                child: Text('Adicionar Restrição', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                color: Color.fromARGB(255, 246, 85, 63),
                onPressed: (){
                  this.submitForm();
                },
              )
            ],
          ),
        )
    );
  }
}
