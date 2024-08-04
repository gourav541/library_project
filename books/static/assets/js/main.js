document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.like-form').forEach(form => {
        form.addEventListener('submit', function(event) {
            event.preventDefault();

            const formData = new FormData(form);
            const csrfToken = formData.get('csrfmiddlewaretoken');
            const likeUrl = form.dataset.likeUrl;

            fetch(likeUrl, {
                method: 'POST',
                headers: {
                    'X-CSRFToken': csrfToken,
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    isbn: form.dataset.isbn,
                    book_name: form.dataset.bookName,
                    book_author: form.dataset.bookAuthor,
                    book_rating: form.dataset.bookRating,
                    description: form.dataset.description || '',  // Pass description if available
                    thumbnail_url: form.dataset.thumbnailUrl || '',  // Pass thumbnail URL if available
                })
            })
            .then(response => {
                if (response.redirected) {
                    window.location.href = response.url;
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    form.querySelector('.count').innerText = data.like_count;
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        });
    });
});



document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.comment-form').forEach(form => {
        form.addEventListener('submit', function(event) {
            event.preventDefault();

            const formData = new FormData(form);
            const csrfToken = formData.get('csrfmiddlewaretoken');
            const commentUrl = form.dataset.commentUrl;
            const bookIsbn = form.dataset.isbn;
            const newComment = form.querySelector('input[name="newComment"]').value;

            fetch(commentUrl, {
                method: 'POST',
                headers: {
                    'X-CSRFToken': csrfToken,
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    book_isbn: bookIsbn,
                    comment: newComment,
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Get the comments list element for this book
                    const commentsList = document.querySelector(`#comments-list-${bookIsbn}`);
                    if (commentsList) {
                        // Add the new comment to the list
                        commentsList.innerHTML += `<li>${data.user}: ${data.comment}</li>`;
                        // Clear the input field
                        form.querySelector('input[name="newComment"]').value = '';
                    }
                } else {
                    alert('Failed to add comment.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        });
    });
});
