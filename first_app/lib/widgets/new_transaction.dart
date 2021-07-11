import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData(){

    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);

    if( enterTitle.isEmpty || enterAmount <= 0){
      return ;
    }else {
      addTx(
        titleController.text,
        double.parse(amountController.text)
      );
    }
  }

  void closeKeyboard(BuildContext context){
    FocusScope.of(context).unfocus();
    submitData();
  }

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
                onSubmitted: (_) => submitData,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData,
              ),
              FlatButton(
                onPressed: () => closeKeyboard(context),
                child: Text("Add Transaction"),
                textColor: Colors.purple,
              )
            ],
          ),
        ));
  }
}
