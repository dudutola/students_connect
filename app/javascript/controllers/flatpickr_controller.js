import { Controller } from "@hotwired/stimulus";
// import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  // Define the targets in the controller
  static targets = ["startTime", "endTime"];

  connect() {
    // Initialize Flatpickr on the start time input field
    flatpickr(this.startTimeTarget, {
      enableTime: true, // Enables time selection
      dateFormat: "Y-m-d H:i", // Format: Year-Month-Day Hour:Minute
    });

    // Initialize Flatpickr on the end time input field
    flatpickr(this.endTimeTarget, {
      enableTime: true, // Enables time selection
      dateFormat: "Y-m-d H:i", // Format: Year-Month-Day Hour:Minute
    });
  }
}
