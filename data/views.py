import os
import shutil

from django.http import HttpResponse
from django.shortcuts import render
from django.views.decorators.http import require_GET,require_POST
from django.core.paginator import Paginator,PageNotAnInteger,EmptyPage
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

@require_GET
def users(request):
    # 当前页码
    pagenum = request.GET.get("pagenum")
    # 每页显示数
    pagesize = request.GET.get("pagesize")
    user_list = User.objects.all().values("id","username","mobile","email","mg_state","role_name")
    user_list = list(user_list)
    paginator = Paginator(user_list, pagesize)
    try:
        users = paginator.page(pagenum)
    except PageNotAnInteger:
        users = paginator.page(1)
    except EmptyPage:
        users = paginator.page(paginator.num_pages)
    result = {
        "users":list(users),
        "total":len(user_list),
        "msg":"获取用户列表成功！"
    }
    return HttpResponse(json.dumps(result))

def update_user_state(request):
    user_id = request.GET.get("id")
    mg_state = True if request.GET.get("state") == "true" else False
    result = User.objects.filter(id=int(user_id)).update(mg_state=mg_state)
    return HttpResponse(result)

def copy_case(request):
    # 参数格式：[{name: "白居易", value: "1", caseName: "ss", casePath: "E:\python_project\user\", sameName: false}]
    params = json.loads(request.body)
    print(params)
    userList = params["userList"]
    oldCasePath = params["oldCasePath"]
    #
    # # 复制文件到用户目录下
    # # 首先判断有没有此用户的文件夹，再判断此用户文件夹下有没有此文件
    # # 当选多个人的时候，其中一个人重名，该怎么处理，前端提交时就做校验是否重名如果重名提示修改名称
    # # result： copyState存放每个人复制文件的状态
    result = {"result": "fail"}
    for param in userList:
        userName = param["name"]
        number = param["value"]
        caseName = param["caseName"]
        casePath = param["casePath"]
        fpath = casePath+number
        newCasePath = fpath+"\\"+caseName

        if not os.path.exists(fpath):
            os.makedirs(fpath)
        # 如果重名返回提示修改名称
        shutil.copyfile(oldCasePath,newCasePath)
        # 写入分享标志字段
        with open(newCasePath,"w") as f:
            f.write(json.dumps({"share":True}))
    return HttpResponse(json.dumps(result))

def check_copy_case_name(request):
    params = json.loads(request.body)
    # print(params)
    userListAndCasename = params["userListAndCasename"]
    copyState = []
    result = {"result": "success", "copyState": copyState}
    for param in userListAndCasename:
        userName = param["name"]
        value = param["value"]
        casePath = param["casePath"]
        caseName = param["caseName"]
        fpath = "E:\python_project\\user\\" + value
        newCasePath = fpath + "\\" + caseName
        # print(newCasePath)
        if os.path.exists(newCasePath):
            result["copyState"].append({"name": userName, "value": value,"caseName":caseName,"casePath":casePath, "sameName": True})
            result["result"] = "fail"
        else:
            result["copyState"].append({"name": userName, "value": value, "caseName":caseName,"casePath":casePath,"sameName": False})
    print(result)
    return HttpResponse(json.dumps(result))