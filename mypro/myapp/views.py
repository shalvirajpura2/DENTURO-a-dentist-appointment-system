import json
import os
from datetime import datetime, time
from pathlib import Path

from django.contrib.auth import logout
# import requests
from django.core import serializers
from django.http import request, HttpResponse, JsonResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.template.loader import render_to_string
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_GET

from .models import contact, doctor_availability, patient_registration, service_tab, appointment_tab, doctor_change_time
from .models import doctor_tab
from django.contrib import auth
from django.contrib.auth.views import auth_logout as original_logout
from django.contrib.sessions.backends.base import SessionBase
from django.conf import settings
from django.core.mail import send_mail

# Create your views here.
from .forms import NewPatientForm, LoginForm

mydict = {}


# guest side
def log_form(request):
    return render(request, "login_form.html")


def about(request):
    return render(request, 'about.html')


def appointment(request):
    obj = service_tab.objects.all()
    return render(request, 'appointment.html', {"data": obj})


def price(request):
    return render(request, 'price.html')


def service(request):
    return render(request, 'service.html')


def team(request):
    return render(request, 'team.html')


def testimonial(request):
    return render(request, 'testimonial.html')


def contactcall(request):
    if request.method == "GET":
        if request.GET.get('tname') and request.GET.get('temail') and request.GET.get('tmessage') and request.GET.get(
                'tsubject'):
            ContactModel = contact()
            ContactModel.name = request.GET.get("tname")
            print("-----------", ContactModel.name)
            ContactModel.subject = request.GET.get("tsubject")
            print("-----------", ContactModel.subject)
            ContactModel.message = request.GET.get("tmessage")
            print("-----------", ContactModel.message)
            ContactModel.email = request.GET.get("temail")
            print("-----------", ContactModel.email)

            ContactModel.save()
            return render(request, "login_form.html")
        else:
            print("------>  error in data ")
    else:
        print("problem in insertion")
    return render(request, "contact.html")


def setsession(request):
    request.session['username'] = 'bhumi'
    request.session['uemail'] = 'mailto:bhumi@gmail.com'
    return HttpResponse("session created")


def getsession(request):
    studentname = request.session['username']
    studentemail = request.session['uemail']
    return HttpResponse(studentname + " " + studentemail);


def p_signup(request):
    if request.method == "POST":
        # Extract values
        name = request.POST.get("name")
        email = request.POST.get("email")
        contact = request.POST.get("contact")
        username = request.POST.get("username")
        password = request.POST.get("password")

        # Validate phone number length
        if len(contact) != 10:
            return JsonResponse({'status': 'error', 'message': 'Phone number should be 10 digits long.'})

        # If both validations passed, proceed with saving the model
        dModel = patient_registration()
        dModel.name = name
        dModel.email_id = email
        dModel.contact_no = contact
        dModel.username = username
        dModel.password = password
        dModel.save()

        request.session['username'] = username
        return redirect('patient_home')

    elif request.method == "GET":
        all_usernames = list(patient_registration.objects.values_list('username', flat=True))

        return render(request, "patient_signup.html", {'all_usernames': all_usernames})


def p_login(request):
    context = {'flag': 0, 'message': ''}

    if request.method == "POST":
        uname = request.POST.get("username")
        password = request.POST.get("password")

        if uname and password:
            if patient_registration.objects.filter(username=uname).exists():
                print('valid username')
                obj = patient_registration.objects.get(username=uname)

                if obj.password == password:
                    name = obj.name
                    email = obj.email_id
                    id = obj.patient_id

                    context = {'flag': 1, 'message': ''}
                    print("login successful")

                    request.session['username'] = uname
                    request.session['name'] = name
                    request.session['email'] = email
                    request.session['pid'] = id

                    return redirect('patient_home')
                else:
                    context = {'flag': 0, 'message': 'wrong username or password'}
                    print("login unsuccessful")
            else:
                context = {'flag': 0, 'message': 'wrong username or password'}
                print('invalid username')
        else:
            print("------>  error in data ")
    else:
        print("GET request for login page")
    return render(request, "patient_login.html", context)


