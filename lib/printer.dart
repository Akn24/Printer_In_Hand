import 'package:flutter/material.dart';
import 'printerData.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PrinterList extends StatelessWidget {
  final List<PrinterData> printer;
  final Function deleteTx;
  PrinterList(this.printer, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return printer.isEmpty
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'No printer Yet!!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return FlatButton(
                onPressed: (){
                  Alert(
                    context: context,
                    type: AlertType.error,
                    title: "STATUS - Name",
                    desc: 
                    "Machine State: Printing\n File: FirstModel.gco\n Filament(Tool0): 2.22m\n PrintTime Left: 44minutes",
                    
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                onPressed: () => Navigator.pop(context),
              width: 120,
                  )
                  ],
                  ).show();
                },
                  child: Card(
                  elevation: 8,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: FittedBox(
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      printer[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                      children: <Widget>[
                        Text(
                          (printer[index].model),
                        ),
                        Text(
                          (printer[index].ip),
                        ),
                      ],
                    ),
                    trailing: MediaQuery.of(context).size.width > 450
                        ? FlatButton.icon(
                            onPressed: () => deleteTx(printer[index].id),
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => deleteTx(printer[index].id),
                          ),
                  ),
                ),
              );
            },
            itemCount: printer.length,
          );
  }
}
