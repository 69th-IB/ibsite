import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor"];
  static values = {
    id: Number,
  };

  connect() {
    this.csrfToken = document.head.querySelector("meta[name=csrf-token]").attributes.content.value;
    console.log("loaded");
  }
}