def d_signup(request):
    services = service_tab.objects.all()

    if request.method == "POST":
        # Extract values
        name = request.POST.get("name")
        area = request.POST.get("area")
        address = request.POST.get("address")
        c_name = request.POST.get("c_name")
        speciality = request.POST.getlist('speciality')
        contact = request.POST.get("contact")
        email = request.POST.get("email")
        username = request.POST.get("username")
        password = request.POST.get("password")

        # Validate phone number length
        if len(contact) != 10:
            return JsonResponse({'status': 'error', 'message': 'Phone number should be 10 digits long.'})

        # If both validations passed, proceed with saving the model
        dModel = doctor_tab()
        dModel.doctor_name = name
        dModel.area = area
        dModel.address = address
        dModel.clinic_name = c_name
        dModel.speciality = ','.join(speciality)
        dModel.contact_no = contact
        dModel.email_id = email
        dModel.username = username
        dModel.password = password
        dModel.save()

        request.session['username'] = username
        return redirect('doctor_home')

    elif request.method == "GET":
        all_usernames = list(doctor_tab.objects.values_list('username', flat=True))

        return render(request, "doctor_signup.html", {'services': services, 'all_usernames': all_usernames})


def d_login(request):
    context = {'flag': 0, 'message': ''}
    if request.method == "POST":
        uname = request.POST.get("username")
        password = request.POST.get("password")
        if uname and password:
            if doctor_tab.objects.filter(username=uname).exists():
                obj = doctor_tab.objects.get(username=uname)

                if obj.password == password:
                    print("login successful")
                    request.session['username'] = uname

                    d_uname = request.session['username']
                    uname_val = doctor_tab.objects.values('username')
                    for item in uname_val:
                        value = item['username']
                        if d_uname == value:
                            obj = doctor_tab.objects.get(username=value)
                            doc_id = obj.doctor_id
                            from datetime import date

                            today = date.today()
                            appointments = appointment_tab.objects.filter(doctor_id=doc_id, date=today,
                                                                          approve=1).count()
                            context = {'flag': 1, 'message': '', 'appointments': appointments}

                    return redirect('doctor_home')
                else:
                    context = {'flag': 0, 'message': 'wrong username or password'}
                    print("login unsuccessful")
            else:
                context = {'flag': 0, 'message': 'wrong username or password'}
                print('invalid username')
        else:
            print("------>  error in data ")
    else:
        print("GET request for login page")
    return render(request, "doctor_login.html", context)


def logout_d(request):
    logout(request)
    return redirect('form')


def show_doc_name_by_service(request):
    if request.method == "GET":
        dname = []
        did = []
        if request.GET.get('serid'):
            sid = request.GET.get('serid')
            obj = doctor_tab.objects.all()
            doc = service_tab.objects.all()

            for val in obj:
                if sid in val.speciality:
                    did.append(val.doctor_id)
                    dname.append(val.doctor_name)
                    request.session['doctor_name'] = val.doctor_name
                    print("---->>>>", val.doctor_name)

            cnt = len(dname)
            cntlist = range(1, cnt + 1)
            doc_dict = dict(zip(did, dname))

    return JsonResponse({"instance": doc_dict}, status=200)


def patient_home(request):
    p_uname = request.session['username']
    print("USERNAME-=-=-=", p_uname)
    obj = patient_registration.objects.get(username=p_uname)
    pid = obj.patient_id

    if request.method == "GET":
        current_date = datetime.now().date()
        appointments = appointment_tab.objects.filter(patient_id=pid, date=current_date, approve=1)

        total_appointments_count = appointment_tab.objects.filter(patient_id=pid).count()
        up_cnt = appointment_tab.objects.filter(patient_id=pid, date__gt=current_date, approve=1).count()
        p_cnt = patient_registration.objects.count()
        t_cnt = appointment_tab.objects.filter(patient_id=pid, date=current_date, approve=1).count()

        data = []
        for d in appointments:
            try:
                doctor_name = doctor_tab.objects.get(doctor_id=d.doctor_id).doctor_name
                data.append({'appointment': d, 'doctor_name': doctor_name})
            except doctor_tab.DoesNotExist:
                pass

        return render(request, 'patient_home.html',
                      {'data': data, 'total_appointments_count': total_appointments_count, 'up_cnt': up_cnt,
                       'p_cnt': p_cnt, 't_cnt': t_cnt, 'obj': obj})
    else:
        return render(request, "form")


def update_profile(request):
    if request.method == "POST":
        email = request.POST.get('email_id')
        contact = request.POST.get('contact_no')
        password = request.POST.get('password')

        try:
            user = patient_registration.objects.get(username=request.session['username'])
            user.email_id = email
            user.contact_no = contact
            user.password = password
            user.save()

            return JsonResponse({'success': True})
        except patient_registration.DoesNotExist:
            return JsonResponse({'success': False, 'message': 'User not found'})
    else:
        return JsonResponse({'success': False, 'message': 'Invalid request method'})


