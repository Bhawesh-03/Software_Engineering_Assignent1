import 'package:flutter/material.dart';

void main() {
  runApp(ConversionApp());
}

class ConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConversionHomePage(),
    );
  }
}

class ConversionHomePage extends StatefulWidget {
  @override
  _ConversionHomePageState createState() => _ConversionHomePageState();
}

class _ConversionHomePageState extends State<ConversionHomePage> {
  final _valueController = TextEditingController();
  String _conversionType = 'Distance';
  String _unitFrom = 'Miles';
  String _unitTo = 'Kilometers';
  String _result = '';

  void _convert() {
    double inputValue = double.tryParse(_valueController.text) ?? 0.0;
    double outputValue;

    if (_conversionType == 'Distance') {
      if (_unitFrom == 'Miles' && _unitTo == 'Kilometers') {
        outputValue = inputValue * 1.60934; // Miles to Kilometers
      } else if (_unitFrom == 'Kilometers' && _unitTo == 'Miles') {
        outputValue = inputValue / 1.60934; // Kilometers to Miles
      } else {
        outputValue = inputValue; // No conversion needed
      }
    } else { // Weight conversion
      if (_unitFrom == 'Kilograms' && _unitTo == 'Pounds') {
        outputValue = inputValue * 2.20462; // Kilograms to Pounds
      } else if (_unitFrom == 'Pounds' && _unitTo == 'Kilograms') {
        outputValue = inputValue / 2.20462; // Pounds to Kilograms
      } else {
        outputValue = inputValue; // No conversion needed
      }
    }

    setState(() {
      _result = outputValue.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Conversion App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _valueController,
              decoration: InputDecoration(labelText: 'Enter value'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _conversionType,
              onChanged: (String? newValue) {
                setState(() {
                  _conversionType = newValue!;
                  _unitFrom = _conversionType == 'Distance' ? 'Miles' : 'Kilograms';
                  _unitTo = _conversionType == 'Distance' ? 'Kilometers' : 'Pounds';
                });
              },
              items: <String>['Distance', 'Weight']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _unitFrom,
              onChanged: (String? newValue) {
                setState(() {
                  _unitFrom = newValue!;
                });
              },
              items: (_conversionType == 'Distance'
                      ? ['Miles', 'Kilometers']
                      : ['Kilograms', 'Pounds'])
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: _unitTo,
              onChanged: (String? newValue) {
                setState(() {
                  _unitTo = newValue!;
                });
              },
              items: (_conversionType == 'Distance'
                      ? ['Kilometers', 'Miles']
                      : ['Pounds', 'Kilograms'])
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _result.isEmpty ? 'Result will appear here' : 'Result: $_result',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
