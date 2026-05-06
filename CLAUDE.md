# Website Agent Notes

This repository is the Jekyll source for Archana Warrier's website.

## Working Locally

- Run `bundle exec jekyll serve` when you need a local preview.
- Run `bundle exec jekyll build` before finishing substantive page, layout, or config changes.
- If Bundler fails, install the version required by `Gemfile.lock` first.
- `_site/` is generated build output and should not be edited by hand.

## Content And Structure

- Top-level pages live in `_pages/`; project entries live in `_projects/`; news items live in `_news/`.
- Publications are driven by `_bibliography/papers.bib`; CV content is driven by `_data/cv.yml`.
- Navbar links are defined in `_data/navigation.yml`.
- Static files such as images, PDFs, and embeds live under `assets/`.
- Prefer reusable page structure and collection-driven content over one-off hard-coded markup when a pattern repeats.

## Adding Pages

- Create a markdown file in `_pages/` with `layout`, `title`, and `permalink` front matter.
- Add the page to `_data/navigation.yml` only if it should appear in the navbar.
- Keep permalinks short and stable. Do not rename existing URLs casually.

Example:

```md
---
layout: page
title: Notes
permalink: /notes/
---

Short page content.
```

## Adding Projects And News

- Create one markdown file per project in `_projects/`.
- Use `title`, `description`, and `importance` in project front matter; projects are shown automatically on `/projects/`.
- Create one markdown file per update in `_news/`; news appears on the homepage and on `/news/`.

## Editing Style

- Keep copy direct, concrete, and specific to the actual work.
- Use `relative_url` for internal links and asset references.
- Match the current site structure before adding new layouts or navigation patterns.
- Remove template leftovers instead of leaving unused pages, includes, or config in place.
