import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    id: Number,
  };

  connect() {
    this.csrfToken = document.head.querySelector("meta[name=csrf-token]").attributes.content.value;
  }

  async optional(ev) {
    let ok = await this.update({
      mod_action: "optional",
      mod_id: ev.target.dataset.id,
      optional: ev.target.checked,
    });

    if (!ok) {
      ev.target.checked = !ev.target.checked;
    }
  }

  async serverOnly(ev) {
    let ok = await this.update({
      mod_action: "server_only",
      mod_id: ev.target.dataset.id,
      server_only: ev.target.checked,
    });

    if (!ok) {
      ev.target.checked = !ev.target.checked;
    }
  }

  async delete(ev) {
    let ok = await this.update({
      mod_action: "remove",
      mod_id: ev.target.dataset.id,
    });

    if (ok) {
      ev.target.closest(".mod").classList.add("deleted");
    }
  }

  async restore(ev) {
    let ok = await this.update({
      mod_action: "restore",
      mod_id: ev.target.dataset.id,
    });

    if (ok) {
      let mod = ev.target.closest(".mod");
      mod.classList.remove("deleted");
      mod.querySelectorAll("input[type=checkbox]").forEach(el => el.checked = false);
    }
  }

  async update(args) {
    let res = await fetch(`/modlists/${this.idValue}`, {
      method: "PATCH",
      body: JSON.stringify(args),
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": this.csrfToken,
      },
    });

    return res.ok;
  }
}
