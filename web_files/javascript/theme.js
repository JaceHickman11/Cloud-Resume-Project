const themeButtons = document.querySelectorAll('[data-theme-choice]');
const availableThemes = new Set(Array.from(themeButtons, (button) => button.dataset.themeChoice));

const setTheme = (theme) => {
  if (!availableThemes.has(theme)) {
    return;
  }

  document.documentElement.dataset.theme = theme;
  themeButtons.forEach((button) => {
    button.setAttribute('aria-pressed', String(button.dataset.themeChoice === theme));
  });

  try {
    localStorage.setItem('resume-theme', theme);
  } catch {
  }
};

themeButtons.forEach((button) => {
  button.addEventListener('click', () => setTheme(button.dataset.themeChoice));
});

try {
  setTheme(localStorage.getItem('resume-theme') || 'mineral');
} catch {
  setTheme('mineral');
}