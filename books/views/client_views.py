# client_views.py
from django.shortcuts import render, redirect
from library_project import settings
from books.views.booksapi_views import fetch_books , filter_books_by_price
import random
from django.db import models
from books.models import Book , UserInteraction
from django.http import Http404
from books.models import Book
from django.db.models import Count, Q
from books.views.booksapi_views import fetch_book_from_api
from django.contrib.auth.decorators import login_required

def MainWebsite(request):
    price_range = request.GET.get('price_range', None)

    # Define random queries
    random_queries = ['magic', 'success', 'story', 'marvels', 'adventure', 'novel', 'mystery', 'life', 'love', 'history']

    try:
        # Fetch books based on the presence of a price range
        query = random.choice(random_queries)
        books = fetch_books(query)
        if price_range:
            filtered_books = filter_books_by_price(books, price_range)
        else:
            filtered_books = books

        error = not filtered_books  # Show error if no books are found

        # Extract ISBNs from filtered books
        isbn_list = [book.get('volumeInfo', {}).get('industryIdentifiers', [{}])[0].get('identifier', '') for book in filtered_books]
        isbn_list_13 = [isbn for isbn in isbn_list if len(isbn) == 13]

        # Fetch like counts for the books
        book_like_counts = UserInteraction.objects.filter(
            book__isbn__in=isbn_list_13,
            interaction_type=1
        ).values('book__isbn').annotate(like_count=Count('id'))

        # Create a dictionary to map ISBN to like counts
        like_count_dict = {item['book__isbn']: item['like_count'] for item in book_like_counts}

        
        # Add like counts
        for book in filtered_books:
            book_isbn_13 = next((identifier['identifier'] for identifier in book.get('volumeInfo', {}).get('industryIdentifiers', []) if identifier['type'] == 'ISBN_13'), '')
            book['isbn'] = book_isbn_13
            book['like_count'] = like_count_dict.get(book_isbn_13, 0)

            
        context = {
            'books': filtered_books,
            'error': error,
        }

    except Exception as e:
        print(f"An error occurred: {e}")
        context = {
            'books': [],
            'error': True,
        }

    return render(request, 'website/index.html', context)



def SearchBook(request):
    search_query = request.GET.get('search', '')
    query = search_query.lower()
    
    # Fetch books from the API based on the search query
    books = fetch_books(query)
    error = not books
    
    # Extract ISBNs from the fetched books
    isbn_list = [book.get('volumeInfo', {}).get('industryIdentifiers', [{}])[0].get('identifier', '') for book in books]
    isbn_list_13 = [isbn for isbn in isbn_list if len(isbn) == 13]

    # Fetch like counts for the books from the database
    book_like_counts = UserInteraction.objects.filter(
        book__isbn__in=isbn_list_13,
        interaction_type=1
    ).values('book__isbn').annotate(like_count=Count('id'))

    # Create a dictionary to map ISBN to like counts
    like_count_dict = {item['book__isbn']: item['like_count'] for item in book_like_counts}

   
    # Add like counts to each book
    for book in books:
        book_isbn_13 = next((identifier['identifier'] for identifier in book.get('volumeInfo', {}).get('industryIdentifiers', []) if identifier['type'] == 'ISBN_13'), '')
        book['isbn'] = book_isbn_13
        book['like_count'] = like_count_dict.get(book_isbn_13, 0)

        

    context = {
        'books': books,
        'error': error,
        'search_query': search_query,  # Include search_query in context for display in template
    }

    # Render the results in the template
    return render(request, 'website/index.html', context)

@login_required
def liked_books(request):
    user = request.user
    
    # Fetch IDs of books liked by the user
    liked_books_ids = UserInteraction.objects.filter(user=user, interaction_type=1).values_list('book_id', flat=True)

    # Annotate books with their like count
    books = Book.objects.filter(id__in=liked_books_ids).annotate(
        like_count=Count('userinteraction', filter=Q(userinteraction__interaction_type=1))
    )

    context = {
        'books': books
    }

    return render(request, 'website/LikedBooks.html', context)