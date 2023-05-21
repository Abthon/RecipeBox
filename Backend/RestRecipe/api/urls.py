from django.urls import path
from . import views
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from rest_framework.authtoken.views import obtain_auth_token

schema_view = get_schema_view(
   openapi.Info(
      title="RecipeBox Api",
      default_version='v1',
      description="A playground for testing RecipeBox api",
      contact=openapi.Contact(email="walelignabenezer@gmail.com"),
   ),
   public=True,
)

# Always make sure to put <int:>'s first and <str:>'s second because casting strings to an integer value will always rise an error (guarented).
urlpatterns = [
   #App Endpoints
   path('', views.ApiDoc.as_view(), name='apiDoc'),
   path('users/', views.UserList.as_view(), name='users'),
   path('user/profile/', views.UserProfile.as_view(), name='users'),
   path('categories/', views.CategoryList.as_view(), name='categories'),
   path('listRecipe/', views.RecipeList.as_view(),name="recipeList"),
   path('listCategories/', views.CategoryList.as_view(),name="categoryList"),
   path('recipe/<int:pk>/',views.RecipeDetail.as_view(),name='recipeDetails'),
   path('recipe/delete/',views.RecipeDetail.as_view(),name='deleteRecipe'),
   path('recipe/<str:name>/',views.RecipeDetail.as_view(),name='recipeDetails'),
   path('recipe/<str:category>/', views.CategorizedRecipe().as_view(),name='categorizedRecipe'),
   
   #Authentication Endpoints
   path('register/',views.Register.as_view(),name='register'),
   path('login/', views.Login.as_view(), name='login'),
   path('logout/', views.Logout.as_view(), name='logout'),
   
   #Documentation Endpoints
   path('doc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
   path('testApi/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
]