import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/app_theme.dart';
import '../features/watchlist/data/watchlist_repository.dart';
import '../features/watchlist/presentation/bloc/watchlist_bloc.dart';
import '../features/watchlist/presentation/bloc/watchlist_event.dart';
import '../features/watchlist/presentation/pages/watchlist_page.dart';

/// Root application widget with BlocProvider and theme setup.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '021 Trade Watchlist',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: BlocProvider(
        create: (context) => WatchlistBloc(
          repository: WatchlistRepository(),
        )..add(const WatchlistLoaded()),
        child: const WatchlistPage(),
      ),
    );
  }
}
