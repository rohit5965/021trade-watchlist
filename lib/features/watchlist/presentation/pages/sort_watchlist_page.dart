import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/enums/sort_type.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../bloc/watchlist_state.dart';
import '../widgets/sort_option_tile.dart';

/// Full-page sort screen for choosing watchlist sort criteria.
///
/// Shares the same [WatchlistBloc] instance via BlocProvider.value,
/// so sort changes reflect immediately on the watchlist.
class SortWatchlistPage extends StatelessWidget {
  const SortWatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            final activeSortType = state is WatchlistLoadSuccess
                ? state.activeSortType
                : SortType.manual;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                _buildTitleSection(),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 4, bottom: 24),
                    itemCount: SortType.values.length,
                    itemBuilder: (context, index) {
                      final sortType = SortType.values[index];
                      return SortOptionTile(
                        sortType: sortType,
                        isActive: sortType == activeSortType,
                        onTap: () => _handleSortTap(
                          context,
                          sortType,
                          activeSortType,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: AppColors.primaryNavy,
          size: 24,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.sort_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Sort Watchlist',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Choose how to arrange your stocks',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  void _handleSortTap(
    BuildContext context,
    SortType selectedSort,
    SortType currentSort,
  ) {
    if (selectedSort != currentSort) {
      context.read<WatchlistBloc>().add(
            WatchlistSortRequested(sortType: selectedSort),
          );
    }
    Navigator.of(context).pop();
  }
}
