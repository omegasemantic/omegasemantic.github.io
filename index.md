---
layout: prose
title: prose
nav: false 
permalink: /
pagetype: landing
---

<div class="proseList">
  {% assign sorted_prose = site.prose | sort: "rank" %}
  {% for prose in sorted_prose %}
    <p><a href="{{ prose.url | relative_url }}">: {{ prose.title }}</a></p>
  {% endfor %}
</div>



