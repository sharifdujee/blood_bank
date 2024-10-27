import 'package:flutter/material.dart';

class AnimatedCustomDropdown extends StatefulWidget {
  final String label;
  final String hint;
  final Icon iconData;
  final TextEditingController controller;
  final List<String> items;

  AnimatedCustomDropdown({
    required this.controller,
    required this.label,
    required this.hint,
    required this.iconData,
    required this.items,
  });

  @override
  _AnimatedCustomDropdownState createState() => _AnimatedCustomDropdownState();
}

class _AnimatedCustomDropdownState extends State<AnimatedCustomDropdown> {
  String? selectedValue;
  List<String> filteredItems = [];
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void filterItems(String query) {
    setState(() {
      filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center,),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      widget.iconData,
                      SizedBox(width: 8),
                      Text(selectedValue ?? widget.hint),
                    ],
                  ),
                  Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            TextField(
              onChanged: filterItems,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView(
                children: filteredItems
                    .map((item) => ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      selectedValue = item;
                      widget.controller.text = item; // Store selected value
                      isExpanded = false;
                    });
                  },
                ))
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
