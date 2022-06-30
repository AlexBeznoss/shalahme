import { Controller } from "@hotwired/stimulus"
import { useIntersection } from "stimulus-use";

// Connects to data-controller="track-message-read"
export default class extends Controller {
  static values = {
    id: Number,
  }

  connect() {
    this.sent = false;

    // threshold 1 means that event dispatched
    // only after 100% of element is visible
    useIntersection(this, { threshold: 1 });
  }

  appear(entry) {
    if (entry.isIntersecting && !this.sent) {
      const id = this.idValue;
      fetch(`/api/messages/${id}/read`, {method: 'POST'}).
        then(() => { this.sent = true; })
    }
  }
}
