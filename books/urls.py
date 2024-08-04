from django.urls import path
from books.views import server_views

urlpatterns = [
    path('login/', server_views.LoginPage, name='login'),
    path('signup/', server_views.SignUpPage, name='signup'),
    path('logout/', server_views.LogoutPage, name='logout'),
    path('like_book/', server_views.like_book, name='like_book'),
    path('add_comment_ajax/', server_views.add_comment_ajax, name='add_comment_ajax'),
]