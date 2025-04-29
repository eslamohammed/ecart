# 🛒 ECart - Flutter E-commerce Demo App

A simple yet complete e-commerce Flutter application that displays products from a mock API with offline caching support using SQLite. The app follows clean architecture and uses the BLoC (flutter_bloc) pattern for robust state management.

---

## ✨ Features

- 📡 Fetch product list from Fake Store API
- 🖼️ Display product images, names, and prices in a scrollable list
- 🔍 Tap a product to view detailed info (name, image, description, price)
- 📶 Offline support using local SQLite database
- 🧠 State management with BLoC (flutter_bloc)
- 💅 Clean Material Design UI with smooth Hero transitions

---

## 📦 Tech Stack

| Layer         | Tool/Package                          |
|---------------|---------------------------------------|
| UI            | Flutter, Material Design              |
| State Mgmt    | flutter_bloc                          |
| Network       | http                                  |
| Local Storage | sqflite, path_provider                |
| API Source    | [Fake Store API](https://fakestoreapi.com/) |

---

## 🚀 Getting Started

### 🔧 Prerequisites

- Flutter SDK (3.x recommended)
- Android Studio or VS Code
- Connected device or emulator

### 🛠 Installation

```bash
git clone https://github.com/your-username/ecart_flutter.git
cd ecart_flutter
flutter pub get
flutter run