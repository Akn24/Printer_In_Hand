//import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewPrinter extends StatefulWidget {
  final Function addTx;

  NewPrinter(this.addTx);

  @override
  _NewPrinterState createState() => _NewPrinterState();
}

class _NewPrinterState extends State<NewPrinter> {
  final _firestore = Firestore.instance;
  final _titleController = TextEditingController();

  final _modelController = TextEditingController();

  final _ipController = TextEditingController();

  void _submitData() {
    if (_ipController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredIP = _ipController.text;
    final enteredModel = _modelController.text;
    _firestore.collection('PrinterIP').add({
      'IP': enteredIP,
      'Model': enteredModel,
      'Name' : enteredTitle,
    });
    if (enteredTitle.isEmpty || enteredIP.isEmpty ||enteredModel.isEmpty) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredIP,
      enteredModel,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                autocorrect: true,
                decoration: InputDecoration(labelText: 'Name of Printer'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                //onChanged: (value) {
                // titleInput = value;
                //},
              ),
              TextField(
                autocorrect: true,
                decoration: InputDecoration(labelText: 'Printer Model'),
                controller: _modelController,
                onSubmitted: (_) => _submitData(),
                //onChanged: (value) {
                // titleInput = value;
                //},
              ),
              TextField(
                autocorrect: true,
                decoration: InputDecoration(labelText: 'IP Address'),
                controller: _ipController,
                keyboardType: TextInputType.numberWithOptions(),
                onSubmitted: (_) => _submitData(),
                //onChanged: (value) => amountInput = value,
              ),
              RaisedButton(
                  elevation: 8,
                  onPressed: () => _submitData(),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Add Printer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.button.color,
                      fontSize: 15,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
