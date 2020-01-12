import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {

  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController =  TextEditingController();

  DateTime selectedDate;

  void submitData(){
    if(amountController.text.isEmpty)
    return;

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    
    if(enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null){
      return;
    }

    

    widget.addTx(titleController.text,double.parse(amountController.text),selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
      showDatePicker(context: context, initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      ).then((pickedDate){

        if(pickedDate == null)
        return;
        setState(() {
          selectedDate = pickedDate;
        });
        
      });
    }

  @override
  Widget build(BuildContext context,) {
    return SingleChildScrollView(
          child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  right: 10,
                  left: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(decoration: InputDecoration(labelText: 'Title'),
                    controller: titleController,
                    onSubmitted: (_) => submitData(),
                    ),
                    TextField(decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => submitData(),
                    ),
                    Container(
                      height: 70,
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Text(selectedDate == null 
                          ? 'No date chosen!'
                          : 'Picked Date: ${DateFormat('dd-MM-yyyy').format(selectedDate)}'),
                        ),
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),),
                          onPressed: _presentDatePicker,
                        )
                      ],),
                    )
                    ,
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text('Add Expense'),
                      textColor: Theme.of(context).textTheme.button.color,
                      onPressed: submitData,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}