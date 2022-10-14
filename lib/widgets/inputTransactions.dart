import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputTransactions extends StatefulWidget {
  final Function newTransaction;
  InputTransactions(this.newTransaction);

  @override
  State<StatefulWidget> createState() => _InputTransactionsState();
}

class _InputTransactionsState extends State<InputTransactions> {
  final textController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _enterData() {
    final enteredTitle = textController.text;
    final enteredAmount = int.tryParse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.newTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _slideDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Column(children: [
          TextField(
            controller: textController,
            onEditingComplete: _enterData,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            onEditingComplete: _enterData,
            decoration: InputDecoration(labelText: 'Amount'),
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen'
                          : DateFormat.yMMMMd().format(_selectedDate))),
                  TextButton(
                    onPressed: _slideDatePicker,
                    child: Text('Choose Date',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                  )
                ],
              )),
          TextButton(
              onPressed: _enterData,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor)),
              child: Text("Add", style: TextStyle(color: Colors.white))),
        ]));
  }
}
