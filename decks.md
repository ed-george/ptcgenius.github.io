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
    <button class="nav-link" id="nav-player-tab" data-bs-toggle="tab" data-bs-target="#nav-player" type="button" role="tab" aria-controls="nav-player" aria-selected="false">Players</button>
    <button class="nav-link" id="nav-events-tab" data-bs-toggle="tab" data-bs-target="#nav-events" type="button" role="tab" aria-controls="nav-events" aria-selected="false">Events</button>
  </div>
</nav>
<div class="tab-content" id="nav-tabContent">
  <div class="tab-pane fade show active" id="nav-az" role="tabpanel" aria-labelledby="nav-az-tab">
    <ul>
    {% assign az_decks = site.decks | sort: "title" %}
    {% for deck in az_decks %}
      <li class="mb-1"><a href="{{ deck.url | relative_url}}">{{deck.title}}</a> <span class="align-middle smol">({{deck.era}})</span></li>
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
  <div class="tab-pane fade" id="nav-player" role="tabpanel" aria-labelledby="nav-player-tab">
  {% assign players = "" %}
  {% assign players_decks = "" %}
  {% for deck in site.decks %}
    {% for achievement in deck.achievements %}
      {% assign players = players | append: achievement.player | append: "," %}
      {% assign players_decks = players_decks | append: achievement.player | append: "|" | append: deck.slug | append: "," %}
    {% endfor %}
  {% endfor %}

  {% assign players_array = players | split: "," | uniq | sort %}
  {% assign player_decks_array = players_decks | split: "," | uniq | sort %}

  {% for player in players_array %}
  <span class="fs-5 mb-1">{{ player }}</span>
    <ul>
    {% for player_deck in player_decks_array %}
      {% if player_deck contains player %}
        {% assign deck_slug = player_deck | split: "|" | last %}
        {% assign deck = site.decks | where: "slug", deck_slug | first %}
        {% assign deck_events = deck.achievements | map: "competition" | uniq | array_to_sentence_string: "&" %}
          <li class="mb-1"><a href="{{ deck.url | relative_url}}">{{ deck.title }}</a> <span class="align-middle smol">({{ deck_events }})</span></li>
      {% endif %}
    {% endfor %}
    </ul>
  {% endfor %}
  </div>
  <div class="tab-pane fade" id="nav-events" role="tabpanel" aria-labelledby="nav-events-tab">
  {% assign competition = "" %}
  {% assign competition_decks = "" %}
  {% for deck in site.decks %}
    {% for achievement in deck.achievements %}
      {% assign competition = competition | append: achievement.competition | append: "," %}
      {% assign competition_decks = competition_decks | append: achievement.competition | append: "|" | append: deck.slug | append: "," %}
    {% endfor %}
  {% endfor %}

  {% assign competition_array = competition | split: "," | uniq | sort %}
  {% assign competition_decks_array = competition_decks | split: "," | uniq | sort %}

  {% for competition in competition_array %}
  <span class="fs-5 mb-1">{{ competition }}</span>
    <ul>
    {% for competition_deck in competition_decks_array %}
      {% if competition_deck contains competition %}
        {% assign deck_slug = competition_deck | split: "|" | last %}
        {% assign deck = site.decks | where: "slug", deck_slug | first %}
        {% assign deck_players = deck.achievements | map: "player" | array_to_sentence_string: "&" %}
          <li class="mb-1"><a href="{{ deck.url | relative_url}}">{{ deck.title }}</a> <span class="align-middle smol">({{ deck_players }})</span></li>
      {% endif %}
    {% endfor %}
    </ul>
  {% endfor %}
  </div>
</div>
