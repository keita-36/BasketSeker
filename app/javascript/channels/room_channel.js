import consumer from "./consumer"

const appRoom = consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },
  disconnected() {
    // Called when the subscription has been terminated by the server
    consumer.subscriptions.remove(this);
  },
  received(data) {
    const messages = document.getElementById('messages');
    if (!document.getElementById(`message-${data.id}`)) {
      messages.insertAdjacentHTML('beforeend', `<div id="message-${data.id}">${data.message}</div>`);
    }
  },

  speak: function(event_id, message) {
    return this.perform('speak', {event_id: event_id, message: message});
  }
});

document.addEventListener('turbo:load', () => {
  let chatInput = document.getElementById('chat-input');
  if (chatInput) {
    chatInput.removeEventListener("keyup", handleKeyUp);
    chatInput.addEventListener("keyup", handleKeyUp);
  }
});

function handleKeyUp(e) {
  if (e.key === 'Enter' && e.target.value.trim() !== '') {
    let event_id = e.target.getAttribute('data-event-id');
    appRoom.speak(event_id, e.target.value);
    e.target.value = '';
    e.preventDefault();
  }
}

