---
layout: page
title: The Kitchen
permalink: /kitchen/
---

{% assign decks = site.decks | where_exp: "item", "item.in_progress == true" %}

<div class="clearfix">
  <img src="{{site.baseurl}}/assets/images/the_kitchen.png" class="col-md-6 float-md-end mb-3 ms-md-3 ps-3" style="width: auto; height: 192px;">

  <p>Wondering what decks I am currently building at the moment? Then step inside my "kitchen" where I am usually cooking something tasty I have found on my travels!</p>

  <p>These lists are often from formats with cards that are harder to source, formats I am currently looking into more or even just cool decks I have seen played previously.</p>

  <p>Whenever possible, I will provide credit to the list's creator within the links or description of each page, however please open <a href="{{ site.repository.issue-template-url.deck | append: 'Attribution issue' | uri_escape }}" target="_blank">an issue</a> if you believe attribution is incorrect.</p>

  <p><em>Bon appétit</em> 👨‍🍳 - Ed</p>

  <hr>
  
  {% if decks.size > 0 %}
      <div class="alert alert-info" role="alert">
    <h4>Can you help me cook?</h4>
  <p>These decks are likely part-complete, so if you are able to help source any of the physical cards <em>please</em> do let me know via social media (or IRL if you are at an upcoming UK event).</p>
  <p><a class="text-reset" href="https://x.com/PTCGenius">@PTCGenius</a> is a good place to find me ✌️ - Any offers of sales and/or trades can be considered!</p>
  </div>
    {% assign decks_by_era = decks | group_by: "era" %}
    {% for era in decks_by_era %}
      <h1 class="archive-year">{{ era.name }}</h1>
      {% for deck in era.items %}
        <div class="row archive-item mb-3">
        <a href="{{ deck.url | relative_url}}" class="col archive-title fs-4 align-self-center">{{ deck.title }}</a>
        <span class="col archive-info text-muted text-end align-self-center">
          {% if deck.achievements %}
            {% assign arr = "" %}
            {% for achievement in deck.achievements %}
              {% assign division = achievement.division | downcase %}
              {% case division %}
                {% when "juniors", "junior" %}
                   {% assign division = " (JR)" %}
                {% when "seniors", "senior" %}
                   {% assign division = " (SR)" %}
                {% else %}
                   {% assign division = "" %}
              {% endcase %}
              {% assign arr = arr | append: achievement.position |  append: " @ " | append: achievement.competition | append: " by " | append: achievement.player | append: division | append: "," %}
            {% endfor %}
            {{ arr | split: "," | array_to_sentence_string: "&" }}
          {% else %}
            {{ deck.description }}
          {% endif %}
        </span>
        </div>
      {% endfor %}
    {% endfor %}
    <hr>
    <span class="report-issue text-muted">These decks should not appear elsewhere on this site, so if you happen to spot them please report an issue <a href="{{ site.repository.issue-template-url.deck | append: 'Kitchen List Error' | uri_escape }}" target="_blank">here</a>.</span>
    <hr>
  {% else %}
    <strong>It looks like the kitchen isn't cooking anything right now, please come back soon!</strong>
  {% endif %}

</div>
