from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^login/', views.login,name="login"),
    url(r'^get_menus/', views.get_menus,name="get_menus"),

]