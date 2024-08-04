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


