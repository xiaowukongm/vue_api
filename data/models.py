from django.db import models

# Create your models here.
class User(models.Model):
    username = models.CharField(max_length=50)
    password = models.CharField(max_length=50)
    mobile = models.CharField(max_length=50)
    email = models.CharField(max_length=50)
    mg_state = models.BooleanField(default=False)
    role_name = models.CharField(max_length=50)
