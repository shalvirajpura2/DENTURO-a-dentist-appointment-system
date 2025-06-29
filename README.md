# DENTURO: Dentist Appointment System

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

## Render Deployment Instructions

### 1. Environment Variables
Create a `.env` file in the root of your project with the following variables:

```
DJANGO_SECRET_KEY=your-secret-key
DJANGO_DEBUG=False
DJANGO_ALLOWED_HOSTS=your-app.onrender.com
MYSQL_DATABASE=dentcare_db
MYSQL_USER=your-db-user
MYSQL_PASSWORD=your-db-password
MYSQL_HOST=your-db-host
MYSQL_PORT=3306
EMAIL_HOST_USER=your-email@example.com
EMAIL_HOST_PASSWORD=your-email-password
```

### 2. Static Files
Render will collect static files into the `staticfiles/` directory. Make sure you run:

```
python manage.py collectstatic
```

### 3. Database
Set up a MySQL database on Render and update the environment variables above with the credentials.

### 4. Procfile
The `Procfile` is already set up for Gunicorn:
```
web: gunicorn mypro.mypro.wsgi
```

### 5. Deploy
- Push your code to a GitHub repository.
- Create a new Web Service on Render, connect your repo, and set the build/run commands as needed.
- Add the environment variables in the Render dashboard.
- Deploy!
