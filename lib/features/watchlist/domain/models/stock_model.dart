import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// Immutable stock data model for watchlist items.
class Stock extends Equatable {
  final String id;
  final String symbol;
  final String companyName;
  final double ltp;
  final double change;
  final double changePercent;

  const Stock({
    required this.id,
    required this.symbol,
    required this.companyName,
    required this.ltp,
    required this.change,
    required this.changePercent,
  });

  /// Whether the stock's change is positive or zero.
  bool get isPositive => change >= 0;

  /// Factory constructor from a map.
  factory Stock.fromMap(Map<String, dynamic> map) {
    // Be explicit about fallback ID instead of using null coalescing
    final String stockId;
    if (map['id'] != null) {
      stockId = map['id'] as String;
    } else {
      stockId = const Uuid().v4();
    }

    return Stock(
      id: stockId,
      symbol: map['symbol'] as String,
      companyName: map['companyName'] as String,
      ltp: (map['ltp'] as num).toDouble(),
      change: (map['change'] as num).toDouble(),
      changePercent: (map['changePercent'] as num).toDouble(),
    );
  }

  /// Creates a copy of this Stock with the given fields replaced.
  Stock copyWith({
    String? id,
    String? symbol,
    String? companyName,
    double? ltp,
    double? change,
    double? changePercent,
  }) {
    return Stock(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      companyName: companyName ?? this.companyName,
      ltp: ltp ?? this.ltp,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
    );
  }

  @override
  List<Object?> get props => [
        id,
        symbol,
        companyName,
        ltp,
        change,
        changePercent,
      ];

  @override
  String toString() =>
      'Stock(symbol: $symbol, ltp: $ltp, change: $change)';
}
