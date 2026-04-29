// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function confirmDelete() {
  return confirm("Are you sure you want to delete this intake?");
}

window.confirmDelete = confirmDelete;

function deleteIntake(id) {
  if (!confirm("Are you sure?")) return;

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
      document.getElementById(`intake-${id}`).remove();
    }
  });
}

window.deleteIntake = deleteIntake;
