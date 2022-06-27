import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  update({ target: { checked, dataset: { role, permission } } }) {
    fetch("/admin/permissions/grant", {
      method: checked ? "PUT" : "DELETE",
      body: JSON.stringify({ role, permission }),
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.head.querySelector("meta[name=csrf-token]").attributes.content.value,
      },
    });
  }
}
