---
layout: page
title: Pokémon TCG Deck to YAML Converter
permalink: /converter/
sitemap: false
---
<div class="col-lg-8 mx-auto">
  <ul>
    <li class="mb-2">This tool is designed to take a deck list in a PTCGL format and convert it to the YAML format used by this site to display decks.</li>
    <li li class="mb-2">Set list shortcodes can be referenced <a href="https://www.justinbasil.com/guide/appendix1" target="_blank">here</a></li>
    <li class="mb-2">For an example see the <code class="language-plaintext highlighter-rouge">_decks</code> folder in <a href="https://github.com/ed-george/ptcgenius.github.io/tree/main/_decks">GitHub</a></li>
  </ul>
  <div class="mb-3">
    <label for="titleInput" class="form-label">Deck Title</label>
    <input type="text" class="form-control" id="titleInput" placeholder="Enter deck title">
  </div>
  <div class="mb-3">
    <label for="eraInput" class="form-label">Era</label>
    <input type="text" class="form-control" id="eraInput" placeholder="Enter era (e.g., 2024)">
  </div>
  <div class="mb-3">
    <label for="descriptionInput" class="form-label">Description</label>
    <textarea class="form-control" id="descriptionInput" rows="2" placeholder="Enter a description for the deck"></textarea>
  </div>
  <div class="mb-3">
    <label for="linksInput" class="form-label">Links</label>
    <textarea class="form-control" id="linksInput" rows="3" placeholder="Enter links (one per line, format: href|title)"></textarea>
  </div>
  <div class="mb-3">
    <label for="deckInput" class="form-label">Deck List</label>
    <textarea class="form-control" id="deckInput" rows="10" placeholder="Enter your deck list here..."></textarea>
  </div>

  <div class="d-grid">
    <button class="btn btn-primary" onclick="convertToYaml()">Convert to YAML</button>
  </div>

  <div class="mt-4">
    <h2>Generated YAML</h2>
    <div id="copyContainer" class="d-flex align-items-center mb-2" style="display: none;">
      <button class="btn btn-secondary me-2" onclick="copyToClipboard()">Copy to Clipboard</button>
      <span id="copyFeedback" class="text-success" style="display: none;">Copied!</span>
    </div>
    <pre id="yamlOutput">Your YAML output will appear here...</pre>
  </div>
</div>

<script>
  function convertToYaml() {
    // Get input values
    const title = document.getElementById("titleInput").value.trim() || "Generated Deck";
    const era = document.getElementById("eraInput").value.trim() || "2024";
    const description = document.getElementById("descriptionInput").value.trim() || "A Pokémon TCG deck.";
    const linksInput = document.getElementById("linksInput").value.trim();
    const deckInput = document.getElementById("deckInput").value.trim();
  
    // Process links
    const links = linksInput
      ? linksInput.split("\n").map(line => {
          const [href, title] = line.split("|").map(part => part.trim());
          return { href, title };
        })
      : [];
  
    // Initialize YAML structure
    const yaml = {
      title,
      layout: "deck",
      era,
      description,
      links,
      cards: { pokemon: [], trainers: [], energy: [] }
    };
  
    // Process deck list
    let currentCategory = null;
    const lines = deckInput.split("\n");
    lines.forEach(line => {
      if (line.startsWith("Pokémon:") || line.startsWith("Pokemon:")) {
        currentCategory = "pokemon";
      } else if (line.startsWith("Trainer:") || line.startsWith("Trainers:")) {
        currentCategory = "trainers";
      } else if (line.startsWith("Energy:")) {
        currentCategory = "energy";
      } else if (currentCategory && line.trim()) {
        const match = line.match(/^(\d+)\s+(.+?)\s+([A-Z]{2,4})\s+(\d+)$/);
        if (match) {
          const [_, quantity, name, set, number] = match;
          yaml.cards[currentCategory].push({
            name: name.trim(),
            set: set.trim(),
            number: number.trim(),
            quantity: parseInt(quantity.trim(), 10)
          });
        }
      }
    });
  
    // Convert JavaScript object to YAML
    const yamlOutput = `
---
title: ${yaml.title}
layout: ${yaml.layout}
era: ${yaml.era}
description: ${yaml.description}
links:
${yaml.links.map(link => `  - href: ${link.href}\n    title: ${link.title}`).join("\n")}
cards:
  pokemon:
${yaml.cards.pokemon.map(card => `    - name: ${card.name}\n      set: ${card.set}\n      number: ${card.number}\n      quantity: ${card.quantity}`).join("\n")}
  trainers:
${yaml.cards.trainers.map(card => `    - name: ${card.name}\n      set: ${card.set}\n      number: ${card.number}\n      quantity: ${card.quantity}`).join("\n")}
  energy:
${yaml.cards.energy.map(card => `    - name: ${card.name}\n      set: ${card.set}\n      number: ${card.number}\n      quantity: ${card.quantity}`).join("\n")}
---
  `.trim();
  
    // Display YAML output
    document.getElementById("yamlOutput").textContent = yamlOutput;
  
    // Show the copy button
    document.getElementById("copyContainer").style.display = "flex";
  }

  function copyToClipboard() {
    const yamlOutput = document.getElementById("yamlOutput").textContent;
    navigator.clipboard.writeText(yamlOutput).then(() => {
      const feedback = document.getElementById("copyFeedback");
      feedback.style.display = "inline";
      setTimeout(() => (feedback.style.display = "none"), 2000);
    });
  }
</script>