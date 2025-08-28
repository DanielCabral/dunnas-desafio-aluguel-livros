document.addEventListener('DOMContentLoaded', function() {
    const burgerMenu = document.getElementById('burger-menu');
    const sidebar = document.getElementById('sidebar');

    if (burgerMenu && sidebar) {
        burgerMenu.addEventListener('click', function() {
            sidebar.classList.toggle('active');
        });
    }
});