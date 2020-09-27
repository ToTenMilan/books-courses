import { Controller } from "stimulus"

export default class extends Controller {
  static targets = []

  // or
  static get targets () {
    return []
  }

  initialize () {}

  connect () {
    this.load()

    if (this.data.has('refreshInterval')) {
      this.startRefreshing()
    }
  }

  disconnect () {
    this.stopRefreshing()
  }

  startRefreshing() {
    this.refreshTimer = setInterval(() => {
      this.load()
    }, this.data.get("refreshInterval"))
  }

  stopRefreshing() {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer)
    }
  }

  load() {
    fetch(this.data.get('url'))
      .then(response => response.text())
      .then(html => {
        this.element.innerHTML = html
      })
  }
}