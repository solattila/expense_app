import 'dart:io';
import 'package:expenseapp/widgets/adaptive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Megnevezés'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
//                    onChanged: (val) {
//                      titleInput = val;
//                    },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Összeg'),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
//                    onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'Nincs dátum kiválasztva'
                          : 'Dátum: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    AdaptiveFlatButton('Dátum', _presentDatePicker)

                  ],
                ),
              ),
              RaisedButton(
                child: Text('Tranzakció hozzáadása'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
