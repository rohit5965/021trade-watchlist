import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/enums/sort_type.dart';

/// A sort option tile with icon, label, and active state indicator.
class SortOptionTile extends StatelessWidget {
  final SortType sortType;
  final bool isActive;
  final VoidCallback onTap;

  const SortOptionTile({
    super.key,
    required this.sortType,
    required this.isActive,
    required this.onTap,
  });

  IconData get _icon {
    switch (sortType) {
      case SortType.manual:
        return Icons.drag_indicator_rounded;
      case SortType.nameAZ:
        return Icons.sort_by_alpha_rounded;
      case SortType.nameZA:
        return Icons.sort_by_alpha_rounded;
      case SortType.priceHighToLow:
        return Icons.arrow_downward_rounded;
      case SortType.priceLowToHigh:
        return Icons.arrow_upward_rounded;
      case SortType.gainers:
        return Icons.trending_up_rounded;
      case SortType.losers:
        return Icons.trending_down_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.greenTagBg
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isActive
                    ? AppColors.gainGreen
                    : AppColors.divider,
              ),
            ),
            child: Row(
              children: [
                // Leading icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.gainGreen.withValues(alpha: 0.1)
                        : AppColors.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _icon,
                    color: isActive
                        ? AppColors.gainGreen
                        : AppColors.textSecondary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),

                // Label and description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sortType.label,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        sortType.description,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                // Trailing checkmark
                if (isActive)
                  const Icon(
                    Icons.check_rounded,
                    color: AppColors.gainGreen,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
