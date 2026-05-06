# Archana Warrier Website

Personal academic site built with Jekyll and adapted from `al-folio`.

## Repository structure

- `_pages/` contains top-level pages such as the homepage, publications, projects, CV, and news.
- `_projects/` contains one markdown file per project card and project detail page.
- `_news/` contains short news entries shown on the homepage and on `/news/`.
- `_bibliography/papers.bib` powers the publications page.
- `_data/navigation.yml` controls the navbar order and labels.
- `assets/` contains images, PDFs, and other static files linked from pages.

## Add a new page

1. Create a markdown file in `_pages/`.
2. Add front matter like this:

```md
---
layout: page
title: Notes
permalink: /notes/
---

Page content goes here.
```

3. Add the page to `_data/navigation.yml` if it should appear in the navbar.

## Add a new project

1. Create a markdown file in `_projects/`.
2. Use front matter like this:

```md
---
layout: page
title: Project Title
description: One-line summary shown on the projects page.
importance: 6
---
```

3. Add any linked files under `assets/` and reference them with `relative_url`.

## Common edits

- Update the homepage text in `_pages/about.md`.
- Update contact links in `_data/socials.yml`.
- Update news items by adding files to `_news/`.
- Update publications in `_bibliography/papers.bib`.
- Update CV content in `_data/cv.yml` and the PDF in `assets/pdf/CV.pdf`.

## Local development

Install dependencies, then run the Jekyll server:

```bash
bundle exec jekyll serve
```

If you use the npm tooling in this repo for asset management, run `npm install` first.
