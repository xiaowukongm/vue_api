from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^login/', views.login,name="login"),
    url(r'^get_menus/', views.get_menus,name="get_menus"),
    url(r'^users/', views.users,name="users"),
    url(r'^update_user_state/', views.update_user_state,name="update_user_state"),
    url(r'^addUser/', views.addUser,name="addUser"),
    url(r'^get_user_by_id/', views.get_user_by_id,name="get_user_by_id"),
    url(r'^edit_user/', views.edit_user,name="edit_user"),
    url(r'^delete_user/', views.delete_user,name="delete_user"),
    url(r'^rights/', views.get_premission_list,name="rights"),
    url(r'^rights/', views.get_premission_tree,name="rights"),
    url(r'^roles/', views.roles,name="roles"),




    url(r'^copy_case/', views.copy_case,name="copy_case"),
    url(r'^check_copy_case_name/', views.check_copy_case_name,name="check_copy_case_name"),

]