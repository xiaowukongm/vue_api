# _*_ coding:utf-8 _*_
from django.urls import resolve
from django.shortcuts import render,redirect
from .models import User,role,premission_api,premission

def perm_check(*args, **kwargs):
    request = args[0]
    # 反向解析request中url
    url_resovle_obj = resolve(request.path_info)
    current_url_namespace = url_resovle_obj.url_name
    # 获取用户信息
    user_id = request.session.get("user_id",None)
    if user_id:
        # 获取用户角色
        # 获取角色权限
        # 通过current_url_namespace获取到权限id
        # 判断角色是否存在此权限
        role = User.objects.filter(id=user_id)[0].role
        role_ps_ids = role.ps_ids.split(",")
        permission_action = premission_api.objects.filter(ps_api_action=current_url_namespace)
        permission_id = permission_action[0].ps_id.id
        if permission_id in role_ps_ids:
            return True
        else:
            return False
    else:
        return False
    return False

# 装饰器
def check_permission(func):
    def wrapper(*args, **kwargs):
        if not perm_check(*args, **kwargs):
            return render(args[0],'crm/403.html')
        return func(*args, **kwargs)
    return wrapper