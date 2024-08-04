from django.shortcuts import get_object_or_404, render, redirect
from library_project import settings
from django.contrib.auth import authenticate ,login, logout
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from books.forms import CustomUserCreationForm
from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST
from django.contrib import messages
from django.http import JsonResponse
from books.models import Book, UserInteraction
import json
from books.forms import CommentForm
from books.models import Book, Comment
from django.db.models import Count
from books.views.booksapi_views import fetch_book_from_api


def SignUpPage(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Account created successfully!')
            return redirect('website')
        else:
            messages.error(request, 'Error creating account.')
    else:
        form = CustomUserCreationForm()
    return render(request, 'website/SignUp.html', {'form': form})

def LoginPage(request):
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect('website')  # Redirect to a home page
        else:
            messages.error(request, 'Invalid username or password.')
    else:
        form = AuthenticationForm()
    return render(request, 'website/Login.html', {'form': form})

@login_required
def LogoutPage(request):
    logout(request)
    return redirect('login')  # Redirect to login page after logout

@login_required
def like_book(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        print(data)
        isbn = data.get('isbn')
        book_name = data.get('book_name')
        book_author = data.get('book_author')
        book_rating = float(data.get('book_rating'))
        description = data.get('description', '')  # Added
        thumbnail_url = data.get('thumbnail_url', '')  # Added

        # Create or update the book record
        book, created = Book.objects.update_or_create(
            isbn=isbn,
            defaults={
                'book_name': book_name,
                'book_author': book_author,
                'book_rating': book_rating,
                'description': description,  
                'thumbnail_url': thumbnail_url  
            }
        )

        if created:
            message = f"A new book '{book_name}' has been added to the record."
        else:
            message = None

        # Create or update the user interaction record
        interaction, interaction_created = UserInteraction.objects.get_or_create(
            user=request.user,
            book=book,
            defaults={'interaction_type': 1}
        )

        if not interaction_created:
            interaction.interaction_type = 1
            interaction.save()

        # Update like count
        book.like_count = UserInteraction.objects.filter(book=book, interaction_type=1).count()
        book.save()

        response_data = {
            'success': True,
            'message': message,
            'like_count': book.like_count
        }

        return JsonResponse(response_data)

    return JsonResponse({'success': False}, status=400)


@login_required
@require_POST
def add_comment_ajax(request):
    data = json.loads(request.body)
    book_isbn = data.get('book_isbn')
    comment_text = data.get('comment')

    try:
        book = Book.objects.get(isbn=book_isbn)
        comment = Comment.objects.create(
            user=request.user,
            book=book,
            comment=comment_text
        )
        response_data = {
            'success': True,
            'user': request.user.username,
            'comment': comment_text
        }
    except Book.DoesNotExist:
        response_data = {
            'success': False
        }

    return JsonResponse(response_data)