import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    console.log("connected")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    console.log("disconnected")
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("received data:", data)
    this.appendLine(data)
    this.updateTableStatus(data)
  },
  appendLine(data) {
    const html = this.createLine(data)
    const element = document.querySelector("#toast-notifications")
    element.insertAdjacentHTML("beforeend", html)
    const notificationToast = document.querySelector(`#toast-notification-${data["invoice_processor"]["id"]}`)
    console.log(notificationToast)
    var toast = new bootstrap.Toast(notificationToast)
    toast.show()
  },
  createLine(data) {
    return `
      <div aria-atomic="true" aria-live="assertive" class="toast fade hide" id="toast-notification-${data["invoice_processor"]["id"]}" role="alert">
        <div class="toast-header">
          <strong class="me-auto">Invoice Processed #${data["invoice_processor"]["id"]}</strong>
          <small class="text-muted">${data["invoice_processor"]["updated_at"]}</small>
          <button aria-label="Close" class="btn-close" data-bs-dismiss="toast" type="button"></button>
        </div>
        <div class="toast-body">
          <b>${data["invoice_processor"]["status"]}</b> Invoice UUID ${data["invoice_uuid"]}
        </div>
      </div>
    `
  },
  updateTableStatus(data) {
    document.querySelector(`#processor-table-status-${data["invoice_processor"]["id"]}`).innerText = data["invoice_processor"]["status"]
    document.querySelector(`#processor-table-error-message-${data["invoice_processor"]["id"]}`).innerText = data["invoice_processor"]["error_message"]
    if (data["invoice_processor"]["status"] === 'uploaded') {
      const a_tag = document.createElement('a');
      a_tag.href = `/invoices?id=${data["invoice_processor"]["invoice_id"]}`
      a_tag.innerHTML = `Invoice ${data["invoice_uuid"]}`
      document.querySelector(`#processor-table-invoice-uuid-${data["invoice_processor"]["id"]}`).appendChild(a_tag)
    }
  }
});