def save_appointment(request):
    if request.method == "GET":
        if request.GET.get('service_id') and request.GET.get('doctor_id') and request.GET.get(
                'date') and request.GET.get('start_time'):
            pid = request.session['pid']
            did = request.GET.get('doctor_id')
            sid = request.GET.get('service_id')
            date = request.GET.get('date')
            time = request.GET.get('start_time')
            name = request.session['name']
            email = request.session['email']

            print("----------", pid)
            aobj = appointment_tab()
            aobj.patient_id = pid
            obj = doctor_tab.objects.get(doctor_id=did)
            doctor_name = obj.doctor_name
            obj1 = service_tab.objects.get(service_id=sid)
            speciality = obj1.service_type
            aobj.service_id = request.GET.get("service_id")
            from datetime import datetime
            aobj.doctor_id = did
            aobj.date = datetime.strptime(request.GET.get('date'), '%Y-%m-%d').strftime('%Y-%m-%d')
            print("------", aobj.date)
            aobj.time = request.GET.get("start_time")
            print("------", aobj.time)
            aobj.save()
            print("----->>>>... appointment booked successfullyy.............")
            subject = 'Appointment booked with dentcare'
            message = f'Hello {name},\n\nYour appointment with {doctor_name} for {speciality} is confirmed:\n\nDate: {date}\nTime: {time}\n\nSee you soon!\n\nBest regards,\nDenturo'
            email_from = settings.EMAIL_HOST_USER
            recipient_list = [email, ]
            print("ssssss", subject)
            print("message", message)
            send_mail(subject, message, email_from, recipient_list)
            return JsonResponse({"message": "Appointment booked successfully!"})

        else:
            return render(request, "p_appointment.html")


def d_set_availability(request):
    if request.method == "POST":
        date_str = request.POST.get('date')
        start_time_str = request.POST.get('start_time')
        end_time_str = request.POST.get('end_time')

        date_obj = datetime.strptime(date_str, '%Y-%m-%d').strftime('%Y-%m-%d')
        start_time_obj = start_time_str
        end_time_obj = end_time_str

        dobj = doctor_change_time()
        dobj.date = date_obj
        dobj.start_time = start_time_obj
        dobj.end_time = end_time_obj

        d_uname = request.session['username']
        obj = doctor_tab.objects.get(username=d_uname)
        dobj.doctor_id = obj.doctor_id

        dobj.save()
        return JsonResponse({"result": "success"})

    return render(request, "d_set_availability.html")


def d_show_availability(request):
    d_uname = request.session['username']
    obj = doctor_tab.objects.get(username=d_uname)
    doctor_id = obj.doctor_id
    print("==== doctor id ", doctor_id)
    current_date = datetime.now().date()
    doctor_availability = doctor_change_time.objects.filter(doctor_id=doctor_id, date__gt=current_date)
    return render(request, 'd_show_availability.html', {'availability': doctor_availability})


@csrf_exempt
def update_availability(request, slot_id):
    if request.method == 'POST':
        # Get the updated data from the request
        slot_id = request.POST.get('slot_id')
        date = request.POST.get('date')
        start_time = request.POST.get('start_time')
        end_time = request.POST.get('end_time')

        # Update the slot in the database
        slot = doctor_change_time.objects.get(change_id=slot_id)
        slot.date = date
        slot.start_time = start_time
        slot.end_time = end_time
        slot.save()

        # Send back a response
        return JsonResponse({'status': 'success'})

        # If not a POST request, send an error response
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request'})


