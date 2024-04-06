# social_discovery_group

Test task for Social Discovery Group

## App Description

When you launch the app it will load you dropdown with list of countries, when you select country it
will load you list of cities in that country. When you select city it will load you list of states.

## Architecture

Here used clean architecture. Presentation->Domain->Data
But I've removed usecases and entities from domain layer because there was no need for extra
complication
For state management used Bloc library

## Crashlytics

I've also added Crashlytics for crash reporting, you just need to provide sentrySDN

## Environment variables
Also there's Env variables set-up inside env folder, to set configs from file you should run it
using this command "flutter run --dart-define-from-file=env/prod.json"
but app will work even if you run with just flutter run, because in environment_configs fallback values are provided

## Testing

Test Coverage is 86.7%
Covered with unit and golden tests.

to see test coverage run commands:

- flutter test --coverage && remove_from_coverage -f coverage/lcov.info -r '\.g\.dart$'
- genhtml coverage/lcov.info -o coverage/html
- open coverage/html/index.html

## Getting Started And Prerequisites

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Built With

* [Flutter](https://flutter.dev/) - The framework used
* [Bloc](https://bloclibrary.dev/#/) - State management
* [Dio](https://pub.dev/packages/dio) - Networking
* [GetIt](https://pub.dev/packages/get_it) - Service Locator
