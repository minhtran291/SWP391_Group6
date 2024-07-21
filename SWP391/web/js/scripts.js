document.addEventListener('DOMContentLoaded', (event) => {
    const stars = document.querySelectorAll('.star-rating input');
    
    stars.forEach(star => {
        star.addEventListener('change', () => {
            const rating = star.value;
            console.log(`Rating: ${rating}`);
        });
    });
});
