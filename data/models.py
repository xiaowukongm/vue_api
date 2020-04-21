from django.db import models

# 用户
class User(models.Model):
    username = models.CharField(max_length=50)
    password = models.CharField(max_length=50)
    mobile = models.CharField(max_length=50,default="")
    email = models.CharField(max_length=50,default="")
    mg_state = models.BooleanField(default=False)
    role_name = models.CharField(max_length=50,default="")
    role = models.ForeignKey("data.role",on_delete=models.SET_NULL,null=True)

# 角色
class role(models.Model):
    role_name = models.CharField(max_length=50)
    # 所拥有的权限ids
    ps_ids = models.CharField(max_length=50)
    role_desc = models.CharField(max_length=50)

# 权限
class premission(models.Model):
    ps_name = models.CharField(max_length=50)
    # 父级权限id
    ps_pid = models.IntegerField()
    # 权限等级，012  2级权限为操作权限
    ps_level = models.CharField(max_length=50)
    ps_c = models.CharField(max_length=50)
    ps_d = models.CharField(max_length=50)


# 权限api
class premission_api(models.Model):
    # 所对应的权限id
    ps_id = models.ForeignKey("data.premission",on_delete=models.SET_NULL,null=True)
    # 权限动作，例如get_premission_list
    ps_api_action = models.CharField(max_length=50,default="")
    ps_api_order = models.IntegerField(null=True)
    # 访问路径
    ps_api_path = models.CharField(default="",max_length=50)