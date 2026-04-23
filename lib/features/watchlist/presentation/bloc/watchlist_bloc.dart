import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/watchlist_repository.dart';
import '../../domain/enums/sort_type.dart';
import '../../domain/models/stock_model.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

/// BLoC managing the watchlist feature state.
///
/// Handles loading stock data, drag-and-drop reordering,
/// and sorting by various criteria.
class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistRepository _repository;

  /// Cached original order for restoring manual sort.
  List<Stock> _originalStocks = [];

  WatchlistBloc({required WatchlistRepository repository})
      : _repository = repository,
        super(const WatchlistInitial()) {
    on<WatchlistLoaded>(_onLoaded);
    on<WatchlistReordered>(_onReordered);
    on<WatchlistSortRequested>(_onSortRequested);
  }

  void _onLoaded(
    WatchlistLoaded event,
    Emitter<WatchlistState> emit,
  ) {
    try {
      final stocks = _repository.getWatchlist();
      _originalStocks = List.of(stocks);
      emit(WatchlistLoadSuccess(stocks: stocks));
    } catch (error) {
      emit(WatchlistLoadFailure(error: error.toString()));
    }
  }

  void _onReordered(
    WatchlistReordered event,
    Emitter<WatchlistState> emit,
  ) {
    final currentState = state;
    if (currentState is WatchlistLoadSuccess) {
      final stocks = List.of(currentState.stocks);
      int adjustedNewIndex = event.newIndex;

      // Flutter offsets newIndex by 1 when dragging downward
      if (event.oldIndex < adjustedNewIndex) {
        adjustedNewIndex -= 1;
      }

      final movedStock = stocks.removeAt(event.oldIndex);
      stocks.insert(adjustedNewIndex, movedStock);

      _originalStocks = List.of(stocks);

      emit(WatchlistLoadSuccess(
        stocks: stocks,
        activeSortType: SortType.manual,
      ));
    }
  }

  void _onSortRequested(
    WatchlistSortRequested event,
    Emitter<WatchlistState> emit,
  ) {
    final currentState = state;
    if (currentState is WatchlistLoadSuccess) {
      final sortedStocks = _applySorting(
        List.of(_originalStocks),
        event.sortType,
      );

      emit(WatchlistLoadSuccess(
        stocks: sortedStocks,
        activeSortType: event.sortType,
      ));
    }
  }

  /// Sorts the stock list based on [sortType].
  /// For manual, restores the cached original order.
  List<Stock> _applySorting(List<Stock> stocks, SortType sortType) {
    switch (sortType) {
      case SortType.manual:
        return List.of(_originalStocks);
      case SortType.nameAZ:
        stocks.sort((a, b) => a.symbol.compareTo(b.symbol));
        return stocks;
      case SortType.nameZA:
        stocks.sort((a, b) => b.symbol.compareTo(a.symbol));
        return stocks;
      case SortType.priceHighToLow:
        stocks.sort((a, b) => b.ltp.compareTo(a.ltp));
        return stocks;
      case SortType.priceLowToHigh:
        stocks.sort((a, b) => a.ltp.compareTo(b.ltp));
        return stocks;
      case SortType.gainers:
        stocks.sort((a, b) => b.changePercent.compareTo(a.changePercent));
        return stocks;
      case SortType.losers:
        stocks.sort((a, b) => a.changePercent.compareTo(b.changePercent));
        return stocks;
    }
  }
}
