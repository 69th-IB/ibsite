import { Controller } from "@hotwired/stimulus"
import consumer from "channels/consumer"

export default class extends Controller {
  static targets = ["start", "stop", "validate"];

  connect() {
    this.csrfToken = document.head.querySelector("meta[name=csrf-token]").attributes.content.value;

    let self = this;
    this.subscription = consumer.subscriptions.create("ManageServerChannel", {
      connected() {
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        if (data.state) {
          self.updateUIForState(data.state);
        }
      },
    });
  }

  updateUIForState(state) {
    this.startTarget.disabled = state === "started";
    this.stopTarget.disabled = state !== "started";
  }

  start() {
    fetch("/server/start", {
      method: "POST",
      body: JSON.stringify({
        validate: this.validateTarget.checked,
      }),
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": this.csrfToken,
      },
    });
  }

  stop() {
    fetch("/server/stop", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": this.csrfToken,
      },
    });
  }
}
