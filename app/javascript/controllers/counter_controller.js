import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="counter"
export default class extends Controller {
  static targets = ['ticket'];

  connect() {
    this.ticketValue = parseInt(this.ticketTarget.value, 10) || 1;
  }

  increment() {
    if (this.ticketValue < 10) {
      this.ticketValue += 1;
      this.updateOutput();
    }
  }

  decrement() {
    if (this.ticketValue > 1) {
      this.ticketValue -= 1;
      this.updateOutput();
    }
  }

  updateOutput() {
    this.ticketTarget.value = this.ticketValue;
  }
}
