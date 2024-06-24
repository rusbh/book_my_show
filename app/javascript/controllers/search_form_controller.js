import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="search-form"
export default class extends Controller {
  search() {
    this.element.requestSubmit();
  }

  disconnect() {
    const searchBar = document.querySelector('.search-bar');
    if (searchBar) {
      searchBar.focus();
      searchBar.setSelectionRange(
        searchBar.value.length,
        searchBar.value.length
      );
    }
  }
}
