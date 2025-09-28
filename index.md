---
layout: default
title: objects
nav: false 
permalink: /
pagetype: landing
nav: true/false as needed
---

<div class="ObjectList" >
  {% for object in site.objects %}
    <p><a href="{{ object.url | relative_url }}">: {{ object.title }}</a></p>
  {% endfor %}
</div>




