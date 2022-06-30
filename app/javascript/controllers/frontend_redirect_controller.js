import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="frontend-redirect"
export default class extends Controller {
  static values = {
    path: String
  }

  connect() {
    Turbo.visit(this.pathValue, {action: 'advance'});
  }
}
