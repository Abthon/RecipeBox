from datetime import timezone
import time
from django.db import models
from django.core.validators import MaxValueValidator,MinValueValidator
from django.contrib.auth.models import AbstractBaseUser,BaseUserManager, PermissionsMixin
from RestRecipe.settings import AUTH_USER_MODEL
from django.utils.crypto import get_random_string
from django.contrib.auth.hashers import make_password,check_password
import uuid 

class CustomUserManager(BaseUserManager):
    def create_user(self, user_name, email, password=None, **extra_fields):
        if not user_name:
            raise ValueError('The UserName field must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, user_name=user_name, **extra_fields)
        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, user_name, email, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self.create_user(user_name, email, password, **extra_fields)


class CustomUser(AbstractBaseUser, PermissionsMixin):
    id = models.CharField(primary_key=True, max_length=100, editable=False, unique=True, default=uuid.uuid4)
    user_name = models.CharField(max_length=50, unique=True)
    first_name = models.CharField(max_length=50,null=True)
    last_name = models.CharField(max_length=50,null=True)
    email = models.EmailField(max_length=50,null=True)
    password = models.CharField(max_length=100,null=True)
    date_joined = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    profile_image = models.ImageField(upload_to='Images/ProfilePics',null=True)
    objects = CustomUserManager()
    
    def set_password(self, raw_password):
        self.password = make_password(raw_password)
    
    def check_password(self, raw_password):
        return check_password(raw_password, self.password)

    USERNAME_FIELD = 'user_name'
    REQUIRED_FIELDS = ['email','first_name','last_name']

    def __str__(self):
        return self.email

    def get_full_name(self):
        return f"{self.first_name} {self.last_name}"

    def get_short_name(self):
        return self.first_name


class Category(models.Model):
    id = models.CharField(primary_key=True, max_length=100, editable=False, unique=True, default=uuid.uuid4)
    name = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class Ingredient(models.Model):
    id = models.CharField(primary_key=True, max_length=100, editable=False, unique=True, default=uuid.uuid4)
    name = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return str(self.name)
    
    
class Recipe(models.Model):
    name = models.CharField(max_length=100)
    id = models.CharField(primary_key=True, max_length=100, editable=False, unique=True, default=uuid.uuid4)
    instruction = models.TextField(null=True)
    ingredients = models.ManyToManyField(Ingredient)
    updated_at = models.DateTimeField(auto_now=True)
    created_at = models.DateTimeField(auto_now_add=True)
    photo = models.ImageField(upload_to='Images/RecipePics',null=True)
    owner = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    category = models.ForeignKey(Category,on_delete=models.CASCADE)

    def __str__(self):
        return self.name


class Review(models.Model):
    id = models.CharField(primary_key=True, max_length=100, editable=False, unique=True, default=uuid.uuid4)
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    recipe = models.ForeignKey(Recipe, on_delete=models.CASCADE)
    recipe = models.ForeignKey(Recipe, related_name='reviews',
                               on_delete=models.CASCADE)
    rating = models.PositiveIntegerField(validators=[MinValueValidator(0), MaxValueValidator(5)])
    avrage_rating = models.FloatField(default=0.0)
    number_of_rating = models.IntegerField(default=0)
    reviewed_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.recipe} has a reating of {self.rating}'