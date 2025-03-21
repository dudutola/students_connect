import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="meeting"
export default class extends Controller {
  static values = { userId: Number }

  sendRequest(event) {
    event.preventDefault();

    const button = event.target;
    button.textContent = "Sending...";
    button.disabled = true;

    setTimeout(() => {
      button.textContent = "Request Sent!";
      button.classList.add("btn-disabled");
    }, 7000);

    fetch(`/meetings`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({ receiver_id: this.userIdValue })
    });
  }
}
