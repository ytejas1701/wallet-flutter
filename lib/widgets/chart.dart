import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import '../models/Transactions.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTranasactions;

  Chart(this.recentTranasactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      int totalSum = 0;
      for (int i = 0; i < recentTranasactions.length; i++) {
        if (recentTranasactions[i].date.day == weekday.day &&
            recentTranasactions[i].date.month == weekday.month &&
            recentTranasactions[i].date.year == weekday.year) {
          totalSum += recentTranasactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday),
        'amount': totalSum,
        'today': index == 0
      };
    }).reversed.toList();
  }

  int get maxSpending {
    return groupedTransactionValues.fold(0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Card(
          elevation: 10,
          margin: EdgeInsets.all(20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        data['day'],
                        data['amount'],
                        maxSpending == 0
                            ? 0
                            : (data['amount'] as int) / maxSpending,
                        data['today']));
              }).toList()),
        ));
  }
}
