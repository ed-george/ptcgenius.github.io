---
layout: page
title: Decks
permalink: /decks/
---

**Deck Count:** {{ site.decks.size }} decks built ✨

<nav>
  <div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
    <button class="nav-link active" id="nav-az-tab" data-bs-toggle="tab" data-bs-target="#nav-az" type="button" role="tab" aria-controls="nav-az" aria-selected="true">A-Z</button>
    <button class="nav-link" id="nav-era-tab" data-bs-toggle="tab" data-bs-target="#nav-era" type="button" role="tab" aria-controls="nav-era" aria-selected="false">Era</button>
    <button class="nav-link" id="nav-other-tab" data-bs-toggle="tab" data-bs-target="#nav-other" type="button" role="tab" aria-controls="nav-other" aria-selected="false">Other</button>
  </div>
</nav>
<div class="tab-content" id="nav-tabContent">
  <div class="tab-pane fade show active" id="nav-az" role="tabpanel" aria-labelledby="nav-az-tab">
    <ul>
    {% assign az_decks = site.decks | sort: "title" %}
    {% for deck in az_decks %}
      <li class="mb-1"><a href="{{ deck.url | relative_url}}">{{deck.title}}</a> <span class="smol">({{deck.era}})</span></li>
    {% endfor %}
    </ul>
  </div>
  <div class="tab-pane fade" id="nav-era" role="tabpanel" aria-labelledby="nav-era-tab">
    {% assign decks_by_era = site.decks | group_by: "era" %}
    {% for era in decks_by_era %}
      <span class="fs-5 mb-1">{{ era.name }}</span>
      <ul>
      {% for deck in era.items %}
        <li class="mb-1"><a href="{{ deck.url | relative_url}}">{{deck.title}}</a></li>
      {% endfor %}
      </ul>
    {% endfor %}
  </div>
  <div class="tab-pane fade" id="nav-other" role="tabpanel" aria-labelledby="nav-other-tab">
    <span class="smol">Coming soon? 👀 Looks like there's nothing here yet!</span>
  </div>
</div>
