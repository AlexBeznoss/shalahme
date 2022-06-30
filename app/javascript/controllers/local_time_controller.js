import { Controller } from "@hotwired/stimulus"
import dayjs from 'dayjs';
import utc from 'dayjs/plugin/utc'

dayjs.extend(utc);

// Connects to data-controller="local-time"
export default class extends Controller {
  static values = {
    utc: String,
    format: String,
  }

  connect() {
    this.element.innerHTML = dayjs.unix(this.utcValue).format(this.formatValue);
    this.element.classList.remove('hidden');
  }
}
