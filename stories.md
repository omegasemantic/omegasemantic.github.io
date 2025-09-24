---
layout: default
title: Stories
permalink: /stories/
---

<h2>: Ipsum dolor sit amet</h2>

Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

<ul class="StoriesList">
  {% for story in site.stories %}
    <li><a href="{{ story.url | relative_url }}">{{ story.title }}</a></li>
  {% endfor %}
</ul>

