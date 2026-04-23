# 021 Trade Watchlist

A Flutter watchlist app I built to demonstrate clean BLoC architecture
with drag-and-drop stock reordering and sorting.

## Why This Design

I decided to go with a light, flat UI instead of the typical dark trading theme.
Most trading apps overdo the dark mode with neon greens and glowing effects —
I wanted something that feels like an actual professional tool, not a sci-fi dashboard.

The font pairing (Sora for headings + IBM Plex Sans for body) was intentional
to avoid the "Inter/Roboto default" look that makes apps feel template-generated.

## Architecture

I went with a feature-first folder structure because it keeps related files together
and makes the codebase easier to navigate as it grows:

```
lib/
├── main.dart
├── app/
│   └── app.dart                     # MaterialApp + BlocProvider
├── core/
│   ├── theme/
│   │   └── app_theme.dart           # Light theme with Sora + IBM Plex Sans
│   └── constants/
│       └── app_colors.dart          # Centralized color palette
└── features/
    └── watchlist/
        ├── data/
        │   └── watchlist_repository.dart
        ├── domain/
        │   ├── models/
        │   │   └── stock_model.dart
        │   └── enums/
        │       └── sort_type.dart
        └── presentation/
            ├── bloc/
            │   ├── watchlist_bloc.dart
            │   ├── watchlist_event.dart
            │   └── watchlist_state.dart
            ├── pages/
            │   ├── watchlist_page.dart
            │   └── sort_watchlist_page.dart
            └── widgets/
                ├── stock_tile.dart
                ├── sort_option_tile.dart
                └── drag_handle.dart
```

## State Management

All business logic flows through the BLoC. No `setState()` calls anywhere.

**Events:**
- `WatchlistLoaded` — fetches initial stock data from repository
- `WatchlistReordered` — handles drag-and-drop index changes
- `WatchlistSortRequested` — sorts by price, name, gainers, or losers

**States:**
- `WatchlistInitial` — loading spinner
- `WatchlistLoadSuccess` — stock list + active sort type
- `WatchlistLoadFailure` — error message

## Design Decisions

### Color Palette
I picked muted, professional colors instead of the typical bright trading accents:
- **Green**: `#079455` — subdued, not neon
- **Red**: `#D92D20` — firm but not alarming
- **Navy**: `#1A1A2E` — primary accent for text and icons
- **Background**: `#F5F5F5` — off-white, easy on the eyes

### Drag & Drop
- Custom `ReorderableDragStartListener` on a dedicated drag handle
- Default handles disabled via `buildDefaultDragHandles: false`
- Reordering resets any active sort back to manual order

### Sorting
The sort screen lets you pick from 7 sort options (manual, A-Z, Z-A,
price high/low, gainers, losers). Tapping one applies immediately
and navigates back. I chose immediate-apply over a confirmation button
because it felt more natural in testing.

## Running

```bash
flutter pub get
flutter run
```

## Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_bloc` | BLoC state management |
| `equatable` | Value equality for events, states, models |
| `uuid` | Unique IDs for stock items |
| `google_fonts` | Sora + IBM Plex Sans typography |

## What I'd Add Next

- Search and filter functionality
- WebSocket-based live price updates
- Multiple watchlist tabs
- Swipe-to-delete stocks