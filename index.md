---
layout: default
title: prose
nav: false 
permalink: /
pagetype: landing
container: prose-container
nav: true/false as needed
---

<div class="proseList" >
  {% for prose in site.prose %}
    <p><a href="{{ prose.url | relative_url }}">: {{ prose.title }}</a></p>
  {% endfor %}
</div>




