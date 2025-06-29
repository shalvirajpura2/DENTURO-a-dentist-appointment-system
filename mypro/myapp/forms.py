from django import forms
from django.contrib.auth.forms import UserCreationForm

from .models import patient_registration, doctor_change_time, BASIC_SPECIALITIES


class LoginForm(forms.Form):
   username = forms.CharField(max_length = 100)
   password = forms.CharField(widget = forms.PasswordInput())
   email = forms.EmailField(max_length=100)

class RegistrationForm(forms.Form):
   fistname = forms.CharField(max_length=50)

class NewPatientForm(UserCreationForm):
	name = forms.CharField(max_length=100)
	email_id = forms.CharField(max_length=100)
	contact_no = forms.CharField(max_length=100)
	username = forms.CharField(max_length=100)
	# password = forms.CharField(widget = forms.PasswordInput())
	class Meta:
		model = patient_registration
		fields = ("name", "email_id", "contact_no", "username")

	def save(self, commit=True):
		print("------ save method --------")
		user = super(NewPatientForm, self).save(commit=False)
		user.email = self.cleaned_data['email']
		print("============",user.email)
		if commit:
			user.save()
		return user

class DoctorRegistrationForm(forms.Form):
    doctor_name = forms.CharField(max_length=100)
    area = forms.CharField(max_length=100)
    address = forms.CharField(max_length=100)
    clinic_name = forms.CharField(max_length=100)
    speciality = forms.ChoiceField(choices=[(s, s) for s in BASIC_SPECIALITIES])
    contact_no = forms.CharField(max_length=13)
    email_id = forms.EmailField(max_length=100)
    username = forms.CharField(max_length=100)
    password = forms.CharField(widget=forms.PasswordInput())
