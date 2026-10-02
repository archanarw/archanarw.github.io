---
layout: page
title: Theory of Intelligence Tutorials
description: Pluto notebook tutorials in Omega for Yu (2026), The Art of Making Problems Simple.
img:
importance: 6
category: work
---

A series of tutorials that build intuition for the ideas in [Yu (2026), _The Art of Making Problems Simple: A Theory of Intelligence_](https://doi.org/10.31234/osf.io/pghzn_v3). Each chapter is a [Pluto](https://plutojl.org/) notebook written in [Omega](https://github.com/zenna/Omega.jl). The chapters extend examples from [ProbMods]({{ '/projects/probmods.html' | relative_url }}) and do not follow the paper section by section.

Each chapter links to a page with the notebook's code and outputs, and to an interactive version on pluto.land that you can run or download.

{% assign tutorial_pages = site.tutorials | where: 'series', 'intelligence_tutorials' %}
{% for entry in site.data.intelligence_tutorials %}
{% assign chapter_page = tutorial_pages | where: 'chapter', entry.chapter | first %}

### Chapter {{ entry.chapter }}: {{ entry.title }}

{{ entry.description }}

<div class="probmods-links">
  {% if chapter_page %}<a href="{{ chapter_page.url | relative_url }}">Read the chapter</a>{% endif %}
  {% if entry.pluto_land %}<a href="{{ entry.pluto_land }}">Interactive Pluto notebook</a>{% endif %}
</div>
{% endfor %}
