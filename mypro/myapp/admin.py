from django.contrib import admin

from .models import patient_registration, appointment_tab,contact,doctor_availability,doctor_tab,service_tab

# Register your models here.
admin.site.register(patient_registration)
admin.site.register(appointment_tab)
admin.site.register(contact)
admin.site.register(doctor_availability)
admin.site.register(doctor_tab)
admin.site.register(service_tab)
