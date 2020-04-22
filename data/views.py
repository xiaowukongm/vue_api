import os
import shutil

from django.core import serializers
from django.http import HttpResponse
from django.shortcuts import render
from django.views.decorators.http import require_GET,require_POST
from django.core.paginator import Paginator,PageNotAnInteger,EmptyPage
import json
from .models import User,premission,premission_api
from .models import role
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
                "path": "roles",
                "children":[],
            },
            {
                "id": 102 - 2,
                "authName": "权限列表",
                "path": "rights",
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

# @check_permission
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
    result = {"result":"fail","right_list":[]}
    try:
        premission_list = premission.objects.all()
        premission_final_list = []
        for i in premission_list:
            premission_api_obj = premission_api.objects.filter(ps_id=i.id)
            permission_dict = {
                "id": i.id,
                "authName": i.ps_name,
                "level":i.ps_level,
                "path": premission_api_obj[0].ps_api_path,
                "pid": i.ps_pid,
            }
            premission_final_list.append(permission_dict)
        result["result"] = 'success'
        result["right_list"] = list(premission_final_list)
    except Exception as e:
        raise e
    return HttpResponse(json.dumps(result))

# 获取所有权限列表树形结构
def get_premission_tree(request):
    result = {"result": "fail", "right_list": []}
    try:
        premission_list = premission.objects.all()
        all_right_ids = []
        for i in premission_list:
            all_right_ids.append(str(i.id))
        # 根据权限ids获取权限列表树形结构
        right_list = get_rights_tree_by_ids(','.join(all_right_ids))
        print(right_list)
        result["result"] = 'success'
        result["right_list"] = right_list
    except Exception as e:
        raise e
    return HttpResponse(json.dumps(result))


# 获取角色列表
def get_roles(request):
    result = {"result": "fail","all_role_list":[],}
    all_role_list = []
    role_list = role.objects.all()
    for r in role_list:
        ps_ids = r.ps_ids
        role_dict = {
            "id":r.id,
            "roleName":r.role_name,
            "roleDes":r.role_desc,
            "children":[],
        }
        role_dict['children'] = get_rights_tree_by_ids(ps_ids)
        all_role_list.append(role_dict)
    # result = serializers.serialize('json', role.objects.all())
    result['result'] = 'success'
    result['all_role_list'] = all_role_list
    return HttpResponse(json.dumps(result))

# 根据权限ids获取权限列表树形结构
def get_rights_tree_by_ids(ids):
    """
    根据角色的权限ids返回权限树结构，不用返回没有上级权限的下级权限，比如如果没有用户管理权限，即使ids中有用户列表权限也不去返回
    :param ids:
    :return:
    """
    premission_list = ids.split(",")
    # premission_list = premission.objects.all()
    # ids_list = ids.split(",")
    # 存放一级权限
    premission_dict = {}
    for i in premission_list:
        premissions = premission.objects.filter(id=int(i))[0]
        if premissions.ps_level == "0":
            premission_api_obj = premission_api.objects.filter(ps_id=premissions.id)
            premission_dict[premissions.id] = {
                "id":premissions.id,
                "authName":premissions.ps_name,
                "path":premission_api_obj[0].ps_api_path,
                "pid":premissions.ps_pid,
                "children":[]
            }
    tmpResult = {}
    # 二级权限
    for i in premission_list:
        premissions = premission.objects.filter(id=int(i))[0]
        if premissions.ps_level == "1":
            premission_api_obj = premission_api.objects.filter(ps_id=premissions.id)
            tem = premission_dict.get(premissions.ps_pid)
            if tem :
                tmpResult[premissions.id] = {
                    "id": premissions.id,
                    "authName": premissions.ps_name,
                    "path": premission_api_obj[0].ps_api_path,
                    "pid": premissions.ps_pid,
                    "children": []
                }
                tem["children"].append(tmpResult[premissions.id])

    # 3级权限
    for i in premission_list:
        premissions = premission.objects.filter(id=int(i))[0]
        if premissions.ps_level == "2":
            premission_api_obj = premission_api.objects.filter(ps_id=premissions.id)
            three_tem = tmpResult.get(premissions.ps_pid)
            if three_tem:
                three_tem["children"].append({
                    "id": premissions.id,
                    "authName": premissions.ps_name,
                    "path": premission_api_obj[0].ps_api_path,
                    "pid": premissions.ps_pid
                })
    return premission_dict

# 根据权限id删除角色对应的权限并返回角色最新的权限列表
def remove_right_by_id(request):
    """
    根据权限id删除角色对应的权限并返回角色最新的权限列表,只删除当前所传的权限，
    不管其下级权限（删除二级权限时不去管当前角色下当前二级权限下的三级权限），
    在查询权限时做限制即可（get_premission_tree(ids)查询时不去返回没有二级权限的三级权限）
    :param request:
    :return:
    """
    result = {"result":"fail","role_new_right":[]}
    roleId = request.GET.get("roleId")
    right_id = request.GET.get("rightId")
    try:
        role_obj = role.objects.filter(id=int(roleId))
        ps_ids = role_obj[0].ps_ids.split(',')
        ps_ids.remove(right_id)
        ps_ids_str=",".join(ps_ids)
        role_obj.update(ps_ids=ps_ids_str)
        # 获取最新的权限数据返回给前端，以做到前端可以值刷新权限数据不刷新整个角色列表
        role_new_right = get_rights_tree_by_ids(ps_ids_str)
        result['result'] = 'success'
        result['role_new_right'] = role_new_right
    except Exception as e:
        raise e
    return HttpResponse(json.dumps(result))



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


def test(request):
    data = [{"name": "白居易", "value": "1"}, {"name": "李白", "value": "2"}, {"name": "韩明明", "value": "3"},
            {"name": "韩明明1", "value": "4"}, {"name": "韩明明2", "value": "5"}]

    result = {'code':0,'data':data}
    return HttpResponse(json.dumps(result))