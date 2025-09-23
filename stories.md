---
layout: default
title: Stories
---

<h1>Stories</h1>
<ul>
{% for story in site.stories %}
  <li><a href="{{ story.url }}">{{ story.title }}</a></li>
{% endfor %}
</ul>

