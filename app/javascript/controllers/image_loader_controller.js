import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="image-loader"
export default class extends Controller {
  static targets = ['loader', 'image'];

  connect() {
    if (this.imageTarget.complete) {
      this.showImage();
    }
  }

  showImage() {
    this.loaderTarget.classList.add('hidden');
    this.imageTarget.classList.remove('hidden');
  }
}
