# _*_ coding:utf-8 _*_
from django.urls import resolve
from django.shortcuts import render,redirect

def perm_check(*args, **kwargs):

    request = args[0]
    print("user", request.session.__dict__)
    # 反向解析request中url
    url_resovle_obj = resolve(request.path_info)
    current_url_namespace = url_resovle_obj.url_name
    # 获取用户信息

    return True

# 装饰器
def check_permission(func):
    def wrapper(*args, **kwargs):
        print("--start check perms",args[0])
        if not perm_check(*args, **kwargs):
            return render(args[0],'crm/403.html')
        return func(*args, **kwargs)
    return wrapper