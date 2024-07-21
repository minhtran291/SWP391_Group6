// edit-rating.js
document.addEventListener('DOMContentLoaded', (event) => {
    const stars = document.querySelectorAll('.star-rating input[type="radio"]');
    
    stars.forEach(star => {
        star.addEventListener('change', function() {
            const rating = star.value;
            console.log(`Rating: ${rating}`);
        });
    });

    const editButtons = document.querySelectorAll('.edit-button');
    editButtons.forEach(button => {
        button.addEventListener('click', function() {
            const reviewId = button.dataset.reviewId;
            const reviewElement = document.getElementById(`review-${reviewId}`);
            const rating = reviewElement.dataset.rating;
            const comment = reviewElement.dataset.comment;
            
            document.getElementById('edit-review-id').value = reviewId;
            document.querySelector(`.star-rating input[value="${rating}"]`).checked = true;
            document.getElementById('edit-comment').value = comment;
            document.getElementById('edit-review-form').style.display = 'block';
        });
    });
});
