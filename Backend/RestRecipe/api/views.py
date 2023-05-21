from api.serializers import RecipeSerializer,IngredientSerializer,CategorySerializer,UserSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from api.models import Recipe, Ingredient, Category, CustomUser
from drf_yasg.utils import swagger_auto_schema
from rest_framework.response import Response
from rest_framework import status
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from django.db import connection
import json 

class UserList(APIView):
    @swagger_auto_schema(operation_description="Returns a list of RecipeBox users.")
    def get(self, request):
        users = CustomUser.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    

class UserProfile(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]
    @swagger_auto_schema(operation_description="Return a user profile detail")
    def get(self, request):
        with connection.cursor() as cursor:
            cursor.execute('exec sp_retriveUserInfo %s',[request.user.id])
            data = cursor.fetchone()
            user_info = CustomUser()
            user_info.user_name = data[0]
            user_info.first_name = data[1]
            user_info.last_name = data[2]
            user_info.email = data[3]
            user_info.date_joined = data[4]
            user_info.profile_image = data[5]

            serializer = UserSerializer(user_info)
            return Response(serializer.data, status=status.HTTP_200_OK)
            
        # # user = CustomUser.objects.get(id=request.user.id)
        # # print(type(user))
        # # serializer = UserSerializer(user)
        # return Response(serializer.data, status=status.HTTP_200_OK)


class Register(APIView):
    @swagger_auto_schema(operation_description="Creates a new RecipeBox User.")
    def post(self, request):
        serializer = UserSerializer(data=request.data)
         
        if serializer.is_valid():
            user = CustomUser.objects.create_user(
                user_name=serializer.validated_data['user_name'],
                email=serializer.validated_data['email'],
                password=serializer.validated_data['password'],
                first_name=serializer.validated_data['first_name'],
                last_name=serializer.validated_data['last_name'],
                profile_image=serializer.validated_data['profile_image']
            )
            
            return Response({'message': 'User created successfully'}, status=status.HTTP_201_CREATED)
        else:
            print(serializer.error_messages)
            print(serializer._errors)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                
                
class Login(ObtainAuthToken):
    def post(self,request):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        if (serializer.is_valid()):
            user = serializer.validated_data['user']
            token, created = Token.objects.get_or_create(user=user)
            return Response({'token': token.key},status=status.HTTP_200_OK)
        else:
            print(serializer.errors)
            return Response(status=status.HTTP_406_NOT_ACCEPTABLE)
        
        
class Logout(APIView):
    def post(self,request):
        pass
  
    
    
class RecipeList(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]
    
    @swagger_auto_schema(operation_description='Returns a list of shuffled recipe')
    def get(self,request):
        recipes = Recipe.objects.all()
        recipeSerializer = RecipeSerializer(recipes,many=True)
        return Response(recipeSerializer.data)
    
    def post(self,request):
        data = {
            'name' : request.data['name'],
            'ingredients': json.loads(request.data['ingredients']),
            'category':request.data['category'],
            'instruction': request.data['instruction'],
            'photo':request.FILES['photo']
        }
        for ingredient in json.loads(request.data['ingredients']):
            try:
                Ingredient.objects.get(name=ingredient)
            except Exception as e:
                Ingredient.objects.create(name=ingredient)
                       
        recipeSerializer = RecipeSerializer(data=data)
        if(recipeSerializer.is_valid()):
            recipeSerializer.save(owner=self.request.user)
            return Response(status=status.HTTP_201_CREATED)
        
        return Response(status=status.HTTP_406_NOT_ACCEPTABLE)
            

class CategorizedRecipe(APIView):
    @swagger_auto_schema(operation_description= "Returns a list of recipe taking a catagory as an input")
    def get(self,request, *args, **kwargs):
        category = kwargs.get('category')
        category = Category.objects.get(name=category)
        recipes = Recipe.objects.filter(category=category)
        recipeSerializer = RecipeSerializer(recipes,many=True)
        return Response(recipeSerializer.data)


class CategoryList(APIView):
    @swagger_auto_schema(operation_description="Returns a list of categories")
    def get(self,request,*args, **kwargs):
        category = Category.objects.all()
        categorySerializer = CategorySerializer(category, many=True)
        return Response(categorySerializer.data)

    
class RecipeIngredient(APIView):
    def get(self,request, *args, **kwargs):
        ingredient = Ingredient.objects.all()
        ingredientSerializer = IngredientSerializer(ingredient, many=True)
        
        return Response(ingredientSerializer.data)
       

class RecipeDetail(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]
    def get(self,request,*args, **kwargs):
        if(kwargs.get('pk')):
            recipe = Recipe.objects.filter(pk=int(kwargs.get('pk')))
            recipeSerializer = RecipeSerializer(recipe,many=True)
            return Response([recipeSerializer.data])
        
        recipe = Recipe.objects.filter(name=kwargs.get('name'))
        recipeSerializer = RecipeSerializer(recipe,many=True)
        
        return Response(recipeSerializer.data)
    
    def post(self,request):
        recipeName = request.data['recipeName']
        recipe = Recipe.objects.get(name=recipeName)
        print(recipe.owner.id, self.request.user.id,recipe.name)
        if(recipe.owner.id == self.request.user.id):
            recipe.delete()
            return Response(status=status.HTTP_200_OK)
        return Response(status=status.HTTP_400_BAD_REQUEST)
      
    

class ApiDoc(APIView):
    @swagger_auto_schema()
    def get(self,request):
        return Response({'Api Documentation':'localhost:8000/doc', 'Api testing playground ' : 'localhost:8000/testApi'})