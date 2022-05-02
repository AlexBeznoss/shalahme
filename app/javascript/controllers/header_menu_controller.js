import { Controller } from "@hotwired/stimulus"
import { useClickOutside } from "stimulus-use"

// Connects to data-controller="header-menu"
export default class extends Controller {
  static values = {
    trigger: String,
  };

  connect() {
    const trigger = this._trigger();
    useClickOutside(this);
    trigger.addEventListener("click", this.toggle.bind(this));
    trigger.addEventListener("touchend", this.toggle.bind(this));
  }

  toggle() {
    this.element.classList.toggle("hidden");
  }

  clickOutside(e) {
    if (e.path.map((e) => e.id).includes(this.triggerValue)) {
      e.preventDefault();
    }

    const invalid = 
      this.element.classList.contains("hidden") ||
        e.path.includes(this._trigger());

    if (invalid){
      return;
    }

    this.element.classList.add("hidden");
  }

  _trigger() {
    return document.getElementById(this.triggerValue);
  }
}
