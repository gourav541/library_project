# client_views.py
from django.shortcuts import render, redirect
from library_project import settings
from books.views.booksapi_views import fetch_books , filter_books_by_price
import random
from django.db import models
from books.models import Book , UserInteraction
from django.http import Http404
from books.models import Book, Comment
from django.db.models import Count
from books.views.booksapi_views import fetch_book_from_api
from books.forms import CommentForm

def MainWebsite(request):
    price_range = request.GET.get('price_range', None)

    # Define random queries
    random_queries = ['book', 'random', 'story', 'the', 'adventure', 'novel', 'mystery', 'life', 'love', 'history']

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

        # Fetch comments for each book
        books_db = Book.objects.filter(isbn__in=isbn_list_13).prefetch_related('comment_set')
        book_db_dict = {book.isbn: book for book in books_db}

        # Add like counts and comments to each book
        for book in filtered_books:
            book_isbn_13 = next((identifier['identifier'] for identifier in book.get('volumeInfo', {}).get('industryIdentifiers', []) if identifier['type'] == 'ISBN_13'), '')
            book['isbn'] = book_isbn_13
            book['like_count'] = like_count_dict.get(book_isbn_13, 0)

            # Get comments from the database
            book_db = book_db_dict.get(book_isbn_13)
            if book_db:
                book['comments_count'] = book_db.comment_set.count()
                book['comments'] = book_db.comment_set.all()
            else:
                book['comments_count'] = 0
                book['comments'] = []

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

    # Fetch comments for each book
    books_db = Book.objects.filter(isbn__in=isbn_list_13).prefetch_related('comment_set')
    book_db_dict = {book.isbn: book for book in books_db}

    # Add like counts and comments to each book
    for book in books:
        book_isbn_13 = next((identifier['identifier'] for identifier in book.get('volumeInfo', {}).get('industryIdentifiers', []) if identifier['type'] == 'ISBN_13'), '')
        book['isbn'] = book_isbn_13
        book['like_count'] = like_count_dict.get(book_isbn_13, 0)

        # Get comments from the database
        book_db = book_db_dict.get(book_isbn_13)
        if book_db:
            book['comments_count'] = book_db.comment_set.count()
            book['comments'] = book_db.comment_set.all()
        else:
            book['comments_count'] = 0
            book['comments'] = []

    context = {
        'books': books,
        'error': error,
        'search_query': search_query,  # Include search_query in context for display in template
    }

    # Render the results in the template
    return render(request, 'website/index.html', context)


def book_detail(request, isbn):
    book, created = Book.objects.get_or_create(isbn=isbn)

    try:
        book_data = fetch_book_from_api(isbn)
        if book_data:
            if created:
                # If the book is newly created, set all fields from the API data
                book.book_name = book_data['title']
                book.book_author = ', '.join(book_data['authors'])
                book.book_rating = book_data.get('averageRating', 0)
                book.description = book_data.get('description', '')
                book.thumbnail = book_data.get('thumbnail', '')
            else:
                # If the book already exists, update missing fields
                if not book.book_name:
                    book.book_name = book_data['title']
                if not book.book_author:
                    book.book_author = ', '.join(book_data['authors'])
                if book.book_rating is None:
                    book.book_rating = book_data.get('averageRating', 0)
                if not book.description:
                    book.description = book_data.get('description', '')
                if not book.thumbnail:
                    book.thumbnail = book_data.get('thumbnail', '')
            book.save()
        else:
            raise Http404("Book not found in external source")
    except Exception as e:
        print(f"Error fetching book data: {e}")
        raise Http404("Error fetching book details")

    comments = Comment.objects.filter(book=book).order_by('-created_at')
    
    # Optional: Fetch similar books
    similar_books = Book.objects.exclude(isbn=isbn).annotate(like_count=Count('userinteraction')).order_by('-like_count')[:10]
    
    context = {
        'book': book,
        'comments': comments,
        'similar_books': similar_books,
    }
    return render(request, 'website/bookDetails.html', context)
