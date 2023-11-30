import 'package:flutter/material.dart';
import 'package:graph_manager/utils/colors.dart';

class GraphCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool?)? onChanged;

  const GraphCheckBox(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged!(value);
      },
      child: Container(
        decoration: BoxDecoration(
          color: value ? mainColor : Colors.transparent,
          border: Border.all(
            width: 2,
            color: mainColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 30,
        width: 30,
        child: !value
            ? null
            : const Icon(
                Icons.check,
                color: white,
                size: 25,
              ),
      ),
    );
  }
}
