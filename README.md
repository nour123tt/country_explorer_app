# 🌍 **Country Explorer App** 

**Polytech INTL 2025/2026**

Welcome to the **Country Explorer App**! This Flutter-based app allows users to explore and interact with a list of countries, view detailed information, and save their favorite countries. It includes smooth animations, search functionality, and support for both light and dark themes.

---

## 📖 **Table of Contents**
1. [Project Overview](#project-overview)
2. [Features](#features)
3. [Setup Instructions](#setup-instructions)
4. [Core Structure](#core-structure)
5. [Technologies Used](#technologies-used)
6. [Usage](#usage)
7. [Contributing](#contributing)
8. [License](#license)

---

## 🚀 **Project Overview**

The **Country Explorer App** is a fun and educational Flutter project where you can:

- 🌍 **Explore countries**: View flags, names, capitals, and more.
- 🇺🇳 **Detailed country info**: Dive into population, region, languages, and more.
- ❤️ **Favorite countries**: Save your favorite countries with a heart icon.
- 🔄 **Pull to refresh**: Refresh the list with a simple pull-down.
- 🔎 **Search bar**: Quickly search for countries by name.
- 🎨 **Light/Dark theme toggle**: Switch between light and dark modes.

---

## 🎯 **Features**

### Core Features

- **PS-01**: Organized project structure with models, screens, and services
- **PS-02**: Stable app that doesn’t crash
- **DH-01**: Country class matching the API data
- **DH-02**: HTTP calls to fetch country data
- **DH-03**: Graceful error handling (what if the API is down?)
- **DH-04**: Loading spinners during data fetch

### Main Screen

- **MS-01**: App with "Country Explorer" title
- **MS-02**: Grid view displaying all countries
- **MS-03**: Each country card shows its flag, name, and capital
- **MS-04**: StatelessWidget for country cards
- **MS-05**: Pull-to-refresh functionality for country list

### Navigation

- **NV-01**: Tap on a country to view its details
- **NV-02**: Detailed country info screen
- **NV-03**: Easy navigation back to the main screen
- **NV-04**: StatefulWidget for details screen

### State Management

- **SM-01**: State managed by **Provider**
- **SM-02**: Properly set up provider in the main file
- **SM-03**: Provider used in widgets

### Bonus Features

- **BON-01**: Search bar to find countries quickly
- **BON-02**: Heart icon to save favorites
- **BON-03**: Toggle between light and dark modes
- **BON-04**: Sort by name, population, etc.
- **BON-05**: Smooth animations between screens
- **BON-06**: Optional weather or currency integration
- **BON-07**: Beautiful and modern UI

---

## ⚙️ **Setup Instructions**

### Prerequisites

Before running the app, make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- An IDE like **VS Code** or **Android Studio**
- A device/emulator to run the app

### Installing

1. Clone the repository to your local machine:

    ```bash
    git clone https://github.com/yourusername/country-explorer-app.git
    ```

2. Navigate to the project directory:

    ```bash
    cd country-explorer-app
    ```

3. Install the dependencies:

    ```bash
    flutter pub get
    ```

4. Run the app:

    ```bash
    flutter run
    ```

---

## 🗂️ **Core Structure**
lib/
├── models/ # Contains data models like Country
├── screens/ # Contains different screens (Main, Detail)
├── services/ # For HTTP calls and services
├── providers/ # State management using Provider
└── main.dart # Main entry point of the app


### Key Files

- `country.dart`: Defines the `Country` class that matches the API data.
- `http_service.dart`: Handles HTTP requests to fetch country data.
- `main_screen.dart`: Displays the grid of countries.
- `detail_screen.dart`: Shows detailed information about a selected country.
- `country_provider.dart`: Manages the state with **Provider**.

---

## 🛠️ **Technologies Used**

- **Flutter**: Cross-platform framework to build the app.
- **Dart**: Programming language for Flutter.
- **Provider**: State management solution for Flutter apps.
- **HTTP**: For making API requests to fetch country data.
- **Intl**: For handling date/time formatting, if necessary.

---

## 🚶‍♂️ **Usage**

### Main Features

1. **View Countries**: See a grid of countries with their flag, name, and capital.
2. **View Details**: Tap on a country to see detailed info, such as population, region, languages, etc.
3. **Save Favorites**: Use the heart icon to mark your favorite countries.
4. **Search**: Quickly find countries using the search bar.
5. **Refresh**: Pull down to refresh the list and get updated data.
6. **Toggle Themes**: Switch between light and dark modes to fit your preference.
7. **Sort**: Sort the countries by attributes like name, population, etc.

---

## 🤝 **Contributing**

We welcome contributions! If you would like to help improve this app, here are some ways you can contribute:

- 🐛 **Fix bugs** or enhance existing features
- 🎨 **Improve the UI/UX** for a better experience
- 📝 **Write documentation** or create tutorials
- 🔧 **Add new functionality** or integrate additional data sources

Make sure your contributions follow the project's coding guidelines and are properly tested.

---

## 📜 **License**

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.

---

Let me know if you need any more adjustments, or if you'd like to add more details! 😊

The project structure is organized as follows:

