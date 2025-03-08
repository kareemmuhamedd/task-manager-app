# 📋 Management Tasks App

A comprehensive Flutter application designed to manage tasks efficiently. This project leverages various features and libraries to provide a robust task management solution.

## ✨ Features

- 🔒 **Authentication**: Secure login and user management.
- 📋 **Task Management**: Create, update, delete, and view tasks.
- 📜 **Pagination**: Efficiently handle large lists of tasks with pagination.
- 👤 **Profile Management**: Manage user profiles with detailed information.
- 🌐 **Network Handling**: Robust error handling and network management.
- 💾 **Local Storage**: Store data locally using Hive for offline access.
- 📱 **Responsive UI**: Adaptive layouts for different screen sizes.

## 📂 Project Structure

The project is organized into the following main directories:

- **lib**: Contains the main application code.
  - **app**: Application-level configurations and initializations.
    - **bloc**: Business logic components for the app.
    - **di**: Dependency injection setup.
    - **routes**: Application routes.
    - **view**: Main app views.
  - **features**: Feature-specific code.
    - **auth**: Authentication-related code.
      - **data**: Data models and data sources.
      - **domain**: Domain logic and use cases.
      - **presentation**: UI and presentation logic.
    - **todos**: Task management-related code.
      - **data**: Data models and data sources.
      - **domain**: Domain logic and use cases.
      - **presentation**: UI and presentation logic.
  - **shared**: Shared utilities, widgets, and services.

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: Ensure you have Flutter installed. This project uses Flutter version `3.5.4`. You can download Flutter from [flutter.dev](https://flutter.dev).

### Installation

1. **Clone the repository**:
    ```sh
    git clone https://github.com/your-username/management_tasks_app.git
    cd management_tasks_app
    ```

2. **Install dependencies**:
    ```sh
    flutter pub get
    ```

3. **Run the application**:
    ```sh
    flutter run
    ```

### Running Tests

To run the tests, use the following command:
```sh
flutter test

```


📸 Screenshots


<img src="https://github.com/user-attachments/assets/a9fb6b13-2732-42a8-a48e-41c8d98ad3d1" width="300">
<img src="https://github.com/user-attachments/assets/6376a97d-bc78-4581-b49e-ddfc646433e0" width="300">
<img src="https://github.com/user-attachments/assets/c7d90ad6-273f-4db4-8124-538805c75f57" width="300">
<img src="https://github.com/user-attachments/assets/ca4d89a8-9c0c-47ac-9c3a-1f1ca0d360ce" width="300">

