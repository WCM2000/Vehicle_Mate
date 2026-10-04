# Lanka Vehicle & Fuel Tracker (Vehicle Mate) 🚗⛽

A robust, **100% offline-first** mobile utility application engineered specifically for Sri Lankan vehicle owners. Built with Flutter, it automates vehicle compliance management, fuel quota tracking, and preventive maintenance scheduling without requiring remote server infrastructure.

---

## 🌟 Key Features

* **100% Offline-First Architecture:** Operates entirely locally using Drift (SQLite) with reactive streams. Zero server hosting costs and complete user data privacy.
* **National Fuel Pass QR Wallet:** Instant offline access to your Fuel QR code with automatic screen brightness boosting to 100% for rapid optical scanning at fueling stations.
* **Automated Fuel SMS Ingestion:** Built-in Regex parser extracts pumped liters, cost (LKR), and remaining balance from Ceypetco / National Fuel Pass SMS alerts to update records seamlessly[cite: 3].
* **Compliance & Expiry Alert Matrix:** Scheduled background notifications for Revenue License, Vehicle Insurance, and Emission Test certificates at **T-30** (Dashboard Banner), **T-14**, **T-7**, and **T-1** (High-priority alert + app icon badge)[cite: 3].
* **Dual-Trigger Service Engine:** Evaluates maintenance requirements using both elapsed mileage and calendar duration ($\text{km limit} \lor \text{date limit}$) to forecast the exact service deadline based on average daily usage[cite: 3].
* **Interactive Financial Analytics (`fl_chart`):** Visual breakdown of running costs across categories (Fuel, Maintenance, Compliance) via Monthly Bar Charts, Weekly Quota Depletion Lines, and Spending Proportion Donut Charts[cite: 3].
* **Zero-Cost Private Cloud Backup:** Optional synchronization to the user's hidden Google Drive `appDataFolder` using OAuth 2.0 without exposing personal records to public storage[cite: 3].

---

## 🛠️ Architecture & Tech Stack

The system follows a strict decoupled four-tier layered architecture[cite: 3]:

| Layer | Technology / Package | Responsibility |
| :--- | :--- | :--- |
| **Presentation** | Flutter / Material 3 | Dashboard, Fuel QR Wallet, Analytics views[cite: 3] |
| **State Management** | `flutter_riverpod` | StateNotifier controllers and business logic engines[cite: 3] |
| **Visualizations** | `fl_chart` | Low-latency vector charts and financial reports[cite: 3] |
| **Alerts & Scheduling** | `flutter_local_notifications` | Native system notifications and alarms (Asia/Colombo)[cite: 3] |
| **Local Persistence** | `drift` + `sqlite3_flutter_libs` | Reactive relational database (SQLite)[cite: 3] |
| **Cloud Backup** | `googleapis` & `google_sign_in` | Private Google Drive AppData folder backup[cite: 3] |

---

## 📊 Relational Database Design

The local SQLite database maintains four primary entities centered around the vehicle[cite: 3]:

```text
vehicles (Parent)
 ├── compliance_logs  (License, Insurance, Emission tests)
 ├── service_logs     (Maintenance logs, mileage, costs)
 └── fuel_transactions (Refueling history, SMS receipts, balances)
```[cite: 3]

---

## 🚀 Getting Started

### Prerequisites
* Flutter SDK (3.47.x or newer)
* Android Studio / Android SDK (API 34+)
* Linux / macOS / Windows development machine

### Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/](https://github.com/)<your-username>/vehicle_mate.git
   cd vehicle_mate