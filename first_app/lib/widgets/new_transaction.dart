import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
              ),
              FlatButton(
                onPressed: () {
                  print(titleController.text);
                  print(amountController.text);
                  addTx(titleController.text,
                      double.parse(amountController.text));
                  FocusScope.of(context).unfocus(); 
                },
                child: Text("Add Transaction"),
                textColor: Colors.purple,
              )
            ],
          ),
        ));
  }
}
