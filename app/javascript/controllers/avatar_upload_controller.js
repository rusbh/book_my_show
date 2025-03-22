import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["source", "canvas", "fileName"];

  connect() {
    this.submitButton = document.getElementById("submit-avatar");
  }

  show(event) {
    const file = event.target.files[0];

    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.canvasTarget.src = e.target.result;
        this.canvasTarget.hidden = false;
        this.fileNameTarget.textContent = file.name;
        this.fileNameTarget.hidden = false;

        // Enable the submit button
        this.submitButton.disabled = false;
        this.submitButton.classList.remove("opacity-50", "cursor-not-allowed");
      };
      reader.readAsDataURL(file);
    }
  }
}
