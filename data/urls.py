from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^login/', views.login,name="login"),
    url(r'^get_menus/', views.get_menus,name="get_menus"),
    url(r'^users/', views.users,name="users"),
    url(r'^update_user_state/', views.update_user_state,name="update_user_state"),

]