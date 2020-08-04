import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './new_printer.dart';
import './printerData.dart';
import './printer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      //DeviceOrientation.portraitDown,
      //DeviceOrientation.portraitUp,
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Expenses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.red,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<PrinterData> _userPrinter = [];

  void _addNewPrinter(String txTitle, String txIP, String txModel) {
    final newTx = PrinterData(
      id: DateTime.now().toString(),
      title: txTitle,
      ip: txIP,
      model: txModel,
  
    );

    setState(() {
      _userPrinter.add(newTx);
    });
  }

  void _deletePrinter(String id) {
    setState(() {
      _userPrinter.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewPrinter(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewPrinter(_addNewPrinter);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Printer in Hand',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewPrinter(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              '3D Printers in Hand',
              style: TextStyle(fontFamily: 'Open Sans'),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewPrinter(context),
              ),
            ],
          );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.8,
      child: PrinterList(_userPrinter, _deletePrinter),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: txListWidget,
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewPrinter(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
