import { Controller } from "@hotwired/stimulus"
import consumer from "channels/consumer"

export default class extends Controller {
  static targets = [
    "mission", "missionLink", "modlist", "modlistLink",
    "ws", "vn", "spe", "gm",
    "headlessClients",
    "start", "stop", "validate",
    "logOutput",
  ];

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

        if (data.log) {
          let scroll = (self.logOutputTarget.scrollTopMax - self.logOutputTarget.scrollTop) <= 5;

          self.logOutputTarget.innerHTML += data.log;

          let logLength = self.logOutputTarget.innerHTML.length;
          if (logLength > 100000) {
            self.logOutputTarget.innerHTML = self.logOutputTarget.innerHTML.substring(logLength - 90000);
          }

          if (scroll) {
            self.logOutputTarget.scrollTop = self.logOutputTarget.scrollTopMax;
          }
        }
      },
    });

    this.missionTarget.addEventListener("change", this.updateMission.bind(this));
    this.modlistTarget.addEventListener("change", this.updateModlist.bind(this));

    this.wsTarget.addEventListener("change", this.updateCDLC.bind(this));
    this.vnTarget.addEventListener("change", this.updateCDLC.bind(this));
    this.speTarget.addEventListener("change", this.updateCDLC.bind(this));
    this.gmTarget.addEventListener("change", this.updateCDLC.bind(this));

    this.headlessClientsTarget.addEventListener("change", this.updateHC.bind(this));
  }

  updateMission() {
    let id = this.missionTarget.value;
    this.updateServerConfig({
      mission_id: id,
    })

    this.missionLinkTarget.href = `/missions/${id}/edit`;
  }

  updateModlist() {
    let id = this.modlistTarget.value;

    this.updateServerConfig({
      modlist_id: id,
    })

    this.modlistLinkTarget.href = `/modlists/${id}`;
  }

  updateCDLC() {
    let ws = this.wsTarget.checked;
    let vn = this.vnTarget.checked;
    let spe = this.speTarget.checked;
    let gm = this.gmTarget.checked;

    let cdlc = [];
    if (ws) cdlc.push("ws");
    if (vn) cdlc.push("vn");
    if (spe) cdlc.push("spe");
    if (gm) cdlc.push("gm");

    let branch = "profiling";
    if (cdlc.length > 0) {
      branch = "creatordlc";
    }

    this.updateServerConfig({
      creator_dlc: cdlc.join(";"),
      branch: branch,
    })
  }

  updateHC() {
    let hc = Math.max(0, parseInt(this.headlessClientsTarget.value));

    if (isNaN(hc)) {
      hc = 0;
    }

    this.headlessClientsTarget.value = hc;

    this.updateServerConfig({
      headless_clients: hc,
    })
  }

  updateServerConfig(data) {
    fetch("/server_configs/1", {
      method: "PUT",
      body: JSON.stringify(data),
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": this.csrfToken,
      },
    });
  }

  updateUIForState(state) {
    this.startTarget.disabled = state === "started";
    this.stopTarget.disabled = state !== "started";
  }

  async start() {
    this.startTarget.disabled = true;

    let res = await fetch("/server/start", {
      method: "POST",
      body: JSON.stringify({
        validate: this.validateTarget.checked,
      }),
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": this.csrfToken,
      },
    });

    if (!res.ok) {
      this.startTarget.disabled = false;
    }
  }

  async stop() {
    this.stopTarget.disabled = true;

    let res = await fetch("/server/stop", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": this.csrfToken,
      },
    });

    if (!res.ok) {
      this.stopTarget.disabled = false;
    } else {
      this.validateTarget.checked = false;
    }
  }
}
