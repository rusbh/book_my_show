import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="fill-languages"
export default class extends Controller {
  static targets = ['showSelect', 'languageSelect'];

  connect() {
    this.fetchLanguages();
    this.showSelectTarget.addEventListener('change', () =>
      this.fetchLanguages()
    );
  }

  fetchLanguages() {
    const showId = this.showSelectTarget.value;

    if (showId) {
      fetch(`/shows/${showId}/languages`)
        .then((response) => response.json())
        .then((data) => this.populateLanguages(data))
        .catch((error) => console.error('Error fetching languages:', error));
    }
  }

  populateLanguages(languages) {
    this.languageSelectTarget.innerHTML = '';

    languages.forEach((language) => {
      const option = document.createElement('option');
      option.value = language;
      option.textContent = language;
      this.languageSelectTarget.appendChild(option);
    });
  }
}
