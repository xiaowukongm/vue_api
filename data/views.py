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
    data = {
        "id":101,
        "authName":"商品管理",
        "path":"",
        "children":[
            {
                "id": 104,
                "authName": "商品列表",
                "path": "",
                "children":[],
            }
        ]
    }
    result = {"data":[data],"msg":"获取菜单成功！"}
    return HttpResponse(json.dumps(result))