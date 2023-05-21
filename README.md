# RecipeBox

A dynamic cook book ( recipe app ) developed using [Flutter](https://flutter.dev/) and [Django](https://www.djangoproject.com/). This app allows users to create, discover, save and rate their favorite recipes.

## Features

- Browse and search for recipes based on different categories.
- View detailed recipe information including ingredients, instructions, and images.
- Save favorite recipes for easy access. [ <b>Not finished yet</b> ]
- Create and manage your own recipe collection.
- User authentication and profile management.
- Integration with a remote SQL Server database for storing recipes and user information.

## RecipeBox in action 

## Installation

To run the Recipe app locally, follow these steps:

### Frontend (Flutter)

1. Clone the repository:
<pre>
  git clone https://github.com/Abthon/RecipeBox.git
</pre>

2. Change into the project directory:
<pre>
  cd RecipeBox/Frontend/RecipeApp/recipe
</pre>

3. Install the dependencies:
<pre>
  flutter pub get <The dependencie>
</pre>

4. Run the app:
<pre>
  flutter run
</pre>


### Backend (Django)

1. Change into the backend directory:
<pre>
  cd RecipeBox/Backend
</pre>

2. Create a virtual environment:
<pre>
  python -m venv <Your Virtual environment Name>
 </pre>
 

3. Activate the virtual environment:

    - For Windows:

    ```
        <Your Virtual environment Name>\Scripts\activate
    ```

    - For macOS/Linux:

    ```
        source <Your Virtual environment Name>/bin/activate
    ```

4. Install the dependencies:
<pre>
  pip install -r requirements.txt
</pre>

5. Now change your directory into the RestRecipe directory because that is where the manage.py file resides
<pre>
  cd RestRecipe
</pre>

6. Generate your migration files and apply the migrations:
<pre>
  python manage.py makemigrations
  python manage.py migrate
</pre>

7. Start the development server:
<pre>
  python manage.py runserver
</pre>


## Contributing

Contributions are welcome! If you'd like to contribute to RecipeBox, please follow these guidelines:

- Fork the repository.
- Create a new branch for your feature/fix.
- Commit your changes with descriptive commit messages.
- Push your branch to your forked repository.
- Open a pull request, and provide a detailed description of your changes.

## License

This project is licensed under the [MIT License](LICENSE).








