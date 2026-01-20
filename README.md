# Flutter Auth Demo

A Flutter app demonstrating **role-based authentication** using **Firebase** and **GetX**.

---

## Features

- Email + Password login (Firebase Auth)  
- Role-based dashboards:  
  - **Admin:** mocked user list, role change (UI-only)  
  - **User:** read-only quotes list  
- Token-based session handling with **flutter_secure_storage**  
- Automatic redirect on app restart  
- Logout clears session and tokens  

---

## Architecture

- **UI (`screens/`)** – renders layout  
- **Controllers (`controllers/`)** – state & logic (GetX)  
- **Repository (`repo/`)** – Firebase Auth & Firestore logic  
- **Services (`services/`)** – secure token storage  

**Clean separation of concerns, reactive UI, scalable structure.**

---

## State Management

- **GetX** for reactive variables and navigation  
- Avoids `setState()`, keeps UI and logic separate  

---

## Auth & Token Handling

- Login via **Firebase Email/Password** only  
- Role & name fetched from Firestore  
- Firebase ID token saved securely  
- Splash screen restores session automatically  
- Logout clears token & controller state  

---

## Assumptions

- Role changes and user list are **mocked** (UI-only)  
- Firestore rules allow authenticated reads  
- App is a **demo/evaluation**, not a production-ready RBAC system
