---
layout: default
title: Stories
permalink: /stories/
---

<h2>Stories</h2>
<ul>
  {% for story in site.stories %}
    <li><a href="{{ story.url | relative_url }}">{{ story.title }}</a></li>
  {% endfor %}
</ul>

