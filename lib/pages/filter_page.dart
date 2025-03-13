import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamonds/bloc/diamond_bloc.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final _formKey = GlobalKey<FormState>();

  double? minCarat;
  double? maxCarat;
  String? lab;
  String? shape;
  String? color;
  String? clarity;

  final List<String> labs = ['GIA', 'HRD', 'In-House'];
  final List<String> shapes = ['BR', 'CU', 'EM', 'MQ', 'OV', 'PS', 'RAD'];
  final List<String> colors = ['D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L'];
  final List<String> clarities = [
    'IF',
    'VVS1',
    'VVS2',
    'VS1',
    'VS2',
    'SI1',
    'SI2',
    'I1'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter Diamonds',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF47594C),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Carat Range (From & To)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Min Carat'),
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        minCarat = double.tryParse(value ?? '');
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Max Carat'),
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        maxCarat = double.tryParse(value ?? '');
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Lab Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Lab'),
                items: labs.map((lab) {
                  return DropdownMenuItem(
                    value: lab,
                    child: Text(lab),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    lab = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Shape Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Shape'),
                items: shapes.map((shape) {
                  return DropdownMenuItem(
                    value: shape,
                    child: Text(shape),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    shape = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Color Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Color'),
                items: colors.map((color) {
                  return DropdownMenuItem(
                    value: color,
                    child: Text(color),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    color = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Clarity Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Clarity'),
                items: clarities.map((clarity) {
                  return DropdownMenuItem(
                    value: clarity,
                    child: Text(clarity),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    clarity = value;
                  });
                },
              ),
              SizedBox(height: 32),

              // Search Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Validate that maxCarat is greater than or equal to minCarat
                    if (maxCarat != null &&
                        minCarat != null &&
                        maxCarat! < minCarat!) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Max Carat must be greater than or equal to Min Carat'),
                        ),
                      );
                      return; // Stop further execution if validation fails
                    }

                    // Apply filters
                    context.read<DiamondBloc>().filterDiamonds(
                          minCarat: minCarat,
                          maxCarat: maxCarat,
                          lab: lab,
                          shape: shape,
                          color: color,
                          clarity: clarity,
                        );

                    // Navigate to the Result Page
                    Navigator.pushNamed(context, '/result');
                  }
                },
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
