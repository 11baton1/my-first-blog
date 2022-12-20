from django.contrib.auth import get_user_model


def create_user(username, password, email, first_name, last_name):
    User = get_user_model()
    user = User.objects.create_user(username,email=email,password=password, first_name=first_name, last_name=last_name)
    user.save()

def show_users():
    print(list(get_user_model().objects.all()))
