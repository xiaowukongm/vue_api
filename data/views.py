import os
import shutil
from django.http import HttpResponse
from django.shortcuts import render
from django.views.decorators.http import require_GET,require_POST
from django.core.paginator import Paginator,PageNotAnInteger,EmptyPage
import json
from .models import User,premission,premission_api
from .permissions import check_permission


@require_POST
def login(request):
    username = request.POST.get("username")
    password = request.POST.get("password")
    result = {"status": "error", "msg": "请输入正确的用户名和密码！","login_status":""}
    obj = User.objects.filter(username=username,password=password)
    if obj:
        result = {"status": "success", "msg": "登录成功！","login_status":1}
        # 设置session
        request.session["user_id"] = obj[0].id
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
    # 搜索查询
    query = request.GET.get("query")
    user_list = User.objects.all().values("id","username","mobile","email","mg_state","role_name")
    if query:
        user_list = User.objects.filter(username=query).values("id", "username", "mobile", "email", "mg_state", "role_name")
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

def addUser(request):
    result = {"result":"fail"}
    username = request.POST.get("username")
    password = request.POST.get("password")
    email = request.POST.get("email")
    mobile = request.POST.get("mobile")
    user = User(username=username, password=password, email=email, mobile=mobile)
    user.save()
    result["result"] = "success"
    return HttpResponse(json.dumps(result))


def get_user_by_id(request):
    result = {"result": "fail","user":None}
    user_id = request.GET.get("user_id")
    try:
        user = User.objects.filter(id=user_id).values("id", "username", "mobile", "email", "mg_state", "role_name")
        result["result"] = "success"
        result["user"] = user[0]
    except Exception as e:
        raise e
    return HttpResponse(json.dumps(result))


def edit_user(request):
    result = {"result": "fail"}
    user_id = request.POST.get("id")
    print(user_id)
    update_data = {
        "email":request.POST.get("email"),
        "mobile":request.POST.get("mobile")
    }
    try:
        User.objects.filter(id=user_id).update(**update_data)
        result["result"] = "success"
    except Exception as e:
        raise e
    return HttpResponse(json.dumps(result))


def delete_user(request):
    result = {"result": "fail"}
    user_id = request.GET.get("user_id")
    print(user_id)
    try:
        if user_id:
            User.objects.filter(id=user_id).delete()
            result["result"] = "success"
    except Exception as e:
        raise e
    return HttpResponse(json.dumps(result))

# 获取权限列表
def get_premission_list(request):
    premission_list = premission.objects.all()
    # 存放一级权限
    premission_dict = {}
    for i in premission_list:
        if i.ps_level == "0":
            premission_api_obj = premission_api.objects.filter(ps_id=i.id)
            premission_dict[i.id] = {
                "id":i.id,
                "authName":i.ps_name,
                "path":premission_api_obj[0].ps_api_path,
                "pid":i.ps_pid,
                "children":[]
            }
    tmpResult = {}
    # 二级权限
    for i in premission_list:
        if i.ps_level == "1":
            premission_api_obj = premission_api.objects.filter(ps_id=i.id)
            tmpResult[i.id] = {
                "id": i.id,
                "authName": i.ps_name,
                "path": premission_api_obj[0].ps_api_path,
                "pid": i.ps_pid,
                "children": []
            }
            premission_dict[i.ps_pid]["children"].append(tmpResult[i.id])

    # 3级权限
    for i in premission_list:
        if i.ps_level == "2":
            premission_api_obj = premission_api.objects.filter(ps_id=i.id)

            tmpResult[i.ps_pid]["children"].append({
                "id": i.id,
                "authName": i.ps_name,
                "path": premission_api_obj[0].ps_api_path,
                "pid": i.ps_pid
            })
    return HttpResponse(json.dumps(premission_dict))


# ==================================================================================
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