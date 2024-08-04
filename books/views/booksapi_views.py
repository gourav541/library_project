# booksapi_views.py
import os
import requests
from django.shortcuts import render, redirect
from django.http import JsonResponse
from dotenv import load_dotenv
import time

load_dotenv()



def fetch_books(query, max_results=10, max_pages=2):
    """
    Fetch books from Google Books API with pagination and error handling.

    Parameters:
    - query (str): The search query for books.
    - max_results (int): Number of results per page.
    - max_pages (int): Maximum number of pages to fetch.

    Returns:
    - List of books (list).
    """
    books = []
    start_index = 0
    pages_fetched = 0

    while pages_fetched < max_pages:
        try:
            url = f'https://www.googleapis.com/books/v1/volumes?q={query}&startIndex={start_index}&maxResults={max_results}&key={os.getenv("GOOGLE_BOOKS_API_KEY")}'
            response = requests.get(url)
            response.raise_for_status()
            data = response.json()
            
            items = data.get('items', [])
            if not items:
                break

            books.extend(items)
            start_index += max_results
            pages_fetched += 1

            # If there are no more results, break the loop
            if len(items) < max_results:
                break

        except requests.HTTPError as http_err:
            print(f'HTTP error occurred: {http_err}')
            # Retry after a delay
            time.sleep(5)
        except Exception as err:
            print(f'Other error occurred: {err}')
            break
    
    return books



def filter_books_by_price(books, price_range):
    """
    Filter books based on the provided price range.

    Parameters:
    - books (list): List of book dictionaries to be filtered.
    - price_range (str): Price range to filter books.

    Returns:
    - List of filtered books.
    """
    filtered_books = []

    for book in books:
        try:
            # Extract price info
            price_info = book.get('saleInfo', {}).get('listPrice', {})
            amount = price_info.get('amount')
            
            if amount is None:
                # Skip books without a price
                print(f"Excluding book ID: {book.get('id')} due to missing price")
                continue

            price = float(amount)
            print(f"Checking price: {price}, Price Range: {price_range}")

            # Price range filtering
            if price_range == 'less_than_1000' and price >= 1000:
                continue
            elif price_range == '1000_to_2000' and not (1000 <= price <= 2000):
                continue
            elif price_range == 'above_2000' and price <= 2000:
                continue

            filtered_books.append(book)

        except (KeyError, ValueError) as e:
            print(f"Error processing book: {e}")  # Log the error
            continue  # Skip if any expected key is missing or value conversion fails

    print(f"Filtered books count: {len(filtered_books)}")  # Debug output
    return filtered_books



def fetch_book_from_api(isbn):
    url = f'https://www.googleapis.com/books/v1/volumes?q=isbn:{isbn}&key={os.getenv("GOOGLE_BOOKS_API_KEY")}'
    response = requests.get(url)
    response.raise_for_status()
    data = response.json()

    items = data.get('items', [])
    if items:
        book_info = items[0]['volumeInfo']
        return {
            'title': book_info.get('title', 'Unknown Title'),
            'authors': book_info.get('authors', ['Unknown Author']),
            'averageRating': book_info.get('averageRating', 0),
            'description': book_info.get('description', 'No description available'),
            'thumbnail': book_info.get('imageLinks', {}).get('thumbnail', '')
        }
    return None
