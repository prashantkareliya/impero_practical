import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignScreen extends StatefulWidget {
  const DesignScreen({super.key});

  @override
  State<DesignScreen> createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  Map<String, dynamic> values = {
    'Total Hardness': {
      'color': Colors.purple,
      'value': 0,
      'colors': [
        Colors.purple,
        Colors.blue,
        Colors.cyan,
        Colors.green,
        Colors.purple.shade800
      ]
    },
    'Total Chlorine': {
      'color': Colors.cyan,
      'value': 0,
      'colors': [
        Colors.cyan,
        Colors.lightGreen,
        Colors.green,
        Colors.greenAccent,
        Colors.cyanAccent
      ]
    },
    'Free Chlorine': {
      'color': Colors.purple.shade100,
      'value': 0,
      'colors': [
        Colors.purple.shade100,
        Colors.purple.shade300,
        Colors.indigoAccent,
        Colors.purple.shade500,
        Colors.indigo
      ]
    },
    'pH': {
      'color': Colors.orange.shade200,
      'value': 0,
      'colors': [
        Colors.orange.shade200,
        Colors.orange,
        Colors.orange.shade400,
        Colors.red,
        Colors.redAccent
      ]
    },
    'Total Alkalinity': {
      'color': Colors.brown,
      'value': 0,
      'colors': [
        Colors.lightGreenAccent,
        Colors.lightGreen,
        Colors.green,
        Colors.teal,
        Colors.tealAccent
      ]
    },
    'Cyanuric Acid': {
      'color': Colors.red,
      'value': 0,
      'colors': [
        Colors.red,
        Colors.orange,
        Colors.purple,
        Colors.purpleAccent,
        Colors.indigoAccent
      ]
    },
  };

  void updateValue(String key, int value, Color color) {
    setState(() {
      values[key]['value'] = value;
      values[key]['color'] = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test Strip',
          style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 25.sp,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        children: values.keys.map((key) {
          return TestStripRow(
            label: key,
            colors: values[key]['colors'],
            value: values[key]['value'],
            color: values[key]['color'],
            onChanged: (value, color) => updateValue(key, value, color),
          );
        }).toList(),
      ),
    );
  }
}

class TestStripRow extends StatelessWidget {
  final String label;
  final List<Color?> colors;
  final int value;
  final Color color;
  final Function(int, Color) onChanged;

  const TestStripRow({
    super.key,
    required this.label,
    required this.colors,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 15, height: 15, color: color),
          SizedBox(width: 20.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label),
                    Padding(
                      padding: EdgeInsets.all(4.sp),
                      child: SizedBox(
                        width: 0.18.sw,
                        height: 35.sp,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            int newValue = int.tryParse(text) ?? 0;
                            if (newValue >= 0 && newValue < colors.length) {
                              onChanged(newValue, colors[newValue]!);
                            }
                          },
                          controller:
                              TextEditingController(text: value.toString()),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.black38),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.black38),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.black38),
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 18.sp),
                              hintText: "0"),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: colors.asMap().entries.map((entry) {
                    int index = entry.key;
                    Color color = entry.value ?? Colors.black;
                    return GestureDetector(
                      onTap: () => onChanged(index, color),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.sp),
                        child: Container(
                          width: 60,
                          height: 15,
                          color: color,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 0.055.sh),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
