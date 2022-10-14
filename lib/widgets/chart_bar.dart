import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final int amount;
  final double fraction;
  final bool today;

  ChartBar(this.label, this.amount, this.fraction, this.today);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final availableHeight = constraints.maxHeight;
      return Column(
        children: [
          SizedBox(
            height: availableHeight * 0.05,
          ),
          Container(height: availableHeight * 0.1, child: Text('₹${amount}')),
          SizedBox(
            height: availableHeight * 0.05,
          ),
          Container(
            height: availableHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 201, 201, 201), width: 1),
                  color: Color.fromARGB(255, 201, 201, 201),
                  borderRadius: BorderRadius.circular(10),
                )),
                FractionallySizedBox(
                  heightFactor: fraction,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: availableHeight * 0.05,
          ),
          Container(
              alignment: Alignment.center,
              width: 30,
              height: availableHeight * 0.1,
              color: today ? Theme.of(context).primaryColor : null,
              child: Text(
                label,
                style: TextStyle(
                    color: today ? Color.fromARGB(255, 255, 255, 255) : null,
                    backgroundColor:
                        today ? Theme.of(context).primaryColor : null),
              )),
          SizedBox(
            height: availableHeight * 0.05,
          ),
        ],
      );
    });
  }
}
