XR Paintings

This repository contains a small collection of WebXR paintings and example scenes. The site is published at:

https://cyclingfern.github.io/XRPaintings/

Local development (HTTPS)
-------------------------

Some WebXR features require a secure context (HTTPS) and won't run from a plain `file://` or an insecure `http://` origin. This project includes a Vite configuration with `vite-plugin-mkcert` so you can run a local HTTPS dev server with a trusted local certificate.

Prerequisites
- Node.js (v16+ recommended) and npm installed.

Quick start
1. Install dependencies:

```bash
npm install
```

2. Start the local dev server (HTTPS):

```bash
npm run dev
```

Vite (with `vite-plugin-mkcert`) will generate a locally-trusted certificate and start a secure server. The terminal output will show the local HTTPS URL to open (for example `https://127.0.0.1:5173/` or a similar port).

Notes and troubleshooting
- If your browser warns about the certificate on first use, follow the browser prompts to trust the local certificate. `vite-plugin-mkcert` typically adds a local CA certificate to your system so browsers accept the dev certificate automatically.
- If you prefer to open a scene directly, each scene folder contains its own `index.html` (for example `shipwreck/index.html`). Some browsers require secure contexts for WebXR — use the HTTPS dev server above if a scene fails to initialize.
- If `npm run dev` is not available, you can run Vite directly with `npx vite`.

Adding a script
----------------
The repository already includes a `dev` script in `package.json` that runs `vite`. If you want a custom script (for example to specify a host or port), update `package.json` scripts. Example:

```json
"scripts": {
	"dev": "vite --host --port 5173"
}
```

Publishing
- The project is published to GitHub Pages at the URL above. If you make changes and want to re-deploy, follow your normal GitHub Pages workflow (e.g., pushing to the `gh-pages` branch or configure GitHub Pages from the repository settings).

License
- See `LICENSE` in the repository.
