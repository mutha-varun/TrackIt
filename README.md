# TrackIt 💰

A cross-platform budget tracking app built with Flutter and Firebase. 
It allows users to log expenses, track their balance, and categorize 
transactions in real time.

## Features

- **Multi-platform Authentication:**
  - Email and Password
  - Google Sign-In

- **Dashboard:**
  - Total balance overview
  - Last deposit details
  - Recent transactions list

- **Transaction Management:**
  - Add funds (deposits)
  - Add expenses with purpose/description
  - Automatic date tracking

- **Category Filtering:**
  - Filter transactions by All, Credit, Food, Transport
  - Color-coded amounts (green for deposits, red for expenses)

- **Real-time Sync:** All data synced instantly via Firebase Firestore

## Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Backend & Database:**
  - Firebase Authentication
  - Cloud Firestore

## Screenshots


## Getting Started

### Prerequisites
- Flutter SDK installed
- A configured Firebase project

### Installation

1. Clone the repository:
   git clone https://github.com/mutha-varun/TrackIt.git

2. Navigate to the project directory:
   cd TrackIt

3. Install dependencies:
   flutter pub get

4. Set up Firebase:
   - Create a new project on Firebase Console
   - Add Android, iOS, and Web apps
   - Place configuration files in their respective locations
   - Enable Email/Password and Google Sign-In in Authentication
   - Set up Cloud Firestore

5. Run the app:
   flutter run
