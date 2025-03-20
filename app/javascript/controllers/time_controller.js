import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="time"
export default class extends Controller {
  static targets = ["time"];

  connect() {
    this.updateTime();
    this.interval = setInterval(() => {
      this.updateTime();
    }, 60000);
  }

  disconnect() {
    clearInterval(this.interval);
  }

  updateTime() {
    const userId = this.element.dataset.userId;
    const timezone = this.element.dataset.timezone || "UTC";

    // Fetch the current time using a custom route or endpoint
    fetch(`/user/${userId}/timezone?timezone=${timezone}`)
      .then(response => response.text())
      .then(time => {
        this.timeTarget.innerHTML = time;
      })
    ;
  }
}
