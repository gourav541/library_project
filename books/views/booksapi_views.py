import os
import requests
import random
from django.shortcuts import render, redirect
from library_project import settings
from django.http import JsonResponse
from dotenv import load_dotenv


load_dotenv()

def fetch_random_books():
    try:
        # Use a fixed or random query to get a selection of books
        random_queries = ['ironman', 'science', 'fiction', 'history', 'technology']
        query = random.choice(random_queries)
        url = f'https://www.googleapis.com/books/v1/volumes?q={query}&key={os.getenv("GOOGLE_BOOKS_API_KEY")}&maxResults=10'
        
        response = requests.get(url)
        response.raise_for_status()  # Raise an exception for HTTP errors

        return response.json().get('items', [])
    
    except requests.exceptions.RequestException as e:
        print(f"Error fetching books: {e}")  # Log the error
        return []  # Return an empty list if an error occurs