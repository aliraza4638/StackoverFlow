import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  reset() {
    console.log("Reseting New comment form on submission")
    this.element.reset()
  }
}
