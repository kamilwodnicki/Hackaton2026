const supportForm = document.querySelector("#support-form");
const supportMessage = document.querySelector("#support-message");
const description = document.querySelector("#support-description");
const counter = document.querySelector("#support-counter");
const category = document.querySelector("#support-category");
const otherField = document.querySelector("#support-other-wrap");
const otherInput = document.querySelector("#support-other-category");
const imageInput = document.querySelector("#support-image");
const fileName = document.querySelector("#support-file-name");

const session = (() => {
  try { return JSON.parse(localStorage.getItem("rops-auth-session") || "null"); } catch { return null; }
})();

const updateCounter = () => { counter.textContent = `${description.value.length}/1000`; };
description?.addEventListener("input", updateCounter);
updateCounter();

category?.addEventListener("change", () => {
  const isOther = category.value === "inna";
  otherField.hidden = !isOther;
  otherInput.required = isOther;
  if (!isOther) otherInput.value = "";
});

imageInput?.addEventListener("change", () => {
  const file = imageInput.files[0];
  fileName.textContent = file ? file.name : "Nie wybrano zdjęcia";
});

supportForm?.addEventListener("submit", async (event) => {
  event.preventDefault();
  if (!supportForm.reportValidity()) return;
  const file = imageInput.files[0];
  if (file && file.size > 5 * 1024 * 1024) {
    supportMessage.textContent = "Zdjęcie może mieć maksymalnie 5 MB.";
    return;
  }

  const submit = supportForm.querySelector('button[type="submit"]');
  submit.disabled = true;
  supportMessage.textContent = "Wysyłanie zgłoszenia…";
  const data = new FormData(supportForm);
  data.set("user_email", session?.email || "");
  try {
    const response = await fetch("/support", { method: "POST", headers: { "X-Demo-Auth": "mock-session" }, body: data });
    const result = await response.json().catch(() => ({}));
    if (!response.ok) throw new Error(result.error || "Nie udało się wysłać zgłoszenia.");
    supportMessage.textContent = result.message;
    supportMessage.classList.add("is-success");
    supportForm.reset();
    otherField.hidden = true;
    fileName.textContent = "Nie wybrano zdjęcia";
    updateCounter();
  } catch (error) {
    supportMessage.textContent = error.message;
  } finally {
    submit.disabled = false;
  }
});
