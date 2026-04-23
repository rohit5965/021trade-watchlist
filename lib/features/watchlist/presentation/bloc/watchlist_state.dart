import 'package:equatable/equatable.dart';
import '../../domain/enums/sort_type.dart';
import '../../domain/models/stock_model.dart';

/// Base class for all watchlist states.
abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

/// Initial state before data is loaded.
class WatchlistInitial extends WatchlistState {
  const WatchlistInitial();
}

/// State when watchlist data is successfully loaded.
class WatchlistLoadSuccess extends WatchlistState {
  final List<Stock> stocks;
  final SortType activeSortType;

  const WatchlistLoadSuccess({
    required this.stocks,
    this.activeSortType = SortType.manual,
  });

  @override
  List<Object?> get props => [stocks, activeSortType];
}

/// State when watchlist loading fails.
class WatchlistLoadFailure extends WatchlistState {
  final String error;

  const WatchlistLoadFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
