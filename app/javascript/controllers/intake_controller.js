import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Intake Stimulus controller connected")
  }

  delete(event) {
    event.preventDefault()

    if (!confirm("Are you sure?")) return

    const id = event.currentTarget.dataset.intakeId

    fetch(`/intakes/${id}`, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      }
    })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          document.getElementById(`intake-${id}`).remove()
        }
      })
  }
}