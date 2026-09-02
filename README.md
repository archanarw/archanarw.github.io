# Archana Warrier Website

Personal academic site built with Jekyll and adapted from
[`al-folio`](https://github.com/alshedivat/al-folio). The site uses the al-folio
v1 plugin architecture while keeping Archana's content and custom styling in
this repository.

## Repository structure

- `_pages/` contains the homepage, publications, projects, CV, and news pages.
- `_projects/` contains one Markdown file per project.
- `_news/` contains short updates shown on the homepage and `/news/`.
- `_bibliography/papers.bib` powers the publications page.
- `_data/cv.yml` and `assets/pdf/CV.pdf` contain the web and downloadable CVs.
- `_data/navigation.yml` controls the navbar.
- `assets/` contains images, PDFs, embeds, and other static files.

## Local development

Install Ruby and Node dependencies, then build the site:

```bash
bundle install
npm install
bundle exec jekyll build
```

For a local preview:

```bash
bundle exec jekyll serve
```

Do not edit `_site/`; Jekyll generates it.

## Common content updates

- Edit the homepage biography in `_pages/about.md`.
- Add projects under `_projects/` and news items under `_news/`.
- Update publications in `_bibliography/papers.bib`.
- Update the web CV in `_data/cv.yml` and replace `assets/pdf/CV.pdf` when the
  downloadable CV changes.
- Update contact links in `_data/socials.yml`.

Internal links and asset references should use Jekyll's `relative_url` filter.

## al-folio v1 overrides

Most layouts and runtime assets come from pinned al-folio gems. The small set of
site-owned overrides is tracked in `.al-folio-overrides.yml`. After changing an
override or upgrading the gems, run:

```bash
bundle exec al-folio upgrade audit
bundle exec al-folio upgrade overrides audit
bundle exec jekyll build
```
