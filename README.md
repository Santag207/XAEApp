# JaVexApp

**JaVexApp** is a comprehensive application developed as part of the Javex initiative. This project aims to efficiently manage members, meetings, tasks, agendas, and inventory monitoring. Additionally, it provides detailed user profiles by connecting to a database and utilizing QR code scanning technology.

## Author
Santiago Castro Zuluaga

## Features

- **Member Management:** Add, update, and remove member information, ensuring an up-to-date directory.
- **Meeting Scheduling:** Organize and schedule meetings, send notifications, and maintain records of minutes.
- **Task Management:** Assign tasks, set deadlines, and track progress to ensure timely completion.
- **Agenda Planning:** Create and share meeting agendas to keep discussions focused and productive.
- **Inventory Monitoring:** Track inventory levels, receive alerts for low stock, and manage resources effectively.
- **User Profiles:** Access detailed profiles for each member, including contact information and activity history.
- **QR Code Integration:** Utilize QR code scanning for quick member check-ins, inventory tracking, and accessing user profiles.

## Technologies Used

- **Programming Language:** Dart
- **Framework:** Flutter
- **Database:** Firebase or Postgres
- **QR Code Scanner:**  Qr_code_scanner and barcode_scan2

## Project Structure
```
JaVexApp/
├── android/             # Android-specific files
├── assets/              # Static resources such as images and fonts
├── ios/                 # iOS-specific files
├── lib/                 # Main source code of the application
│   ├── main.dart        # Entry point of the application
│   ├── models/          # Data models
│   ├── screens/         # UI screens
│   ├── services/        # Business logic and services
│   ├── utils/           # Utility functions and helpers
│   └── widgets/         # Reusable UI components
├── test/                # Unit and widget tests
├── .gitignore           # Specifies files and directories to be ignored by Git
├── pubspec.yaml         # Flutter project configuration file
└── README.md            # Main documentation of the project
```
### Usage
1. **Member Management:**

- Navigate to the "Members" section to view the member directory.

- Use the "Add Member" button to input new member details.

- Select a member to update their information or remove them from the directory.

2. **Meeting Scheduling:**

- Access the "Meetings" section to view upcoming and past meetings.

- Schedule a new meeting by specifying the date, time, and agenda.

- Send notifications to members about scheduled meetings.

3. **Task Management:**

- Go to the "Tasks" section to view assigned tasks.

- Assign new tasks to members, set deadlines, and monitor progress.

- Update task statuses as they are completed.

4. **Agenda Planning:**

- In the "Agenda" section, create detailed agendas for upcoming meetings.

- Share agendas with members to ensure preparedness.

5. **Inventory Monitoring:**

- Visit the "Inventory" section to view current stock levels.

- Add new inventory items, update quantities, and set low-stock alerts.

6. **User Profiles:**

- Access detailed profiles by selecting a member from the directory.

- View contact information, activity history, and assigned tasks.

7. **QR Code Integration:**

Use the built-in QR code scanner to:

- Quickly check in members to meetings.

- Access member profiles by scanning their QR codes.

- Track inventory items by scanning product QR codes.

## Installation

To clone and run this application, follow these steps:

1. **Clone the repository:**

   ```
   git clone https://github.com/Santag207/JaVexApp.git
   ```

2. **Navigate to the project directory:**

  ```
  cd JaVexApp
  ```

3. **Install dependencies:**
  
  ```
  flutter pub get
  ```

4. **Configure the database:**

Configure with the DB of your preference

5. **Run the application:**

A) On an Android device or emulator:
  ```
  flutter run
  ```

B) On an iOS device or simulator:

  ```
  flutter run -d ios
  ```
