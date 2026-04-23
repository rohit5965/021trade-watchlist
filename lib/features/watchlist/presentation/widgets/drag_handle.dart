import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// A drag handle widget for reorderable list items.
///
/// Wraps [ReorderableDragStartListener] around a subtle grip icon,
/// enabling drag initiation for the item at [index].
class DragHandle extends StatelessWidget {
  final int index;

  const DragHandle({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      index: index,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.drag_indicator_rounded,
          color: AppColors.dragHandle,
          size: 20,
        ),
      ),
    );
  }
}
