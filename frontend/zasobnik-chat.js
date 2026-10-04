// Asystent Zasobnika — pomaga wyszukiwać informacje w plikach innowacji z Directusa (POST /zasobnik/chat)
{
  const form = document.querySelector("#resource-assistant-form");
  const input = document.querySelector("#resource-assistant-input");

  if (form) {
    createChat({ form, input, log: document.querySelector("#resource-assistant-log"), endpoint: "/zasobnik/chat" });

    // Enter wysyła pytanie, Shift+Enter robi nową linię
    input.addEventListener("keydown", (event) => {
      if (event.key === "Enter" && !event.shiftKey) {
        event.preventDefault();
        form.requestSubmit();
      }
    });
  }
}