def cancel_appointment(request):
    d_uname = request.session['username']
    uname_val = doctor_tab.objects.values('username')

    date_list = []
    name_list = []
    time_list = []
    service_list = []
    aprrove_list = []
    newlist = []
    a_idlist = []
    dlist = dict()

    for item in uname_val:
        value = item['username']
        if d_uname == value:
            new_obj = value
            # get doctor id from doctor username
            obj = doctor_tab.objects.get(username=value)
            doc_id = obj.doctor_id
            current_date = datetime.now().date()

            doctor_appointments = appointment_tab.objects.filter(doctor_id=doc_id, date__gt=current_date)
            for d in doctor_appointments:
                date_list.append(d.date)
                time_list.append(d.time)
                a_idlist.append(d.appointment_id)
                aprrove_list.append(d.approve)
                p_id = d.patient_id
                s_id = d.service_id

                print("p_id : ", p_id)
                pat_name = patient_registration.objects.get(patient_id=p_id)
                print(pat_name)
                name_list.append(pat_name.name)

                ser_id = service_tab.objects.get(service_id=s_id)
                service_list.append(ser_id.service_type)

            # print("---> date list",date_list)
            # print("---> name list",name_list)
            # print("---> time list",time_list)
            # print("---> service list",service_list)
            # print("---> approve list",aprrove_list)
            # print("------> ",a_idlist)

            dlist['date'] = date_list
            dlist['name'] = name_list
            dlist['time'] = time_list
            dlist['service'] = service_list
            dlist['a_id'] = a_idlist
            dlist['approve'] = aprrove_list

            print("-----+>>>", dlist)

            for i in range(len(date_list)):
                str = dlist['date'][i], dlist['name'][i], dlist['time'][i], dlist['service'][i], dlist['a_id'][i], \
                      dlist['approve'][i]
                newlist.append(str)

    print("new list ----->", newlist)

    return render(request, 'cancel_appointment.html', {'data': newlist})


def reject_action(request):
    if request.method == 'GET':
        a_id = request.GET.get('a_id')
        obj = appointment_tab.objects.get(appointment_id=a_id)
        obj.approve = 0
        p_id = obj.patient_id
        date = obj.date
        time = obj.time
        d_id = obj.doctor_id
        obj.save()
        pobj = patient_registration.objects.get(patient_id=p_id)
        dobj = doctor_tab.objects.get(doctor_id=d_id)
        email = pobj.email_id
        name = pobj.name
        doctor_name = dobj.doctor_name

        subject = 'Appointment Cancelled by Denturo'
        message = f'Hello {name},\n\nWe regret to inform you that your appointment scheduled for {date} at {time} has been cancelled by {doctor_name}. We apologize for any inconvenience. Please contact us to reschedule.\n\nBest regards,\nDenturo'
        email_from = settings.EMAIL_HOST_USER
        recipient_list = [email, ]

        send_mail(subject, message, email_from, recipient_list)

        return JsonResponse({'success': True})

    return JsonResponse({'success': False})


from django.shortcuts import render
from datetime import datetime


def pending_app2(request):
    d_uname = request.session['username']
    obj = doctor_tab.objects.get(username=d_uname)
    did = obj.doctor_id

    if request.method == "GET":
        current_date = datetime.now().date()
        appointments = appointment_tab.objects.filter(doctor_id=did, approve=0, date__gt=current_date)
        data = []
        for d in appointments:
            try:
                patient_name = patient_registration.objects.get(patient_id=d.patient_id).name
                data.append({'appointment': d, 'patient_name': patient_name})
            except patient_registration.DoesNotExist:
                # Handle the case where a patient doesn't exist here.
                pass
        return render(request, 'Pending_Appointment.html', {'data': data})
    else:
        return render(request, "form")


def show_doc_app(request):
    return render(request, "show_doc_app.html")


def booked_app(request):
    print("inside booked app")
    d_uname = request.session['username']
    obj = doctor_tab.objects.get(username=d_uname)
    did = obj.doctor_id

    if request.method == "GET":
        current_date = datetime.now().date()
        appointments = appointment_tab.objects.filter(doctor_id=did, approve=1, date__gt=current_date)
        data = []
        for d in appointments:
            try:
                patient_name = patient_registration.objects.get(patient_id=d.patient_id).name
                data.append({'appointment': d, 'patient_name': patient_name})
            except patient_registration.DoesNotExist:
                # Handle the case where a patient doesn't exist here.
                pass
        return render(request, 'Booked_Appointment.html', {'data': data})
    else:
        return render(request, "form")


def past_app(request):
    print("inside past app")
    d_uname = request.session['username']
    obj = doctor_tab.objects.get(username=d_uname)
    did = obj.doctor_id

    if request.method == "GET":
        current_date = datetime.now().date()
        appointments = appointment_tab.objects.filter(doctor_id=did, date__lt=current_date)
        data = []
        for d in appointments:
            try:
                patient_name = patient_registration.objects.get(patient_id=d.patient_id).name
                data.append({'appointment': d, 'patient_name': patient_name})
            except patient_registration.DoesNotExist:
                # Handle the case where a patient doesn't exist here.
                pass
        return render(request, 'Past_Appointment.html', {'data': data})
    else:
        return render(request, "form")


