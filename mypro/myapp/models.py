from django.db import models
from datetime import date

# Create your models here.

class appointment_tab(models.Model):
    appointment_id = models.AutoField(primary_key = True)
    patient_id = models.IntegerField(max_length=10)
    doctor_id = models.IntegerField(max_length=10)
    service_id = models.IntegerField(max_length=10)
    date = models.CharField(max_length=100)
    time = models.CharField(max_length=100)
    approve = models.IntegerField(default=1)

    class Meta:
        db_table = 'appointment_tab'

class contact(models.Model):
    name = models.CharField(max_length=100)
    subject = models.CharField(max_length=100)
    message = models.CharField(max_length=100)
    email = models.EmailField(max_length=100)
    class Meta:
        db_table = 'contact'

class doctor_availability(models.Model):
    doctor_id = models.IntegerField(max_length=10)
    date = models.IntegerField
    start_time = models.TimeField
    end_time = models.TimeField
    notes = models.CharField(max_length=200)
    class Meta:
        db_table = 'doctor_availability'

class doctor_change_time(models.Model):
    change_id = models.AutoField(primary_key=True)
    doctor_id = models.IntegerField(max_length=10)
    date = models.CharField(max_length=100)
    start_time = models.CharField(max_length=100)
    end_time = models.CharField(max_length=100)
    class Meta:
        db_table = 'doctor_change_time'

class doctor_tab(models.Model):
    doctor_id = models.AutoField(primary_key=True)
    doctor_name = models.CharField(max_length=100)
    area = models.CharField(max_length=100)
    address = models.CharField(max_length=100)
    clinic_name = models.CharField(max_length=100)
    speciality = models.CharField(max_length=100)
    contact_no = models.CharField(max_length=13)
    email_id = models.EmailField(max_length=100)
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=100)
    USERNAME_FIELD = 'username'
    PASSWORD_FIELD = 'password'

    class Meta:
        db_table = 'doctor_tab'

class patient_registration(models.Model):
    patient_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    email_id = models.EmailField(max_length=100)
    contact_no = models.CharField(max_length=13)
    username = models.CharField(max_length=100)
    password = models.CharField(max_length=100)
    USERNAME_FIELD = 'username'
    PASSWORD_FIELD = 'password'
    class Meta:
        db_table = 'patient_registration'

class service_tab(models.Model):
    service_id = models.AutoField(primary_key=True)
    service_type = models.CharField(max_length=100)
    class Meta:
        db_table = 'service_tab'

# Basic specialities for doctors
BASIC_SPECIALITIES = [
    'General Dentistry',
    'Orthodontics (Braces & Alignment)',
    'Pediatric Dentistry (Children)',
    'Periodontics (Gum Specialist)',
    'Endodontics (Root Canal Specialist)',
    'Prosthodontics (Crowns, Bridges, Dentures)',
    'Oral & Maxillofacial Surgery',
    'Cosmetic Dentistry (Veneers, Whitening)',
    'Oral Radiology',
    'Public Health Dentistry',
    'Implantology',
    'Oral Pathology',
]


