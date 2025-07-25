# Information Architecture & User Flow

## 1. Sitemap

The app's structure will be organized around a primary tab bar for easy navigation on mobile devices.

- **Home (Dashboard)**
  - Overview of recent activity
  - Quick access to reminders
  - Summary of analytics
- **Jobs**
  - List of all job applications
  - Search and filter options
  - Add new job
- **Analytics**
  - Detailed charts and metrics
  - Weekly/monthly reports
- **Reminders**
  - List of all reminders
  - Overdue tasks highlighted
- **Settings**
  - Profile and account management
  - Theme (light/dark mode)
  - Data export (CSV)
  - Logout

## 2. User Flows

### Onboarding

1.  **Welcome Screen:** Brief intro to the app.
2.  **Sign Up/Login:** Options for email/password and Google OAuth.
3.  **Onboarding Steps:**
    -   User selects their career goal (e.g., "Software Engineer," "Product Manager").
    -   User selects preferred roles/technologies (e.g., "React," "Node.js," "UX Design").
4.  **Completion:** User is directed to the home dashboard.

### Adding a New Job

1.  **Tap "Add Job" Button:** From the "Jobs" screen.
2.  **Enter Job Details:**
    -   Company Name
    -   Position
    -   Location
    -   Salary
    -   Source URL
3.  **Select Stage:** Choose from "Saved," "Applied," "Interviewing," etc.
4.  **Upload Documents:** Option to attach resume and cover letter.
5.  **Save:** The new job is added to the list.

### Managing a Job

1.  **Select a Job:** From the "Jobs" list.
2.  **View Job Details:**
    -   All job information is displayed.
    -   Notes and activity log are visible.
3.  **Edit/Delete:** Options to modify or remove the job entry.
4.  **Add a Note:** Simple text input to add a new note.
5.  **Change Stage:** Update the job's stage, which is automatically logged.

### Setting a Reminder

1.  **Go to a Job's Details:**
2.  **Tap "Set Reminder":**
3.  **Choose Date and Time:**
4.  **Save Reminder:** The reminder is added and will trigger a notification.

## 3. Navigation

A **bottom tab bar** will be used for primary navigation, providing quick access to the main sections of the app. This is ideal for mobile-first design and a better user experience than a side drawer for core features.

-   **Home**
-   **Jobs**
-   **Analytics**
-   **Reminders**

A **side drawer** or a "More" tab can be used for secondary items like "Settings," "Help," and "Logout" to keep the main navigation clean and focused.
