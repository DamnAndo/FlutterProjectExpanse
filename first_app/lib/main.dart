import 'package:first_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
            title : TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
            )
          ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title : TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
            )
          )
        ),
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

  final List<Transaction> _userTransactions = [];

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

  List<Transaction> get _getRecentTransaction{
   return _userTransactions.where((tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(Duration(days:7)),
        );
    }).toList();
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
            Chart(_getRecentTransaction),
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
