import 'package:equatable/equatable.dart';
import '../../domain/enums/sort_type.dart';

/// Base class for all watchlist events.
abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

/// Event to trigger initial watchlist data load.
class WatchlistLoaded extends WatchlistEvent {
  const WatchlistLoaded();
}

/// Event to reorder stocks via drag-and-drop.
class WatchlistReordered extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  const WatchlistReordered({
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

/// Event to sort the watchlist by a given criteria.
class WatchlistSortRequested extends WatchlistEvent {
  final SortType sortType;

  const WatchlistSortRequested({required this.sortType});

  @override
  List<Object?> get props => [sortType];
}
