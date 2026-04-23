import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/models/stock_model.dart';
import 'drag_handle.dart';

/// A clean stock row tile displaying symbol, price, and change data.
class StockTile extends StatelessWidget {
  final Stock stock;
  final int index;

  const StockTile({
    super.key,
    required this.stock,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPositive = stock.isPositive;
    final Color changeColor = isPositive
        ? AppColors.gainGreen
        : AppColors.lossRed;
    final Color tagBackground = isPositive
        ? AppColors.greenTagBg
        : AppColors.redTagBg;
    final String changePrefix = isPositive ? '+' : '';

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.divider),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Stock info column
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stock.symbol,
                  style: const TextStyle(
                    color: AppColors.primaryNavy,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stock.companyName,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Price and change column
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${stock.ltp.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$changePrefix${stock.change.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: changeColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 6),
                    _buildChangeTag(changePrefix, changeColor, tagBackground),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),
          DragHandle(index: index),
        ],
      ),
    );
  }

  Widget _buildChangeTag(
    String prefix,
    Color textColor,
    Color backgroundColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$prefix${stock.changePercent.abs().toStringAsFixed(2)}%',
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
