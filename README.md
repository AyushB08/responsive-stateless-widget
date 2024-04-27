# Flutter To-Do App Without StatefulWidget

This app contains the same UI and functionality as https://github.com/AyushB08/flutter-todo-app. However, I was tasked with creating the same app WITHOUT relying on the StatefulWidget class, which I previously didn't know was feasible. After some research, I found a solution that leverages ChangeNotifier and ValueNotifier from the Provider package. Instead of using setState() and the StatefulWidget class which updates the entire widget tree, this version of the app only updates the required widgets (todo_item.dart). This approach allows for more granular updates to only the necessary widgets, which is crucial for complex applications. Most of the state management for this app occurs in the WidgetManager class in the main.dart file. Working on this project strengthened my understanding of state management with Flutter.

# Demo Video

[Demo Video](https://www.youtube.com/shorts/u_bT3LcIoC4)
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

