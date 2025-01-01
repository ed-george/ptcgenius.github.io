---
layout: page
title: Decks
permalink: /decks/
---

 {% assign decks_by_era = site.decks | group_by: "era" %}
 {% for era in decks_by_era %}
#### {{ era.name }}
{% for deck in era.items %}
[{{deck.title}}]({{ deck.url | relative_url}})
{% endfor %}
{% endfor %}
