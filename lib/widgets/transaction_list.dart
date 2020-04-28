import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'Nincs megjeleníthető tranzakció.',
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: FittedBox(
                          child: Text(
                              '${transactions[index].amount.toStringAsFixed(0)} FT')),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? FlatButton.icon(
                          textColor: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete_sweep), label: Text('Törlés'),
                    onPressed: () => deleteTx(transactions[index].id,),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete_sweep),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index].id)),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
