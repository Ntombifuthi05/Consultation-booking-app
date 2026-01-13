# 📅 Consultation Booking App (Flutter + Firebase)

## 📌 Application Overview
Consultation Booking App.
The application integrates **Firebase Authentication** and **Cloud Firestore** to provide secure login and real-time data storage. It supports full consultation management, student profiles, and a complete admin panel.

The app is built using **Flutter** and follows the **MVVM (Model–View–ViewModel)** architecture to ensure clean separation of concerns, scalability, and easy maintenance.

There are two main user roles:
- **Students** – manage their consultations and profiles
- **Admins** – manage and monitor all consultation bookings

All features are implemented according to the assignment requirements and design guidelines.

---

## 🛠️ Technologies Used

- Flutter (Dart)
- Firebase Authentication
- Cloud Firestore
- Provider (State Management)
- MVVM Architecture

---

## 👤 User Roles & Features

### 🎓 Student Features

#### ✅ Registration Screen
Students can register by providing:
- Student ID
- Full Name
- Email
- Phone Number
- Password & Confirm Password

All fields are validated before submission.  
On successful registration:
- User is created in **Firebase Authentication**
- Student profile is saved in **Firestore**

---

#### 🔐 Login Screen
Students log in using:
- Email
- Password

After successful login, users are redirected to the student home dashboard.  
There is also an option to:
- Create a new account
- Login as Admin (separate flow)

---

#### 🏠 Home Screen (Dashboard)
After login, students see:
- Personalized welcome message
- List of booked consultations grouped by date
- Each item shows:
  - Topic
  - Lecturer
  - Date & Time
  - Status indicators

A floating action button allows students to book new consultations.

---

#### 📝 New Consultation Screen
Students can book consultations by entering:
- Lecturer’s name
- Topic
- Description
- Future date
- Future time

Features:
- Date picker only allows future dates
- Time picker prevents past times
- Validation before submission

On submission, the booking is saved in Firestore.

---

#### 📄 Consultation View Screen
Displays:
- Topic
- Lecturer
- Date & Time
- Description

Students can cancel a consultation.  
A confirmation dialog prevents accidental deletions.

---

#### 👤 Student Profile Screen
Displays:
- Full Name
- Email
- Phone Number
- Student ID
- Profile picture

Students can:
- Switch between view and edit mode
- Update profile details
- Upload a new profile picture

All updates are saved to Firestore in real time.

---

## 🛡️ Admin Panel

### 🔐 Admin Login Screen
Admins log in using:
- Admin Email
- Password

Option available to:
- Register as a new admin

---

### 📝 Admin Registration Screen
Admins can register by providing:
- Email
- Password

On success:
- Admin account is created in Firebase Auth
- Firestore record is created with admin role flag
- Redirected to Admin Dashboard

---

### 📊 Admin Dashboard
Admins can view all consultation bookings in real time.

Each record displays:
- Student Name
- Student ID
- Topic
- Lecturer
- Date & Time

Admin capabilities:
- Search by Student ID
- Filter by custom date range
- Delete bookings with confirmation

All updates reflect instantly using Firestore real-time listeners.

---

## 🧱 MVVM Architecture

### 📦 Models
- Student
- Booking

Used to represent structured application data.

### ⚙️ ViewModels
Handle:
- Authentication
- Registration
- Booking creation
- Profile updates
- Admin operations

Contain all business logic and Firebase communication.

### 🎨 Views
Flutter UI screens using:
- Provider for state management
- ViewModels for logic
- Clean separation from business rules

---

## 🔥 Firebase Integration

### 🔐 Authentication
- Firebase Auth for student and admin login

### 🗂️ Firestore Collections
- `students`
- `bookings`
- `admins`

### 🔒 Security Rules
- Role-based access using admin flag
- Students only access their own data
- Admins can access all bookings

---

## ⚠️ Challenges and Resolutions

### ⏱️ Date & Time Validation
**Challenge:** Preventing bookings in the past  
**Solution:**  
- Date and time pickers restricted to future values  
- Additional validation before saving to Firestore

---

### 🔐 Role-Based Access Control
**Challenge:** Separating admin and student access  
**Solution:**  
- Firestore admin flag
- App routing checks
- Firebase security rules enforcement

---

### 🔄 Real-Time Synchronization
**Challenge:** Keeping dashboards updated automatically  
**Solution:**  
- Firestore snapshot listeners used for live updates  
- No manual refresh required

---

### 🧩 MVVM Implementation
**Challenge:** Maintaining clean architecture  
**Solution:**  
- Clear separation of Models, ViewModels, and Views  
- Business logic isolated from UI components

---

## ▶️ How to Run the Project

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/your-repo-name.git
