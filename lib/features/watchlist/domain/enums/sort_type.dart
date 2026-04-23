/// Enum representing the available sort options for the watchlist.
enum SortType {
  /// Default drag-and-drop order (original repository order).
  manual,

  /// Symbol A → Z.
  nameAZ,

  /// Symbol Z → A.
  nameZA,

  /// LTP descending (highest price first).
  priceHighToLow,

  /// LTP ascending (lowest price first).
  priceLowToHigh,

  /// Highest % change first.
  gainers,

  /// Lowest % change first (most negative).
  losers,
}

/// Extension providing display labels and icons for [SortType].
extension SortTypeExtension on SortType {
  /// Human-readable label for the sort type.
  String get label {
    switch (this) {
      case SortType.manual:
        return 'Manual Order';
      case SortType.nameAZ:
        return 'Name: A → Z';
      case SortType.nameZA:
        return 'Name: Z → A';
      case SortType.priceHighToLow:
        return 'Price: High to Low';
      case SortType.priceLowToHigh:
        return 'Price: Low to High';
      case SortType.gainers:
        return 'Top Gainers';
      case SortType.losers:
        return 'Top Losers';
    }
  }

  /// Description text for the sort type.
  String get description {
    switch (this) {
      case SortType.manual:
        return 'Drag-and-drop custom order';
      case SortType.nameAZ:
        return 'Alphabetical ascending';
      case SortType.nameZA:
        return 'Alphabetical descending';
      case SortType.priceHighToLow:
        return 'Highest LTP first';
      case SortType.priceLowToHigh:
        return 'Lowest LTP first';
      case SortType.gainers:
        return 'Highest % change first';
      case SortType.losers:
        return 'Most negative % change first';
    }
  }
}
