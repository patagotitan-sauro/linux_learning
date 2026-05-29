

Extra extensions you'll need for this config to work fully:
```
esbenp.prettier-vscode       — Prettier
ms-python.python             — Python
ms-python.pylance            — Pylance
ms-python.black-formatter    — Python formatter
dbaeumer.vscode-eslint       — ESLint
foxundermoon.shell-format    — Shell formatter
timonwong.shellcheck         — ShellCheck

```


```json
{
    "workbench.sideBar.location": "right",

    "telemetry.telemetryLevel": "off",
    "telemetry.feedback.enabled": false,
    "telemetry.editStats.enabled": false,
    "redhat.telemetry.enabled": false,
    "workbench.enableExperiments": false,
    "update.mode": "none",
    "extensions.autoCheckUpdates": false,
    "python.telemetry.enabled": false,
    "pylance.insidersChannel": "off",

    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.tabSize": 4,
    "editor.insertSpaces": true,
    "editor.wordWrap": "on",
    "editor.minimap.enabled": false,
    "editor.fontSize": 14,
    "editor.lineNumbers": "on",
    "editor.renderWhitespace": "boundary",
    "editor.bracketPairColorization.enabled": true,
    "editor.guides.bracketPairs": true,
    "editor.suggestSelection": "first",
    "editor.inlineSuggest.enabled": true,

    "editor.tokenColorCustomizations": {},

    "[python]": {
        "editor.defaultFormatter": "ms-python.black-formatter",
        "editor.tabSize": 4
    },

    "[javascript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode",
        "editor.tabSize": 2
    },

    "[html]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode",
        "editor.tabSize": 2
    },

    "[css]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode",
        "editor.tabSize": 2
    },

    "[shellscript]": {
        "editor.defaultFormatter": "foxundermoon.shell-format",
        "editor.tabSize": 4
    },

    "python.languageServer": "Pylance",
    "python.analysis.typeCheckingMode": "basic",
    "python.analysis.autoImportCompletions": true,
    "python.analysis.inlayHints.variableTypes": true,
    "python.analysis.inlayHints.functionReturnTypes": true,

    "eslint.enable": true,
    "eslint.run": "onSave",

    "prettier.singleQuote": true,
    "prettier.semi": true,
    "prettier.tabWidth": 2,
    "prettier.printWidth": 80,

    "shellcheck.enable": true,
    "shellcheck.run": "onSave",

    "files.autoSave": "onFocusChange",
    "files.trimTrailingWhitespace": true,
    "files.insertFinalNewline": true,

    "terminal.integrated.defaultProfile.linux": "bash",

    "workbench.startupEditor": "none",
    "workbench.editor.enablePreview": false,
    "breadcrumbs.enabled": true,
    "explorer.confirmDelete": false
}
```

What each section does:
Telemetry block — everything off, no data sent anywhere.
Editor block — general coding comfort settings:

formatOnSave — auto formats on every save
wordWrap — no horizontal scrolling
minimap.enabled: false — removes the tiny code preview on the right, more screen space
bracketPairColorization — colors matching brackets differently so they're easy to spot
renderWhitespace — shows spaces at boundaries so you catch indentation issues

Language specific blocks — each language uses the right formatter and tab size. Python uses 4 spaces (PEP8 standard), HTML/CSS/JS use 2 spaces (web standard).
Python block — Pylance as language server, basic type checking, smart import suggestions, and inlay hints that show variable types inline.
ESLint block — runs on save only, not on every keystroke, less distracting.
Prettier block — single quotes, semicolons, 80 character line width — clean standard style.
ShellCheck block — runs on save for bash scripts.
Files block — auto saves when you click away, removes trailing spaces, adds newline at end of file (Linux standard).
Terminal block — uses bash as default terminal inside VS Code.
Workbench block — no startup editor, files open in full edit mode not preview mode.