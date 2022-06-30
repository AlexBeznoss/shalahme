import { Controller } from "@hotwired/stimulus"
import { useDebounce } from "stimulus-use";

// Connects to data-controller="message-form"
export default class extends Controller {
  static targets = ["chars", "segments"];
  static debounces = ["change"]

  connect() {
    useDebounce(this, {wait: 50});
    this.change();
  }

  change() {
    const value = this.element.elements.message_content.value;
    const chars = value.length;
    const segments = Math.ceil(chars / 160);

    this.charsTarget.innerHTML = chars;
    this.segmentsTarget.innerHTML = chars === 0 ? 0 : ['~', segments].join('');
  }
}
