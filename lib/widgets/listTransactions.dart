import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transactions.dart';

class ListTransactions extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTrasaction;
  ListTransactions(this.transactions, this.deleteTrasaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Card(
                      color: Theme.of(context).primaryColor,
                      elevation: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              margin: EdgeInsets.all(10),
                              child: Text("₹${transactions[index].amount}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold))),
                          Container(
                              width: 180,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.only(right: 10, top: 10),
                                      child: Text(
                                        transactions[index].title,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text(
                                          DateFormat.yMMMMd()
                                              .format(transactions[index].date),
                                          style: TextStyle(
                                              color: Colors.black87))),
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  deleteTrasaction(transactions[index].id);
                                },
                              )),
                        ],
                      )));
            }));
  }
}
