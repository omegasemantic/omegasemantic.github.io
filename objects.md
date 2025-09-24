---
layout: default
title: Objects
permalink: /objects/
---

<h2>: objectsthis page caalled stories.mdIpsum dolor sit amet</h2>
objects
Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

<ul class="ObjectList">
  {% for object in site.objects %}
    <li><a href="{{ object.url | relative_url }}">{{ object.title }}</a></li>
  {% endfor %}
</ul>