def doctor_home(request):
    p_uname = request.session['username']
    obj = doctor_tab.objects.get(username=p_uname)
    pid = obj.doctor_id

    if request.method == "GET":
        current_date = datetime.now().date()
        appointments = appointment_tab.objects.filter(doctor_id=pid, date=current_date, approve=1)

        total_appointments_count = appointment_tab.objects.filter(doctor_id=pid).count()
        up_cnt = appointment_tab.objects.filter(doctor_id=pid, date__gt=current_date, approve=1).count()
        p_cnt = patient_registration.objects.count()
        t_cnt = appointment_tab.objects.filter(doctor_id=pid, date=current_date, approve=1).count()

        data = []
        for d in appointments:
            try:
                doctor_name = patient_registration.objects.get(patient_id=d.patient_id).name
                data.append({'appointment': d, 'doctor_name': doctor_name})
            except patient_registration.DoesNotExist:
                # Handle the case where a patient doesn't exist here.
                pass

        return render(request, 'doctor_home.html',
                      {'data': data, 'total_appointments_count': total_appointments_count, 'up_cnt': up_cnt,
                       'p_cnt': p_cnt, 't_cnt': t_cnt, 'obj': obj})
    else:
        return render(request, "form")


def update_d_profile(request):
    if request.method == "POST":
        email = request.POST.get('email_id')
        contact = request.POST.get('contact_no')
        password = request.POST.get('password')

        try:
            user = doctor_tab.objects.get(username=request.session['username'])
            user.email_id = email
            user.contact_no = contact
            user.password = password
            user.save()

            return JsonResponse({'success': True})
        except doctor_tab.DoesNotExist:
            return JsonResponse({'success': False, 'message': 'User not found'})
    else:
        return JsonResponse({'success': False, 'message': 'Invalid request method'})


def d_contact(request):
    if request.method == "GET":
        if request.GET.get('tname') and request.GET.get('temail') and request.GET.get('tmessage') and request.GET.get(
                'tsubject'):
            ContactModel = contact()
            ContactModel.name = request.GET.get("tname")
            print("-----------", ContactModel.name)
            ContactModel.subject = request.GET.get("tsubject")
            print("-----------", ContactModel.subject)
            ContactModel.message = request.GET.get("tmessage")
            print("-----------", ContactModel.message)
            ContactModel.email = request.GET.get("temail")
            print("-----------", ContactModel.email)

            ContactModel.save()
            return render(request, "doctor_home.html")
        else:
            print("------>  error in data ")
    else:
        print("problem in insertion")
    return render(request, "d_contact.html")


def d_personal_info(request):
    d_uname = request.session['username']
    # obj =
    return render(request, "d_personal_info.html")


def d_availability(request):
    return render(request, "d_availability.html")


def show_my_app(request):
    return render(request, "myappointment.html")


def p_reject(request):
    p_uname = request.session['username']
    obj = patient_registration.objects.get(username=p_uname)
    pid = obj.patient_id

    if request.method == "GET":
        current_date = datetime.now().date()
        appointments = appointment_tab.objects.filter(patient_id=pid, approve=0, date__gt=current_date)
        data = []
        for d in appointments:
            try:
                doctor_name = doctor_tab.objects.get(doctor_id=d.doctor_id).doctor_name
                data.append({'appointment': d, 'doctor_name': doctor_name})
            except doctor_tab.DoesNotExist:
                # Handle the case where a patient doesn't exist here.
                pass
        return render(request, 'p_reject.html', {'data': data})
    else:
        return render(request, "form")


def p_booked(request):
    p_uname = request.session['username']
    obj = patient_registration.objects.get(username=p_uname)
    pid = obj.patient_id

    if request.method == "GET":
        current_date = datetime.now().date()
        appointments = appointment_tab.objects.filter(patient_id=pid, approve=1, date__gt=current_date)
        data = []
        for d in appointments:
            try:
                doctor_name = doctor_tab.objects.get(doctor_id=d.doctor_id).doctor_name
                data.append({'appointment': d, 'doctor_name': doctor_name})
            except doctor_tab.DoesNotExist:
                # Handle the case where a patient doesn't exist here.
                pass
        return render(request, 'p_booked.html', {'availability': data})
    else:
        return render(request, "form")


from django.http import JsonResponse, HttpResponseBadRequest
from django.views.decorators.csrf import csrf_protect
from django.utils import timezone


