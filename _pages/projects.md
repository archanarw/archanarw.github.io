---
layout: page
title: Projects
permalink: /projects/
description: A growing collection of research projects.
---

<div class="projects">
{% assign sorted_projects = site.projects | sort: "importance" %}
  <div class="row row-cols-1 row-cols-md-3">
    {% for project in sorted_projects %}
      {% include projects.liquid %}
    {% endfor %}
  </div>
</div>
