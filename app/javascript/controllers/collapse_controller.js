import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["collapse", "label", "chevron"]

  connect() {
    this.collapseTarget.addEventListener("show.bs.collapse", this.onShow)
    this.collapseTarget.addEventListener("hide.bs.collapse", this.onHide)
  }

  disconnect() {
    this.collapseTarget.removeEventListener("show.bs.collapse", this.onShow)
    this.collapseTarget.removeEventListener("hide.bs.collapse", this.onHide)
  }

  onShow = () => {
    this.labelTarget.textContent = "Click to hide"
    this.chevronTarget.style.transform = "rotate(180deg)"
  }

  onHide = () => {
    this.labelTarget.textContent = "Click to create an element"
    this.chevronTarget.style.transform = "rotate(0deg)"
  }
}
