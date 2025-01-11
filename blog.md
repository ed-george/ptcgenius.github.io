---
layout: page
title: Blog
permalink: /blog/
redirect_from:
- /post/
---

<img class="img-fluid" src="{{site.baseurl}}/assets/images/blog-banner.jpg">

{% if site.posts.size > 0 %}
  <div class="archive">
  {% for post in site.posts %} 
    {% assign currDate = post.date | date: "%Y" %} 
    {% if currDate != date %}
      <h1 class="archive-year">{{ currDate }}</h1>
      {% assign date = currDate %} 
    {% endif %}
    <div class="row archive-item mb-3">
      <a href="{{ post.url | relative_url }}" class="col archive-title fs-4 align-self-center">{{ post.title }}</a>
      <span class="col archive-info text-muted text-end align-self-center">{{ post.date | date: "%B %d, %Y" }}</span>
    </div>
  {% endfor %}
  </div>
{% else %}
  <div class="d-flex justify-content-center align-items-center">
    <div class="col-md-12 text-center">
      <h4>Blog posts coming soon!</h4>
    </div>
  </div>
{% endif %}