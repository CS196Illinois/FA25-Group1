# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an RSO (Registered Student Organization) Organizer app built with Flutter. The app allows users to browse RSOs, join them, view events on a calendar, and create custom events. The primary codebase is located in the `App/` directory.

## Development Commands

### Running the Application
```bash
cd FA25-Group1/App
flutter run
```

### Testing
```bash
cd FA25-Group1/App
flutter test
```

### Installing Dependencies
```bash
cd FA25-Group1/App
flutter pub get
```

### Building
```bash
cd FA25-Group1/App
# For Android
flutter build apk

# For iOS
flutter build ios

# For Web
flutter build web
```

### Code Analysis
```bash
cd FA25-Group1/App
flutter analyze
```

## Architecture

### Application Flow
1. **Sign-in Page** (`sign-in-page.dart`): Entry point with animated login UI
   - Currently decorative only (no authentication logic implemented)
   - Routes to RsoListPage on login button tap

2. **RSO List Page** (`rso_list_page.dart`): Main page displaying all available RSOs
   - Users can toggle membership with a switch
   - Clicking "favorite" icon navigates to MyRSOPage to view joined RSOs
   - Floating action button navigates to CalendarPage
   - When joining/leaving an RSO, events are synced to CalendarManager

3. **My RSO Page** (`my_rso_page.dart`): Displays user's joined RSOs
   - Uses ExpansionTile to show RSO details and associated events

4. **Calendar Page** (`calendar_page.dart`): Unified calendar view using Syncfusion
   - Shows all events from joined RSOs
   - Add button in app bar navigates to FormPage to create custom events
   - Uses CalendarManager as the single source of truth for events
   - Color-codes events by RSO using hashed colors

5. **Form Page** (`form_page.dart`): Event creation form
   - Allows users to create custom events with title, location, date, and times
   - Returns newly created RsoEvent to CalendarPage

### State Management

**CalendarManager** (`calendar_manager.dart`): Singleton using ChangeNotifier pattern
- Centralized state management for all calendar events
- Methods:
  - `addEvent(RsoEvent)`: Add a single event
  - `removeEvent(RsoEvent)`: Remove a single event
  - `addRsoEvents(List<RsoEvent>)`: Bulk add RSO events when user joins
  - `removeRsoEvents(List<RsoEvent>)`: Bulk remove RSO events when user leaves
  - `rebuildEventsFromJoinedRsos(List<RSO>)`: Rebuild entire event list
- All pages that display events should listen to CalendarManager for updates

### Data Models

**RSO** (`rso.dart`): Represents a student organization
- Properties: `name`, `description`, `isMember`, `events`
- Events list contains RsoEvent objects

**RsoEvent** (`rso.dart`): Represents a calendar event
- Properties: `title`, `description`, `location`, `rso`, `startTime`, `endTime`
- Each event maintains a reference back to its parent RSO

### Key Dependencies

From `pubspec.yaml`:
- `table_calendar: ^3.0.8` - Calendar widget (note: Syncfusion is actually used in code)
- `syncfusion_flutter_calendar: ^31.2.5` - Calendar UI component (primary calendar)
- `syncfusion_flutter_core: ^31.2.5` - Syncfusion core library
- `animate_do: ^3.1.2` - Animation library for sign-in page
- `cupertino_icons: ^1.0.8` - iOS-style icons

### File Structure

```
App/
├── lib/
│   ├── main.dart              # App entry point, defines MyApp
│   ├── sign-in-page.dart      # Login screen (decorative)
│   ├── rso_list_page.dart     # Browse & join RSOs
│   ├── my_rso_page.dart       # View joined RSOs
│   ├── calendar_page.dart     # Unified calendar view
│   ├── form_page.dart         # Create custom events
│   ├── calendar_manager.dart  # Global event state manager
│   └── rso.dart              # Data models (RSO & RsoEvent)
├── assets/images/             # UI assets for sign-in page
├── pubspec.yaml              # Dependencies and configuration
└── test/                     # Test files
```

## Development Notes

### Adding New Features
- Always update CalendarManager when modifying event-related functionality
- Use `notifyListeners()` in CalendarManager after state changes
- Maintain bidirectional references between RSO and RsoEvent

### RSO Sample Data
Currently, RSO data is hardcoded in `rso_list_page.dart` initState(). Sample RSOs include:
- Society of Women Engineers (SWE)
- Open Source @ Illinois
- WCS: Women in Computer Science
- Project Code
- Hack for Impact
- Illinois Business Consulting (IBC)
- Champaign-Urbana Business and Engineering (CUBE)
- Accounting Club
- ACM: Association for Computing Machinery

Each RSO contains pre-populated sample events with realistic dates, times, and locations.

### Theme
- Primary color scheme: Orange (`ColorScheme.fromSeed(seedColor: Colors.orange)`)
- Sign-in page uses purple/blue gradient (`Color.fromRGBO(143, 148, 251, 1)`)