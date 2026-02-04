# HR App – Employee Attendance & Timesheet Management

## 📱 Project Overview

**HR App** is a Flutter-based mobile application designed to manage employee attendance, time tracking, and basic human resources operations. The application follows clean architecture principles and uses the Provider package for state management, ensuring scalability, maintainability, and a clear separation of concerns.

This project is developed as an academic submission and demonstrates best practices in Flutter application architecture, REST API integration, state management, localization, and theming.

---

## 🎯 Main Features

- User authentication (Login / Logout)
- Employee attendance management (Check-in / Check-out)
- Daily and monthly timesheets
- Employee profile management
- Dashboard with attendance statistics
- Multi-language support (English / Arabic)
- Light and Dark theme support
- User settings (language, theme, account control)

---

## 🧱 Architecture Overview

The application follows a layered architecture inspired by Clean Architecture:

Presentation Layer → UI & State Management
Data Layer → Repositories & APIs
Core Layer → Shared utilities & configurations
Config Layer → App-level configurations


Each layer has a single responsibility, improving readability, testability, and long-term maintainability.

---

## 📂 Project Structure

The project follows a layered architecture to ensure scalability, maintainability, and a clear separation of concerns.

```text
lib/
├── config/                 # Static configurations (menus, themes, etc.)
│   └── menu_config.dart
│
├── core/                   # Low-level utilities and infrastructure
│   ├── network/            # API configurations, endpoints, and error handling
│   │   ├── api_config.dart
│   │   ├── api_endpoints.dart
│   │   └── api_exception.dart
│   └── storage/            # Local storage helpers (Shared Preferences)
│       └── shared_preferences_helper.dart
│
├── data/                   # Data layer (Remote and Local data sources)
│   ├── api/                # Direct API service calls
│   │   ├── auth_api.dart
│   │   ├── attendance_api.dart
│   │   ├── employee_api.dart
│   │   └── timesheet_api.dart
│   ├── models/             # Data models (JSON parsing and serialization)
│   │   ├── auth_model.dart
│   │   ├── attendance_model.dart
│   │   ├── employee_model.dart
│   │   ├── daily_timesheet_model.dart
│   │   └── menu_item_model.dart
│   └── repositories/       # Abstraction layer between API and Business Logic
│       ├── auth_repository.dart
│       ├── attendance_repository.dart
│       ├── employee_repository.dart
│       └── timesheet_repository.dart
│
├── presentation/           # UI Layer
│   ├── pages/              # Full-screen views
│   │   ├── login_page.dart
│   │   ├── main_home_page.dart
│   │   ├── attendance_action_page.dart
│   │   └── ...
│   ├── tabs/               # Sub-views used within a BottomNavigationBar
│   │   ├── home_tab.dart
│   │   ├── menu_tab.dart
│   │   └── ...
│   ├── widgets/            # Reusable UI components
│   │   ├── chart_card.dart
│   │   ├── language_dropdown.dart
│   │   └── ...
│   ├── providers/          # State management (Logic and State)
│   │   ├── auth_provider.dart
│   │   ├── theme_provider.dart
│   │   └── ...
│   ├── routes/             # Navigation and Route management
│   │   ├── app_routes.dart
│   │   └── route_names.dart
│   └── theme/              # Global styling and themes
│       └── app_theme.dart
│
├── l10n/                   # Internationalization and Localization files
│   ├── app_en.arb
│   ├── app_ar.arb
│   └── ...
│
├── constants.dart          # Global app constants (colors, strings, spacing)
└── main.dart               # App entry point

---
```
## 🧩 Architecture Breakdown

### 🔹 Config Layer
Contains static configuration such as menu definitions and application constants that remain consistent across the app lifecycle.

### 🔹 Core Layer
The foundation of the app, handling shared services and infrastructure:
* **Network:** API base configuration, endpoint definitions, and global error handling.
* **Storage:** `SharedPreferences` helpers for local data persistence.

### 🔹 Data Layer
Responsible for data handling and the "Single Source of Truth":
* **API:** Classes that communicate directly with the backend.
* **Models:** Data structures that map JSON responses to Dart objects.
* **Repositories:** Acts as a bridge between the API and the Presentation layer, allowing for easy replacement of data sources without affecting the UI.

### 🔹 Presentation Layer
Handles everything the user sees and interacts with:
* **Pages & Tabs:** The main screens and sub-views.
* **Widgets:** Atomic, reusable UI components.
* **Providers:** State management logic (using the Provider package).
* **Routes:** Centralized navigation and path management.
* **Theme:** Global styling and branding definitions.

---

## 🔄 State Management & Flow

The application utilizes **Provider** for reactive state management. Each feature follows a strict unidirectional data flow:



1.  **UI (Widgets/Pages)** triggers an action in the **Provider**.
2.  **Provider** requests data from the **Repository**.
3.  **Repository** fetches data via **API** or **Local Storage**.
4.  **Provider** updates the state and notifies the **UI** to rebuild.

---

## 🌍 Localization & Theme

* **Multi-language Support:** Supports **English** and **Arabic** via `.arb` files. 
* **Persistence:** Both Language and Theme (Light/Dark mode) preferences are stored locally using `SharedPreferences`, ensuring settings are remembered after the app restarts.
* **Centralized Styling:** All colors, fonts, and component styles are managed within `app_theme.dart` for a consistent Look & Feel.

---

## 🚀 Technologies Used

| Category | Technology |
| :--- | :--- |
| **Framework** | Flutter |
| **Language** | Dart |
| **State Management** | Provider |
| **Network** | REST APIs (http/dio) |
| **Storage** | Shared Preferences |
| **Design** | Material Design |
| **L10n** | Flutter Localization (ARB) |

---

## 👤 Author

**Mhamad Taleb** *Lead Developer / Student*

---

## 🎓 Academic Submission

**Project Name:** HR App – Flutter Project  
**Description:** A comprehensive Human Resources management application built with Flutter, focusing on clean architecture, state management, and multi-language support.  
**Purpose:** This project was developed as part of an academic curriculum to demonstrate proficiency in:
* Layered Software Architecture
* REST API Integration
* Reactive State Management (Provider)
* User Experience (UX) Design for Enterprise Tools

---

### 📜 Final Notes
This repository is intended for academic evaluation. All sensitive API keys and base URLs have been abstracted into configuration files. 



