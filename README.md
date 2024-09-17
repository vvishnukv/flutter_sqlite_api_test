# Flutter API and SQLite Example

This Flutter application demonstrates how to fetch data from an API, store it in a local SQLite database, and display it in a visually appealing way. The app fetches posts from the JSONPlaceholder API, stores them in a SQLite database using the `sqflite` package, and displays them in a list of colorful cards.

## Features

- Fetch posts from JSONPlaceholder API
- Store posts in a local SQLite database
- Display posts in floating cards with varying colors based on user ID
- Stylish UI with bold titles and regular body text

## Getting Started

To run this project on your local machine, follow these steps:

### Prerequisites

- Flutter SDK installed
- A compatible IDE (e.g., Android Studio, VS Code)
- An emulator or physical device for testing

### Installation

1. Clone the repository:

    ```bash
    https://github.com/vvishnukv/flutter_sqlite_api_test.git
    ```

2. Navigate to the project directory:

    ```bash
    cd flutter_sqlite_api_test
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

### Running the App

1. Make sure you have an emulator running or a physical device connected.
2. Run the app:

    ```bash
    flutter run
    ```

## Project Structure

- `lib/`: Contains all Dart code for the application.
  - `api_service.dart`: Handles API calls to JSONPlaceholder.
  - `database_helper.dart`: Manages SQLite database operations.
  - `main.dart`: Entry point of the application, initializes and runs the app.
- `pubspec.yaml`: Lists dependencies and project metadata.

## Dependencies

- `flutter`: The Flutter framework.
- `sqflite`: SQLite plugin for Flutter.
- `path`: For managing file paths.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [JSONPlaceholder](https://jsonplaceholder.typicode.com) for the free fake API.
- [sqflite](https://pub.dev/packages/sqflite) for the SQLite integration.

## Contact

If you have any questions or suggestions, please feel free to reach out:

- Vishnukasuhikvarma@gmail.com
- **GitHub**: [vvishnukv](https://github.com/vvishnukv)

