---
layout: page
title: Decks
permalink: /decks/
---

**A-Z**

{% assign all_decks = site.decks | sort: "title" %}
{% for deck in all_decks %}
* [{{deck.title}}]({{ deck.url | relative_url}}) <span class="smol">({{deck.era}})</span>
{% endfor %}

<hr>

**Deck Count:** {{ all_decks.size }} decks built ✨
