---
layout: default
title: objects
nav: true
permalink: /objects/
---

<div class="ObjectList" >
  {% for object in site.objects %}
    <p><a href="{{ object.url | relative_url }}">: {{ object.title }}</a></p>
  {% endfor %}
</div>



<a href="/">Home</a>

