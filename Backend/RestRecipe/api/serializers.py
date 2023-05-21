from rest_framework import serializers
from .models import (Category, Recipe, Review, Ingredient, CustomUser)

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = "__all__"


class ReviewSerialiZer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = '__all__'


class IngredientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Ingredient
        fields = "__all__"

# takes this as an input --> id, name, category, ingredients
class RecipeSerializer(serializers.ModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.first_name')
    ingredients = serializers.SlugRelatedField(many=True,queryset=Ingredient.objects.all(),slug_field='name')
    category = serializers.SlugRelatedField(queryset=Category.objects.all(), slug_field='name')
    reviews = ReviewSerialiZer(many=True, read_only=True)

    class Meta:
        model = Recipe
        fields = "__all__"


class CategorySerializer(serializers.ModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')
    recipes = RecipeSerializer(many=True, read_only=True, required=False)

    class Meta:
        model = Category
        fields = "__all__"
        
        