import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="file-preview"
export default class extends Controller {
  static targets = ["pdfPreview", "fileName", "source"];

  show() {
    const file = this.sourceTarget.files[0];
    if (!file) return;

    const fileType = file.type;

    this.fileNameTarget.textContent = `Selected file: ${file.name}`;
    this.fileNameTarget.removeAttribute("hidden");

    if (fileType === "application/pdf") {
      const fileURL = URL.createObjectURL(file);
      this.pdfPreviewTarget.src = fileURL;
      this.pdfPreviewTarget.removeAttribute("hidden");
    } else {
      this.pdfPreviewTarget.setAttribute("hidden", false);
    }
  }
}
