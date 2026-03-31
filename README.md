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
  - Filter transactions by All, Credit, Food, Transport, Grocery, etc.
  - Color-coded amounts (green for deposits, red for expenses)

- **Real-time Sync:** All data synced instantly via Firebase Firestore

## Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Backend & Database:**
  - Firebase Authentication
  - Cloud Firestore

## Screenshots

<img src = "https://github.com/user-attachments/assets/28d94c76-16a7-4b7c-84f7-905d032e005f" height="300">
<img src = "https://github.com/user-attachments/assets/bc770ff0-f885-4279-8c2e-1ce0f43dd3e5" height="300">
<img src = "https://github.com/user-attachments/assets/99a492ac-3ace-413c-a94f-4e5eb43d7393" height="300">
<img src = "https://github.com/user-attachments/assets/eb54b723-45e9-4b95-903d-c7f9ec4eba91" height="300">
<img src = "https://github.com/user-attachments/assets/eaa936ad-9ab7-47e0-9018-e43eaa28f962" height="300">
<img src = "https://github.com/user-attachments/assets/6eb497f1-160f-4932-a5d1-f115c0a90613" height="300">
<img src = "https://github.com/user-attachments/assets/46a84d40-aac3-450d-b85e-9eef036b32e7" height="300">
<img src = "https://github.com/user-attachments/assets/c5331b36-b014-45b7-9010-f25c472ba310" height="300">

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
