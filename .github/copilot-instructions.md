# Repository instructions

This repository is Archana Warrier's personal Jekyll website. Preserve the
site-owned biography, publications, projects, news, CV, assets, and stable URLs.

Most runtime layouts and assets come from pinned al-folio v1 gems. Keep local
overrides minimal, record them in `.al-folio-overrides.yml`, and validate changes
with:

```bash
npm run lint:prettier
bundle exec al-folio upgrade audit
bundle exec al-folio upgrade overrides audit
bundle exec jekyll build
```

Do not edit `_site/`; it is generated build output.
