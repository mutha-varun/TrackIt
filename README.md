<div align="center">

# TrackIt 💰

**A cross-platform budget tracking app built with Flutter & Firebase**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore%20%7C%20Auth-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)

</div>

---

## 📖 About

TrackIt is a cross-platform personal finance app that lets users log income and expenses, monitor their real-time balance, and filter transactions by category — all synced live via Firebase Firestore.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔐 **Authentication** | Sign in with Email/Password or Google |
| 📊 **Dashboard** | Total balance, last deposit, and recent transactions at a glance |
| ➕ **Add Funds** | Log deposits with amount and date |
| 💸 **Add Expenses** | Log expenses with a purpose/description and auto date tracking |
| 🏷️ **Category Filtering** | Filter by All, Credit, Food, Transport, Grocery, and more |
| 🎨 **Color-coded Amounts** | Green for deposits, red for expenses |
| ☁️ **Real-time Sync** | All data synced instantly via Firebase Firestore |

---

## 📸 Screenshots

<div align="center">

| Sign In | Register | Dashboard |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/28d94c76-16a7-4b7c-84f7-905d032e005f" height="300"/> | <img src="https://github.com/user-attachments/assets/bc770ff0-f885-4279-8c2e-1ce0f43dd3e5" height="300"/> | <img src="https://github.com/user-attachments/assets/8738aa60-353b-4729-8efd-a7b8068e79f7" height="300"/> |

| Add Funds | Add Expense | Transaction List |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/9bd3cc56-319f-4d8f-8899-cec2d9c3c571" height="300"/> | <img src="https://github.com/user-attachments/assets/e391c83c-916d-4494-a2b9-a35b15381b8d" height="300"/> | <img src="https://github.com/user-attachments/assets/a826f8dc-1f47-4527-8a71-e7a8502000c6" height="300"/> |

| Filtered Category | Filtered Date |
|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/e1974d34-5037-487a-b9b1-f333bb8762ed" height="300"/> | <img src="https://github.com/user-attachments/assets/1c900558-e1dc-4c32-b937-e9c28575f084" height="300"/> |

</div>

---

## 🛠 Tech Stack

- **Framework:** Flutter (Dart)
- **Authentication:** Firebase Authentication (Email/Password, Google)
- **Database:** Cloud Firestore

---

## 📁 Project Structure

```
trackit/
└── lib/
    ├── main.dart               # App entry point; auth-based routing
    ├── screens/
    ├── categorizer.dart
    └── ...
```

---

## 🗃 Firestore Data Structure

```
transactions/                          ← collection
  {uid}/
    Total: 3983
    Created_at: Timestamp
    Last_Deposit: 500
    Last Dep Date: Timestamp
    transaction/               ← sub-collection
      {transactionId}/
        type: "Credit" | "Debit"
        amount: 500
        category: "Food"
        title: "Lunch"
        date: Timestamp
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed
- A Firebase project set up on the [Firebase Console](https://console.firebase.google.com/)

### Installation

**1. Clone the repository**
```sh
git clone https://github.com/mutha-varun/TrackIt.git
cd TrackIt/trackit
```

**2. Install dependencies**
```sh
flutter pub get
```

**3. Set up Firebase**

- Create a new project on the [Firebase Console](https://console.firebase.google.com/)
- Add Android, iOS, and Web apps to your project
- Enable **Authentication** methods: Email/Password and Google
- Enable **Cloud Firestore** and configure your database rules
- Download and place the config files:

  | Platform | File | Location |
  |---|---|---|
  | Android | `google-services.json` | `android/app/` |
  | iOS | `GoogleService-Info.plist` | `ios/Runner/` |
  | macOS | `GoogleService-Info.plist` | `macos/Runner/` |

**4. Run the app**
```sh
flutter run
```

---
