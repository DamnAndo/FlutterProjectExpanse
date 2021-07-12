import 'package:first_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: "baju baru", amount: 11.11, date: DateTime.now()),
    Transaction(
        id: 't2', title: "celana baru", amount: 22.22, date: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
    
  }

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData(){

    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);

    if( enterTitle.isEmpty || enterAmount <= 0){
      return ;
    }else {
      _addNewTransaction(
        titleController.text,
        double.parse(amountController.text)
      );
      titleController.clear();
      amountController.clear();
    }
  }

  void closeKeyboard(BuildContext bctx){
    // FocusScope.of(context).unfocus();
    Navigator.pop(bctx);
    submitData();
  }

  void _startAddNewTransaction(BuildContext context){
    showModalBottomSheet<void>(
        isScrollControlled: false,
        context: context,
        builder: (BuildContext bctx) {
          return GestureDetector(
            onTap: (){

            },
            child : NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nandosan Title"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () => _startAddNewTransaction(context)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('this Chart edit linux'),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context)
      ),
    );
  }
}
