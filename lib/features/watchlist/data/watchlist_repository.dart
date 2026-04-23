import 'package:uuid/uuid.dart';
import '../domain/models/stock_model.dart';

/// Repository providing hardcoded Indian stock watchlist data.
class WatchlistRepository {
  static final _uuid = const Uuid();

  /// Returns a list of hardcoded Indian stocks with realistic data.
  List<Stock> getWatchlist() {
    return [
      Stock(
        id: _uuid.v4(),
        symbol: 'RELIANCE',
        companyName: 'Reliance Industries Ltd.',
        ltp: 2487.65,
        change: 32.40,
        changePercent: 1.32,
      ),
      Stock(
        id: _uuid.v4(),
        symbol: 'TCS',
        companyName: 'Tata Consultancy Services Ltd.',
        ltp: 3542.10,
        change: -18.75,
        changePercent: -0.53,
      ),
      Stock(
        id: _uuid.v4(),
        symbol: 'INFY',
        companyName: 'Infosys Ltd.',
        ltp: 1456.30,
        change: 12.50,
        changePercent: 0.87,
      ),
      Stock(
        id: _uuid.v4(),
        symbol: 'HDFCBANK',
        companyName: 'HDFC Bank Ltd.',
        ltp: 1672.85,
        change: -8.20,
        changePercent: -0.49,
      ),
      Stock(
        id: _uuid.v4(),
        symbol: 'ICICIBANK',
        companyName: 'ICICI Bank Ltd.',
        ltp: 1087.50,
        change: 15.30,
        changePercent: 1.43,
      ),
      Stock(
        id: _uuid.v4(),
        symbol: 'SBIN',
        companyName: 'State Bank of India',
        ltp: 625.40,
        change: -4.60,
        changePercent: -0.73,
      ),
      Stock(
        id: _uuid.v4(),
        symbol: 'WIPRO',
        companyName: 'Wipro Ltd.',
        ltp: 412.75,
        change: 5.85,
        changePercent: 1.44,
      ),
      Stock(
        id: _uuid.v4(),
        symbol: 'AXISBANK',
        companyName: 'Axis Bank Ltd.',
        ltp: 1134.20,
        change: -12.90,
        changePercent: -1.12,
      ),
      Stock(
        id: _uuid.v4(),
        symbol: 'BAJFINANCE',
        companyName: 'Bajaj Finance Ltd.',
        ltp: 6845.50,
        change: 78.25,
        changePercent: 1.16,
      ),
      Stock(
        id: _uuid.v4(),
        symbol: 'LT',
        companyName: 'Larsen & Toubro Ltd.',
        ltp: 3267.90,
        change: -22.15,
        changePercent: -0.67,
      ),
    ];
  }
}
