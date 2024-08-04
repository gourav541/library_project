# BooksBridge

**BooksBridge** is a community-driven platform that enables users to share and explore book recommendations. This project integrates with the Google Books API to fetch book data and provides custom API endpoints for managing book-related functionalities. The platform features a dynamic frontend to enhance user interaction and book discovery.

## Features

- **Google Books API Integration**: Fetch and display book details such as title, author, description, cover image, and ratings.
- **User Recommendations**: Allow users to submit, view, and manage their book recommendations.
- **Interactive Frontend**: HTML-based frontend with real-time search, filtering, and sorting options.
- **Custom API Endpoints**: Create and manage custom functionalities for book recommendations and user interactions.

## Setup Instructions

### Prerequisites

1. **Install Conda**:
   - Follow the [Conda installation guide](https://docs.conda.io/projects/conda/en/latest/user-guide/install/index.html) for your operating system.

2. **Create and Activate a Conda Environment**:
   ```bash
   conda create -n booksbridge python=3.10.3
   conda activate booksbridge

3. **Generate Google API Keys**:
   - Generate API Credentials from [Google Books API](https://developers.google.com/books/docs/v1/using) and update the .env file

4. **Running the Project**:
```bash
    - python manage.py migrate

    - python manage.py createsuperuser

    - python manage.py runserver


## API Endpoints

### Overview

The project is organized into three main view files:

### Setting Up Django

booksapi.py: Handles integration with the Google Books API and related book functionalities.

server_views.py: Manages database operations, including book recommendations and user interactions.

client_views.py: Manages client-side interactions and renders HTML views for book recommendations.
