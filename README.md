# Angular 21.1.4 — WSC2026

A small, real **Angular** application (version **21.1.4**), part of the WorldSkills 2026
Web Technologies (TP17) set. Runtime pinned to the competition spec.

## Run it

```bash
docker compose up --build
```

Then open **http://localhost**. This runs the Angular dev server (`ng serve`) inside Docker on
port 80. The WSC2026 ingress hosts (`*.skill17.com`) are allowed via `allowedHosts` in
`angular.json`, so it also works behind the cloud ingress.

Stop it with `docker compose down`.

## Develop

For a hot-reloading loop on your machine you need **Node 24.1.0** and **npm 11.5.0** installed locally (the same versions the Docker image pins).

```bash
npm install
npm start
```

The dev server runs on **http://localhost** and reloads on save.
Edit **src/app/app.html and src/app/app.ts** to change the app.

## Tailwind CSS

Tailwind **4.1.18** is installed and wired up, but nothing in the template uses it — it is here
for you to reach for if you want it, and it costs nothing if you don't. Add utility classes to
your markup and they work straight away:

```html
<div class="rounded-xl bg-slate-800 p-6 text-slate-100">…</div>
```

`@tailwindcss/postcss` is registered in `.postcssrc.json`, which Angular's builder picks up
automatically. The entry stylesheet is `src/styles.css`, already listed under `styles` in
`angular.json`.

The template's own CSS lives inside Tailwind's `base` layer, and that detail matters: unlayered
CSS outranks *every* cascade layer, so left as it was a rule like `button { background: … }`
would silently beat `class="bg-blue-500"` and the class would appear to do nothing. Inside
`base` those rules still style unclassed elements, while utilities override them as expected.

Tailwind 4 needs no `tailwind.config.js` — it is configured in CSS. Customise the theme with
`@theme { … }` in `src/styles.css`. Docs: <https://tailwindcss.com/docs>

## Stack

- Node 24.1.0 / npm 11.5.0
- Angular 21.1.4
- Tailwind CSS 4.1.18 — installed and configured, use it or ignore it
