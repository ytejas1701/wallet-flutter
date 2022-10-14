import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/inputTransactions.dart';
import './widgets/chart.dart';
import './widgets/listTransactions.dart';
import './models/Transactions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where(
      (element) {
        return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
      },
    ).toList();
  }

  void _addTransaction(String newTitle, int newAmount, DateTime chosenDate) {
    final newTransaction = Transaction(
        title: newTitle,
        amount: newAmount,
        date: chosenDate,
        id: chosenDate.toString());
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _slideInputTransaction(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: InputTransactions(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String deletedId) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == deletedId;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      actions: [
        IconButton(
            onPressed: () {
              _slideInputTransaction(context);
            },
            icon: Icon(Icons.add))
      ],
      title: Text('Personal Expenses'),
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
            height: availableHeight * 0.3, child: Chart(_recentTransactions)),
        Container(
            height: availableHeight * 0.7,
            child: ListTransactions(_userTransactions, _deleteTransaction)),
      ])),
    );
  }
}
