import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="search-form"
export default class extends Controller {
  connect() {
    const searchInput = document.querySelector('.search-bar');

    if (searchInput) {
      searchInput.addEventListener('search', function (event) {
        if (!searchInput.value) {
          window.location.href = '/';
        }
      });
    }
  }

  search() {
    this.element.requestSubmit();
  }

  disconnect() {
    const searchBar = document.querySelector('.search-bar');
    if (searchBar && window.location.pathname == '/search') {
      searchBar.focus();
      console.log(window.location.pathname);
      searchBar.setSelectionRange(
        searchBar.value.length,
        searchBar.value.length
      );
    }
  }
}
