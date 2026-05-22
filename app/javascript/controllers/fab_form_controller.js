import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["popup", "button"]

  connect() {
    this.clickOutsideHandler = this.clickOutside.bind(this)
    document.addEventListener("click", this.clickOutsideHandler)
  }

  disconnect() {
    document.removeEventListener("click", this.clickOutsideHandler)
  }

  toggle(event) {
    event.stopPropagation()
    const isOpen = this.popupTarget.classList.contains("fab-popup--open")
    this.popupTarget.classList.toggle("fab-popup--open")
    this.buttonTarget.innerHTML = isOpen
      ? '<i class="bi bi-plus-lg"></i>'
      : '<i class="bi bi-x-lg"></i>'
  }

  clickOutside(event) {
    if (!this.element.contains(event.target) && this.popupTarget.classList.contains("fab-popup--open")) {
      this.toggle(event)
    }
  }
}
