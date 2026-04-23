import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/enums/sort_type.dart';
import '../../domain/models/stock_model.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../bloc/watchlist_state.dart';
import '../widgets/stock_tile.dart';
import 'sort_watchlist_page.dart';

/// Main watchlist page with a reorderable stock list.
class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  // TODO: add search functionality in next sprint

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistInitial) {
            return _buildLoadingIndicator();
          } else if (state is WatchlistLoadFailure) {
            return _buildErrorMessage(state.error);
          } else if (state is WatchlistLoadSuccess) {
            return _buildStockList(context, state.stocks);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primaryNavy,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                '021',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          BlocBuilder<WatchlistBloc, WatchlistState>(
            builder: (context, state) {
              final activeSortType = state is WatchlistLoadSuccess
                  ? state.activeSortType
                  : SortType.manual;
              final hasCustomSort = activeSortType != SortType.manual;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Watchlist',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (hasCustomSort)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        'Sorted by: ${activeSortType.label}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.sort_rounded,
            color: AppColors.primaryNavy,
            size: 24,
          ),
          onPressed: () => _navigateToSortPage(context),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: AppColors.divider),
      ),
    );
  }

  void _navigateToSortPage(BuildContext context) {
    final watchlistBloc = context.read<WatchlistBloc>();

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return BlocProvider.value(
            value: watchlistBloc,
            child: const SortWatchlistPage(),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryNavy,
        strokeWidth: 2,
      ),
    );
  }

  Widget _buildErrorMessage(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.lossRed,
              size: 32,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load watchlist',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockList(BuildContext context, List<Stock> stocks) {
    return Column(
      children: [
        _buildSummaryBar(stocks),
        Expanded(
          child: ReorderableListView.builder(
            buildDefaultDragHandles: false,
            proxyDecorator: _buildDragProxy,
            itemCount: stocks.length,
            onReorder: (oldIndex, newIndex) {
              context.read<WatchlistBloc>().add(
                    WatchlistReordered(
                      oldIndex: oldIndex,
                      newIndex: newIndex,
                    ),
                  );
            },
            itemBuilder: (context, index) {
              final stock = stocks[index];
              return StockTile(
                key: ValueKey(stock.id),
                stock: stock,
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryBar(List<Stock> stocks) {
    final gainerCount = stocks.where((s) => s.isPositive).length;
    final loserCount = stocks.length - gainerCount;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.divider),
        ),
      ),
      child: Row(
        children: [
          Text(
            '${stocks.length} stocks',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            '$gainerCount gainers',
            style: const TextStyle(
              color: AppColors.gainGreen,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '$loserCount losers',
            style: const TextStyle(
              color: AppColors.lossRed,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Proxy widget shown while dragging a stock tile.
  Widget _buildDragProxy(
    Widget child,
    int index,
    Animation<double> animation,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final double elevationValue =
            8.0 * Curves.easeInOut.transform(animation.value);

        return Material(
          elevation: elevationValue,
          color: AppColors.surface,
          shadowColor: Colors.black26,
          borderRadius: BorderRadius.circular(8),
          child: child,
        );
      },
      child: child,
    );
  }
}