@csrf_exempt
def update_booked_availability(request, slot_id):
    if request.method == 'POST':
        # Get the updated data from the request
        slot_id = request.POST.get('slot_id')
        date = request.POST.get('date')
        time = request.POST.get('time')
        slot = appointment_tab.objects.get(appointment_id=slot_id)
        p_id = slot.patient_id
        d_id = slot.doctor_id
        o_date = slot.date
        o_time = slot.time
        print(p_id, d_id)
        pobj = patient_registration.objects.get(patient_id=p_id)
        patient_name = pobj.name
        email = pobj.email_id
        dobj = doctor_tab.objects.get(doctor_id=d_id)
        doctor_name = dobj.doctor_name

        # Update the slot in the database
        slot.date = date
        slot.time = time
        slot.save()  # Ensure appointment object changes are saved
        n_date = slot.date
        n_time = slot.time

        subject = 'Appointment Rescheduled by Denturo'
        message = f"Subject: Appointment Rescheduled by {patient_name}\n\nDear {doctor_name},\n\nWe'd like to inform you that {patient_name}, originally scheduled to see you on {o_date} at {o_time}, has rescheduled their appointment.\n\nNew Appointment Details:\n\nDate: {n_date}\nTime: {n_time}\nPlease update your records accordingly. If there are any conflicts or issues, kindly contact us as soon as possible.\n\nWe understand that changes can sometimes disrupt schedules, and we appreciate your flexibility and understanding.\n\nThank you for your continued dedication to our patients.\n\nWarm regards,\nDenturo"
        email_from = settings.EMAIL_HOST_USER
        recipient_list = [email, ]

        send_mail(subject, message, email_from, recipient_list)

        # Send back a response
        return JsonResponse({'status': 'success'})

        # If not a POST request, send an error response
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request'})


def p_past(request):
    p_uname = request.session['username']
    obj = patient_registration.objects.get(username=p_uname)
    pid = obj.patient_id

    if request.method == "GET":
        current_date = datetime.now().date()
        appointments = appointment_tab.objects.filter(patient_id=pid, date__lt=current_date)
        data = []
        for d in appointments:
            try:
                doctor_name = doctor_tab.objects.get(doctor_id=d.doctor_id).doctor_name
                data.append({'appointment': d, 'doctor_name': doctor_name})
            except doctor_tab.DoesNotExist:
                # Handle the case where a patient doesn't exist here.
                pass
        return render(request, 'p_past.html', {'data': data})
    else:
        return render(request, "form")


def p_appointment(request):
    obj = service_tab.objects.all()
    return render(request, "p_appointment.html", {'data': obj})


def p_contact(request):
    if request.method == "GET":
        if request.GET.get('tname') and request.GET.get('temail') and request.GET.get('tmessage') and request.GET.get(
                'tsubject'):
            ContactModel = contact()
            ContactModel.name = request.GET.get("tname")
            print("-----------", ContactModel.name)
            ContactModel.subject = request.GET.get("tsubject")
            print("-----------", ContactModel.subject)
            ContactModel.message = request.GET.get("tmessage")
            print("-----------", ContactModel.message)
            ContactModel.email = request.GET.get("temail")
            print("-----------", ContactModel.email)

            ContactModel.save()
            return render(request, "patient_home.html")
        else:
            print("------>  error in data ")
    else:
        print("problem in insertion")
    return render(request, "p_contact.html")


def check_appointment_time(request):
    doctor_id = request.GET.get('doctor_id', None)
    date = request.GET.get('date', None)
    start_time = request.GET.get('start_time', None)

    # Convert the date and time strings into Python datetime objects
    date_obj = datetime.strptime(date, "%Y-%m-%d").date()
    start_time_obj = datetime.strptime(start_time, "%H:%M").time()

    # Get the doctor's working hours for the specified date
    working_hours = doctor_change_time.objects.filter(doctor_id=doctor_id, date=date_obj)

    if working_hours.exists():
        # If there are specific working hours, check if the selected time is within those hours
        for hours in working_hours:
            if hours.start_time <= start_time_obj <= hours.end_time:
                return JsonResponse({'is_valid_time': True})

        return JsonResponse(
            {'is_valid_time': False, 'error_message': "The selected time is outside of the doctor's working hours."})
    else:
        # If there are no specific working hours, check if the selected time is between 8am and 8pm
        if time(8, 0) <= start_time_obj <= time(20, 0):
            return JsonResponse({'is_valid_time': True})
        else:
            return JsonResponse({'is_valid_time': False,
                                 'error_message': "The selected time is outside of the default working hours (8am to 8pm)."})


def debug_url(request):
    from django.http import HttpResponse
    return HttpResponse(f"You hit: {request.path}")
