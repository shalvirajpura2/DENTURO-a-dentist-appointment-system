from django.urls import path
from . import views

urlpatterns = [
    path('form',views.log_form,name='form'),
    path('about',views.about,name='about'),
    path('appointment',views.appointment,name='appointment'),
    path('price',views.price,name='price'),
    path('service',views.service,name='service'),
    path('team',views.team,name='team'),
    path('testimonial',views.testimonial,name='testimonial'),
    path('contactcall',views.contactcall,name='contactcall'),
    path('setsession',views.setsession,name="setsession"),
    path('getsession',views.getsession,name="getsession"),
    path('p_signup',views.p_signup,name='p_signup'),
    path('p_login',views.p_login,name='p_login'),
    path('d_signup',views.d_signup,name='d_signup'),
    path('d_login',views.d_login,name='d_login'),
    path('logout_d',views.logout_d,name='logout_d'),
    path('show_doc_name_by_service',views.show_doc_name_by_service,name='show_doc_name_by_service'),
    path('save_appointment',views.save_appointment,name='save_appointment'),
    path('show_my_app',views.show_my_app,name='show_my_app'),
    path('cancel_appointment',views.cancel_appointment,name='cancel_appointment'),
    path('reject_action',views.reject_action,name='reject_action'),
    path('pending_app2',views.pending_app2,name='pending_app2'),
    path('past_app',views.past_app,name='past_app'),
    path('booked_app',views.booked_app,name='booked_app'),
    path('show_doc_app',views.show_doc_app,name='show_doc_app'),
    path('doctor_home',views.doctor_home,name='doctor_home'),
    path('d_contact',views.d_contact,name='d_contact'),
    path('d_personal_info',views.d_personal_info,name='d_personal_info'),
    path('d_availability',views.d_availability,name='d_availability'),
    path('p_reject',views.p_reject,name='p_reject'),
    path('p_past',views.p_past,name='p_past'),
    path('p_booked',views.p_booked,name='p_booked'),
    path('update_availability/<int:slot_id>/', views.update_availability, name='update_availability'),
    path('d_set_availability', views.d_set_availability, name='d_set_availability'),
    path('d_show_availability', views.d_show_availability, name='d_show_availability'),
    path('p_appointment', views.p_appointment, name='p_appointment'),
    path('check_appointment_time', views.check_appointment_time, name='check_appointment_time'),
    path('update_booked_availability/<int:slot_id>/', views.update_booked_availability, name='update_booked_availability'),
    path('update_d_profile', views.update_d_profile, name='update_d_profile'),
    path('patient_home', views.patient_home, name='patient_home'),
    path('p_contact', views.p_contact, name='p_contact'),
    path('update_profile', views.update_profile, name='update_profile'),



]


