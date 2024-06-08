import 'package:flutter/material.dart';
import 'package:ravina_impero_practical/src/data/constants/app_strings.dart';

class TestStripScreen extends StatefulWidget {
  const TestStripScreen({super.key});

  @override
  _TestStripScreenState createState() => _TestStripScreenState();
}

class _TestStripScreenState extends State<TestStripScreen> {
  final List<List<Color>> stripColors = [
    [
      Colors.blue[100]!,
      Colors.blue[300]!,
      Colors.blue[500]!,
      Colors.blue[700]!,
      Colors.blue[900]!
    ],
    [
      Colors.green[100]!,
      Colors.green[300]!,
      Colors.green[500]!,
      Colors.green[700]!,
      Colors.green[900]!
    ],
    [
      Colors.yellow[100]!,
      Colors.yellow[300]!,
      Colors.yellow[500]!,
      Colors.yellow[700]!,
      Colors.yellow[900]!
    ],
    [
      Colors.orange[100]!,
      Colors.orange[300]!,
      Colors.orange[500]!,
      Colors.orange[700]!,
      Colors.orange[900]!
    ],
    [
      Colors.red[100]!,
      Colors.red[300]!,
      Colors.red[500]!,
      Colors.red[700]!,
      Colors.red[900]!
    ],
    [
      Colors.purple[100]!,
      Colors.purple[300]!,
      Colors.purple[500]!,
      Colors.purple[700]!,
      Colors.purple[900]!
    ],
  ];

  final List<List<String>> values = [
    ["0", "110", "250", "500", "1000"],
    ["0", "1", "3", "5", "10"],
    ["0", "1", "3", "5", "10"],
    ["6.2", "6.8", "7.2", "2.8", "8.4"],
    ["0", "40", "120", "180", "240"],
    ["0", "50", "100", "150", "300"]
  ];

  final List<String> titles = [
    "Total Hardness",
    "Total Chlorine",
    "Free Chlorine",
    "pH",
    "Total Alkalinity",
    "Cyanuric Acid"
  ];

  final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  final List<Color> selectedColors =
      List.generate(6, (index) => Colors.transparent);

  void _onColorTap(int rowIndex, int colorIndex) {
    setState(() {
      controllers[rowIndex].text = values[rowIndex][colorIndex];
      selectedColors[rowIndex] = stripColors[rowIndex][colorIndex];
    });
  }

  void _onInputChange(int rowIndex) {
    setState(() {
      String input = controllers[rowIndex].text;
      int index = values[rowIndex].indexWhere((list) => list.contains(input));
      if (index != -1) {
        selectedColors[rowIndex] = stripColors[rowIndex][index];
      } else {
        selectedColors[rowIndex] = Colors.transparent;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          AppStrings.testStrip,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left vertical bar
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: ListView(
                  children: List.generate(6, (index) {
                    return Container(
                      width: 20,
                      height: 100, // Same height as the TestStripItem
                      decoration: BoxDecoration(
                        color: selectedColors[index],
                      ),
                      margin: const EdgeInsets.only(bottom: 30),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Right side rows
            Expanded(
              flex: 9,
              child: ListView(
                children: List.generate(6, (index) {
                  return TestStripItem(
                    title: "${titles[index]} (ppm)",
                    colors: stripColors[index],
                    values: values[index],
                    controller: controllers[index],
                    selectedColor: selectedColors[index],
                    onTap: (colorIndex) => _onColorTap(index, colorIndex),
                    onChange: () => _onInputChange(index),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestStripItem extends StatelessWidget {
  final String title;
  final List<Color> colors;
  final List<String> values;
  final TextEditingController controller;
  final Color selectedColor;
  final Function(int) onTap;
  final Function onChange;

  const TestStripItem({
    super.key,
    required this.title,
    required this.colors,
    required this.values,
    required this.controller,
    required this.selectedColor,
    required this.onTap,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 60,
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => onChange(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "0",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(colors.length, (index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors[index],
                      border: Border.all(
                        color: selectedColor == colors[index]
                            ? Colors.black
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    height: 30,
                    child: Center(
                      child: Text(
                        values[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
