const ideaWizard = document.querySelector("#idea-wizard-form");
const ideaSteps = [...document.querySelectorAll("[data-idea-step]")];
const ideaProgress = document.querySelector("#idea-wizard-progress");
const ideaMessage = document.querySelector("#idea-wizard-message");
const ideaBack = document.querySelector("#idea-wizard-back");
const ideaNext = document.querySelector("#idea-wizard-next");
const ideaSubmit = document.querySelector("#idea-wizard-submit");
const ideaConfirm = document.querySelector("#idea-confirm-dialog");
const ideaSuccess = document.querySelector("#idea-success-dialog");
const ideaFlow = ["problem", "solution", "impact"];
let ideaStepIndex = 0;

const showIdeaStep = () => {
  ideaSteps.forEach((step) => {
    const active = step.dataset.ideaStep === ideaFlow[ideaStepIndex];
    step.hidden = !active;
    step.disabled = !active;
    step.querySelectorAll("input, select, textarea").forEach((field) => { field.disabled = !active; });
  });
  ideaProgress.textContent = `Strona ${ideaStepIndex + 1} z ${ideaFlow.length}`;
  ideaBack.hidden = ideaStepIndex === 0;
  ideaNext.hidden = ideaStepIndex === ideaFlow.length - 1;
  ideaSubmit.hidden = ideaStepIndex !== ideaFlow.length - 1;
  ideaMessage.textContent = "";
  ideaSteps[ideaStepIndex].querySelector("h2")?.focus();
};

const validateIdeaStep = () => {
  if (!ideaWizard.reportValidity()) return false;
  if (ideaStepIndex === 0 && !ideaWizard.querySelector('input[name="audience"]:checked')) {
    ideaMessage.textContent = "Wybierz co najmniej jedną grupę odbiorców.";
    ideaWizard.querySelector('input[name="audience"]').focus();
    return false;
  }
  if (ideaStepIndex === 1 && !ideaWizard.querySelector('input[name="value"]:checked')) {
    ideaMessage.textContent = "Wybierz co najmniej jedną wartość rozwiązania.";
    ideaWizard.querySelector('input[name="value"]').focus();
    return false;
  }
  return true;
};

ideaNext.addEventListener("click", () => {
  if (!validateIdeaStep()) return;
  ideaStepIndex += 1;
  showIdeaStep();
});

ideaBack.addEventListener("click", () => {
  ideaStepIndex = Math.max(0, ideaStepIndex - 1);
  showIdeaStep();
});

const valueInputs = [...ideaWizard.querySelectorAll('input[name="value"]')];
valueInputs.forEach((input) => input.addEventListener("change", () => {
  let selected = valueInputs.filter((item) => item.checked);
  if (selected.length > 3) {
    input.checked = false;
    selected = valueInputs.filter((item) => item.checked);
    ideaMessage.textContent = "Możesz wybrać maksymalnie trzy wartości.";
    return;
  }
  ideaMessage.textContent = selected.length === 3 ? "Wybrano maksymalnie trzy wartości." : "";
}));

ideaWizard.addEventListener("submit", (event) => {
  event.preventDefault();
  if (!validateIdeaStep()) return;
  ideaConfirm.showModal();
});

document.querySelector("#idea-confirm-cancel").addEventListener("click", () => {
  ideaConfirm.close();
  showIdeaStep();
});

document.querySelector("#idea-confirm-submit").addEventListener("click", () => {
  ideaSteps.forEach((step) => {
    step.disabled = false;
    step.querySelectorAll("input, select, textarea").forEach((field) => { field.disabled = false; });
  });
  const data = new FormData(ideaWizard);
  let ideas;
  try {
    ideas = JSON.parse(localStorage.getItem("rops-proposed-ideas") || "[]");
    if (!Array.isArray(ideas)) ideas = [];
  } catch {
    ideas = [];
  }
  ideas.unshift({
    title: data.get("title").trim(),
    problem: data.get("problem").trim(),
    frequency: data.get("frequency"),
    intensity: data.get("intensity"),
    audience: data.getAll("audience"),
    solution: data.get("solution").trim(),
    readiness: data.get("readiness"),
    scale: data.get("scale"),
    values: data.getAll("value"),
    impactPerson: data.get("impact_person").trim(),
    impactCommunity: data.get("impact_community").trim(),
    partners: data.get("partners").trim(),
    supportNeeded: data.get("support_needed").trim(),
    status: "Przyjęty",
    createdAt: new Date().toISOString(),
  });
  localStorage.setItem("rops-proposed-ideas", JSON.stringify(ideas));
  ideaConfirm.close();
  ideaSuccess.showModal();
});

document.querySelector("#idea-success-close").addEventListener("click", () => {
  ideaSuccess.close();
  location.href = "panel.html";
});

document.querySelector("#idea-wizard-assistant").addEventListener("click", () => {
  const title = document.querySelector("#idea-wizard-title").value.trim();
  if (!title) {
    ideaMessage.textContent = "Najpierw wpisz tytuł pomysłu.";
    document.querySelector("#idea-wizard-title").focus();
    return;
  }
  location.href = `/?problem=${encodeURIComponent(title)}`;
});

showIdeaStep();
