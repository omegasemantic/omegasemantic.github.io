---
layout: default
title: Objects
permalink: /objects/
---


<ul class="ObjectList">
  {% for object in site.objects %}
    <li><a href="{{ object.url | relative_url }}">{{ object.title }}</a></li>
  {% endfor %}
</ul>

