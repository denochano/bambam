import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["popup", "button"]

  toggle() {
    const isOpen = this.popupTarget.classList.contains("fab-popup--open")
    this.popupTarget.classList.toggle("fab-popup--open")
    this.buttonTarget.innerHTML = isOpen
      ? '<i class="bi bi-plus-lg"></i>'
      : '<i class="bi bi-x-lg"></i>'
  }
}
