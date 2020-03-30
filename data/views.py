from django.http import HttpResponse
from django.shortcuts import render
from django.views.decorators.http import require_GET,require_POST
import json
from .models import User


@require_POST
def login(request):
    username = request.POST.get("username")
    password = request.POST.get("password")
    result = {"status": "error", "msg": "请输入正确的用户名和密码！","login_status":""}
    obj = User.objects.filter(username=username,password=password)
    if obj:
        result = {"status": "success", "msg": "登录成功！","login_status":1}
    return HttpResponse(json.dumps(result))

@require_GET
def get_menus(request):
    # 菜单数据结构
    userMenu = {
        "id": 101,
        "authName": "用户管理",
        "path": "",
        "children": [
            {
                "id": 101-1,
                "authName": "用户列表",
                "path": "users",
                "children": [],
            }
        ]
    }

    permissionMenu =  {
        "id":102,
        "authName":"权限管理",
        "path":"",
        "children":[
            {
                "id": 102-1,
                "authName": "角色列表",
                "path": "role",
                "children":[],
            },
            {
                "id": 102 - 2,
                "authName": "权限列表",
                "path": "permission",
                "children": [],
            }

        ]
    }
    shopMenu = {
        "id": 103,
        "authName": "商品管理",
        "path": "",
        "children": [
            {
                "id": 103-1,
                "authName": "商品列表",
                "path": "shop",
                "children": [],
            }
        ]
    }
    orderMenu = {
        "id": 104,
        "authName": "订单管理",
        "path": "",
        "children": [
            {
                "id": 104-1,
                "authName": "订单列表",
                "path": "order",
                "children": [],
            }
        ]
    }
    dataMenu = {
        "id": 105,
        "authName": "数据统计",
        "path": "",
        "children": [
            {
                "id": 105-1,
                "authName": "数据图表",
                "path": "data",
                "children": [],
            }
        ]
    }
    data = [userMenu,permissionMenu,shopMenu,orderMenu,dataMenu]
    result = {"data":data,"msg":"获取菜单成功！"}
    return HttpResponse(json.dumps(result))