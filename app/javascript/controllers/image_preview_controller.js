import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="image-preview"
export default class extends Controller {
  static targets = ["canvas", "source", "fileName"];

  show() {
    const file = this.sourceTarget.files[0];
    const reader = new FileReader();

    this.fileNameTarget.textContent = `Selected file: ${file.name}`;
    this.fileNameTarget.removeAttribute("hidden");

    reader.onload = () => {
      this.canvasTarget.src = reader.result;
      this.canvasTarget.removeAttribute("hidden");
    };

    reader.readAsDataURL(file);
  }
}
