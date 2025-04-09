import 'package:flutter/material.dart';
import 'package:recipe_app/ui/color_styles.dart';
import 'package:recipe_app/ui/text_styles.dart';

class MultiTabs extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final void Function(int) onValueChange;

  const MultiTabs({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onValueChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          labels.map((label) {
            final int labelIndex = labels.indexOf(label);
            return GestureDetector(
              onTap: () {
                onValueChange(labelIndex);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                width: 150,
                height: 33,
                decoration: BoxDecoration(
                  color:
                      labelIndex == selectedIndex
                          ? ColorStyle.primary100
                          : ColorStyle.gray3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: AppTextStyles.smallBold.copyWith(
                      color: ColorStyle.white,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
