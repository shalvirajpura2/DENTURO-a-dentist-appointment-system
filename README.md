# DENTURO-a-dentist-appointment-system

Denturo is a dentist appointment system built using Django. It allows dentists to create accounts and manage their profiles, while patients can book and manage their own appointments. Each user type has its own dedicated dashboard for managing their activities.

## Getting Started

To run this project locally, follow these steps:

### Download and Setup

1. **Download the ZIP File**:
    - Download the project ZIP file from the [GitHub repository](#).

2. **Extract the ZIP File**:
    - Extract the contents of the ZIP file to a location of your choice.

3. **Open in Your IDE**:
    - Open the extracted project folder in your preferred IDE or code editor.

4. **Navigate to the Project Directory**:
    ```bash
    cd mypro
    ```

5. **Navigate to the Application Directory**:
    ```bash
    cd myapp
    ```

6. **Apply Database Migrations**:
    ```bash
    python manage.py migrate
    ```

7. **Start the Django Development Server**:
    ```bash
    python manage.py runserver
    ```

The server will start, and you can access the website at `http://localhost:8000/myapp/form` to view the home page.

## Usage

- **Dentists** can create accounts and manage their profiles.
- **Patients** can book appointments with dentists and manage their own appointments.
- Both user types have their own dashboards for managing activities.
