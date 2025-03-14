import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle-meetings"
export default class extends Controller {
  static targets = ["myRequestsContent", "requestsForMeContent", "myRequestsHeader", "requestsForMeHeader"];

  toggle(event) {
    const value = event.currentTarget.dataset.value;

    if (value === "myRequests") {
      this.myRequestsHeaderTarget.classList.add("underline");
      this.requestsForMeHeaderTarget.classList.remove("underline");

      this.myRequestsContentTarget.classList.remove("d-none");
      this.requestsForMeContentTarget.classList.add("d-none");
    }

    if (value === "requestsForMe") {
      this.myRequestsHeaderTarget.classList.remove("underline");
      this.requestsForMeHeaderTarget.classList.add("underline");

      this.myRequestsContentTarget.classList.add("d-none");
      this.requestsForMeContentTarget.classList.remove("d-none");
    }
  }
}
