# books/models.py
from django.contrib.auth.models import AbstractUser, Group, Permission
from django.db import models

class CustomUser(AbstractUser):
    email = models.EmailField(unique=True)
    
    groups = models.ManyToManyField(
        Group,
        related_name='customers',  # Set a custom related_name
        blank=True,
        help_text='The groups this user belongs to.',
        verbose_name='groups'
    )
    
    user_permissions = models.ManyToManyField(
        Permission,
        related_name='customers',  # Set a custom related_name
        blank=True,
        help_text='Specific permissions for this user.',
        verbose_name='user permissions'
    )

    def __str__(self):
        return self.username


class Book(models.Model):
    isbn = models.CharField(max_length=13,null=True, unique=True)
    book_name = models.CharField(max_length=255)
    book_author = models.CharField(max_length=1000)
    description = models.TextField(blank=True)
    thumbnail_url = models.URLField(blank=True, null=True)
    book_rating = models.FloatField()
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    # @property
    # def like_count(self):
    #     return UserInteraction.objects.filter(book=self, interaction_type=1).count()


    def __str__(self):
        return self.book_name
    

class UserInteraction(models.Model):
    INTERACTION_TYPES = [
        (0, 'Unlike'),
        (1, 'Like'),
        (2, 'Like and Comment'),
        (3, 'Comment Only'),
    ]

    book = models.ForeignKey(Book, on_delete=models.CASCADE)
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    interaction_type = models.IntegerField(choices=INTERACTION_TYPES)

    def __str__(self):
        return f"{self.user.username} - {self.book.book_name} - {self.get_interaction_type_display()}"
    
