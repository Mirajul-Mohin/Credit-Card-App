import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Credit Card Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final textEditControllerOne = TextEditingController();
  final textEditControllerTwo = TextEditingController();

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1500),
        content: const Text('Copied to Clipboard'),
      ),
    );
  }

  void _setText() {
    setState(() {});
  }

  String textFromFieldOne = "";
  String textFromFieldTwo = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textEditControllerOne.dispose();
    textEditControllerTwo.dispose();
    super.dispose();
  }

  String format;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  maxLength: 20,
                  decoration: InputDecoration(
                    hintText: 'Enter Card Number',
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                  ),
                  controller: textEditControllerOne,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (value.length > 20) {
                      return 'Length can not be more than 20';
                    }
                    if (value.length < 16) {
                      return 'Length can not be less than 16';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Exp Date',
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                  ),
                  controller: textEditControllerTwo,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                // Padding(padding: const EdgeInsets.only(left: 10),),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Container(
                  alignment: Alignment.center,
                  //padding: const EdgeInsets.only(left: 16),
                  //width: 300,
                  child: DropdownButtonFormField<String>(
                    hint: Text('Select Format'),
                    //dropdownColor: Colors.cyan[300],
                    items: ['226', '620'].map<DropdownMenuItem<String>>(
                      (String val) {
                        return DropdownMenuItem(
                          child: Text(val),
                          value: val,
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      format = val;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Cancel'),
                        ),
                        Padding(padding: EdgeInsets.only(left: 2)),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              textFromFieldOne = textEditControllerOne.text;
                              textEditControllerOne.text = "";

                              textFromFieldTwo = textEditControllerTwo.text;
                              //textEditControllerTwo.text="";

                              _setText();
                            }
                          },
                          child: Text('Submit'),
                        ),
                        Padding(padding: EdgeInsets.only(right: 2)),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Check'),
                        ),
                      ]),
                ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: <Widget>[
                  if ('$format' == '620')
                    for (int index = 1; index < 10; index++)
                      ListTile(
                        // leading: ExcludeSemantics(
                        //   child: CircleAvatar(child: Text('$index')),
                        // ),
                        title: Text('$textFromFieldOne' +
                            '=2206' +
                            '$format' +
                            '00000' +
                            '00$index'),
                        subtitle: Column(
                          children: <Widget>[
                            //Text('Found Format : $format'),
                            OutlineButton(
                                child: Text('CCopy'),
                                borderSide: BorderSide(color: Colors.blue),
                                shape: StadiumBorder(),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: '$textFromFieldOne' +
                                          '=2206' +
                                          '$format' +
                                          '00000' +
                                          '00$index'));
                                  _showToast(context);
                                })
                          ],
                        ),
                        //Text('Found Format : $format'),
                      ),
                  if ('$format' == '620')
                    for (int index = 10; index < 100; index++)
                      ListTile(
                        // leading: ExcludeSemantics(
                        //   child: CircleAvatar(child: Text('$index')),
                        // ),
                        title: Text('$textFromFieldOne' +
                            '=2206' +
                            '$format' +
                            '00000' +
                            '0$index'),
                        subtitle: Column(
                          children: <Widget>[
                            //Text('Found Format : $format'),
                            OutlineButton(
                                child: Text('Copy'),
                                borderSide: BorderSide(color: Colors.blue),
                                shape: StadiumBorder(),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: '$textFromFieldOne' +
                                          '=2206' +
                                          '$format' +
                                          '00000' +
                                          '0$index'));
                                  _showToast(context);
                                })
                          ],
                        ),
                      ),
                  if ('$format' == '620')
                    for (int index = 100; index < 1000; index++)
                      ListTile(
                        // leading: ExcludeSemantics(
                        //   child: CircleAvatar(child: Text('$index')),
                        // ),
                        title: Text('$textFromFieldOne' +
                            '=2206' +
                            '$format' +
                            '00000' +
                            '$index'),
                        subtitle: Column(
                          children: <Widget>[
                            //Text('Found Format : $format'),
                            OutlineButton(
                                child: Text('Copy'),
                                borderSide: BorderSide(color: Colors.blue),
                                shape: StadiumBorder(),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: '$textFromFieldOne' +
                                          '=2206' +
                                          '$format' +
                                          '00000' +
                                          '$index'));
                                  _showToast(context);
                                })
                          ],
                        ),
                      ),
                  if ('$format' == '226')
                    for (int index = 1; index < 10; index++)
                      ListTile(
                        // leading: ExcludeSemantics(
                        //   child: CircleAvatar(child: Text('$index')),
                        // ),
                        title: Text('$textFromFieldOne' +
                            '=2206' +
                            '$format' +
                            '00000' +
                            '00$index' +
                            '00000'),
                        subtitle: Column(
                          children: <Widget>[
                            //Text('Found Format : $format'),
                            OutlineButton(
                                child: Text('Copy'),
                                borderSide: BorderSide(color: Colors.blue),
                                shape: StadiumBorder(),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: '$textFromFieldOne' +
                                          '=2206' +
                                          '$format' +
                                          '00000' +
                                          '00$index' +
                                          '00000'));
                                  _showToast(context);
                                })
                          ],
                        ),
                      ),
                  if ('$format' == '226')
                    for (int index = 10; index < 100; index++)
                      ListTile(
                        title: Text('$textFromFieldOne' +
                            '=2206' +
                            '$format' +
                            '00000' +
                            '0$index' +
                            '00000'),
                        subtitle: Column(
                          children: <Widget>[
                            OutlineButton(
                                child: Text('Copy'),
                                borderSide: BorderSide(color: Colors.blue),
                                shape: StadiumBorder(),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: '$textFromFieldOne' +
                                          '=2206' +
                                          '$format' +
                                          '00000' +
                                          '0$index' +
                                          '00000'));
                                  _showToast(context);
                                })
                          ],
                        ),
                      ),
                  if ('$format' == '226')
                    for (int index = 100; index < 1000; index++)
                      ListTile(
                        title: Text('$textFromFieldOne' +
                            '=2206' +
                            '$format' +
                            '00000' +
                            '$index' +
                            '00000'),
                        subtitle: Column(
                          children: <Widget>[
                            //Text('Found Format : $format'),
                            OutlineButton(
                                child: Text('Copy'),
                                borderSide: BorderSide(color: Colors.blue),
                                shape: StadiumBorder(),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: '$textFromFieldOne' +
                                          '=2206' +
                                          '$format' +
                                          '00000' +
                                          '$index' +
                                          '00000'));
                                  _showToast(context);
                                })
                          ],
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
