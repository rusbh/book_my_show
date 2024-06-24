document.addEventListener('turbo:load', function () {
  const searchInput = document.querySelector('.search-bar');

  if (searchInput) {
    searchInput.addEventListener('search', function (event) {
      if (!searchInput.value) {
        window.location.href = '/';
      }
    });
  }
});
