import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() =>
      _TestState();
}

class _TestState extends State<Test> {
  TextEditingController temperatureController = TextEditingController();
  String sourceUnit = 'Centigrade';
  String targetUnit = 'Fahrenheit';
  double convertedTemperature = 0.0;

  void convert() {
    double temperature = double.tryParse(temperatureController.text) ?? 0.0;
    convertedTemperature =
        convertTemperature(temperature, sourceUnit, targetUnit);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: temperatureController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
              ),
            ),
            DropdownButton<String>(
              value: sourceUnit,
              onChanged: (value) {
                setState(() {
                  sourceUnit = value!;
                });
              },
              items: ['Centigrade', 'Fahrenheit', 'Kelvin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: targetUnit,
              onChanged: (value) {
                setState(() {
                  targetUnit = value!;
                });
              },
              items: ['Centigrade', 'Fahrenheit', 'Kelvin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: convert,
              child: Text('Convert'),
            ),
            Text(
              'Converted Temperature: $convertedTemperature',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  double convertTemperature(
      double temperature, String fromUnit, String toUnit) {
    final Map<String, double> unitToCelsius = {
      'Centigrade': 1.0,
      'Fahrenheit': 5 / 9,
      'Kelvin': 1.0,
    };

    final Map<String, double> celsiusToUnit = {
      'Centigrade': 1.0,
      'Fahrenheit': 9 / 5,
      'Kelvin': 1.0,
    };

    double celsiusTemperature = temperature * unitToCelsius[fromUnit]!;
    double targetTemperature = celsiusTemperature * celsiusToUnit[toUnit]!;

    return targetTemperature;
  }
}
