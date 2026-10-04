const testerForm = document.querySelector("#tester-form");
const steps = [...document.querySelectorAll("[data-tester-step]")];
const backButton = document.querySelector("#tester-back");
const nextButton = document.querySelector("#tester-next");
const submitButton = document.querySelector("#tester-submit");
const progress = document.querySelector("#tester-progress");
const choiceStatus = document.querySelector("#tester-choice-status");
const confirmDialog = document.querySelector("#tester-confirm-dialog");
const successDialog = document.querySelector("#tester-success-dialog");
const confirmButton = document.querySelector("#tester-confirm-submit");
let currentIndex = 0;
let flow = ["type"];

const selectedType = () => testerForm.elements.type.value;
const buildFlow = () => {
  flow = selectedType() === "ngo" ? ["type", "ngo-details", "ngo-contact"] : ["type", "person-details"];
};

const currentStep = () => document.querySelector(`[data-tester-step="${flow[currentIndex]}"]`);
const showStep = () => {
  buildFlow();
  if (currentIndex >= flow.length) currentIndex = flow.length - 1;
  steps.forEach((step) => {
    const active = step.dataset.testerStep === flow[currentIndex];
    step.hidden = !active;
    step.disabled = !active;
    step.querySelectorAll("input, select, textarea").forEach((field) => { field.disabled = !active; });
  });
  const isFirst = currentIndex === 0;
  const isLast = currentIndex === flow.length - 1;
  backButton.hidden = isFirst;
  nextButton.hidden = isLast;
  submitButton.hidden = !isLast;
  progress.textContent = `Strona ${currentIndex + 1} z ${flow.length}`;
  currentStep()?.querySelector("h2")?.focus();
};

document.querySelectorAll('input[name="type"]').forEach((input) => {
  input.addEventListener("change", () => {
    document.querySelectorAll(".tester-choice").forEach((choice) => choice.classList.toggle("is-selected", choice.contains(input)));
    choiceStatus.textContent = `Wybrano: ${input.value === "person" ? "Osoba fizyczna" : "Organizacja pozarządowa (NGO)"}`;
    nextButton.disabled = false;
    buildFlow();
    progress.textContent = `Strona 1 z ${flow.length}`;
  });
});

nextButton.addEventListener("click", () => {
  if (!testerForm.reportValidity()) return;
  currentIndex += 1;
  showStep();
});

backButton.addEventListener("click", () => {
  currentIndex = Math.max(0, currentIndex - 1);
  showStep();
});

testerForm.addEventListener("submit", (event) => {
  event.preventDefault();
  if (!testerForm.reportValidity()) return;
  confirmDialog.showModal();
  confirmButton.focus();
});

document.querySelector("#tester-confirm-cancel").addEventListener("click", () => confirmDialog.close());
confirmButton.addEventListener("click", () => {
  steps.filter((step) => flow.includes(step.dataset.testerStep)).forEach((step) => {
    step.disabled = false;
    step.querySelectorAll("input, select, textarea").forEach((field) => { field.disabled = false; });
  });
  const data = Object.fromEntries(new FormData(testerForm).entries());
  let entries;
  try {
    entries = JSON.parse(localStorage.getItem("rops-tester-applications") || "[]");
    if (!Array.isArray(entries)) entries = [];
  } catch {
    entries = [];
  }
  entries.push({ ...data, createdAt: new Date().toISOString() });
  localStorage.setItem("rops-tester-applications", JSON.stringify(entries));
  confirmDialog.close();
  successDialog.showModal();
});

document.querySelector("#tester-success-close").addEventListener("click", () => {
  successDialog.close();
  location.href = "index.html";
});

nextButton.disabled = true;
showStep();
