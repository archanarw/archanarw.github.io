---
layout: page
title: AutumnBench
description: Benchmark with 43 interactive environments and 129 tasks for evaluating AI agents' ability to learn and reason about world dynamics.
importance: 1
category: work
related_publications: [warrier2025benchmarking]
---

Created a representation-agnostic benchmark for evaluating world-model learning in AI agents, featuring 43 interactive grid-world environments with 129 tasks across masked-frame prediction, planning, and change detection. Evaluated 517 humans and frontier reasoning models, revealing substantial gaps in AI's world-modeling capabilities {% cite warrier2025benchmarking %}.

PS: The games are fun to play --- try them at [autumn.basis.ai](https://autumn.basis.ai)!

### Try it yourself

<div class="mb-4">
  <iframe src="https://autumn.basis.ai/task-selection?taskId=EPKHP&embedded=1" width="100%" height="594" frameborder="0" loading="lazy"></iframe>
  <p class="text-muted">Interactive task selector — play directly here.</p>
</div>

### Example human vs AI interactions

<div class="row">
  <div class="col-md-6">
    <h4>Human</h4>
    <iframe 
      src="https://autumn.basis.ai/visualize-interaction?embedded=1&session=buoyancy_example_human_interaction"
      width="100%" 
      height="600"
      frameborder="0"
      loading="lazy">
    </iframe>
    <!-- <p class="text-muted">Here is the human one</p> -->
  </div>
  <div class="col-md-6">
    <h4>Claude 4 Sonnet</h4>
    <iframe 
      src="https://autumn.basis.ai/visualize-interaction?embedded=1&session=claude-4-sonnet_mfp_buoyancy_actions_interface"
      width="100%" 
      height="600"
      frameborder="0"
      loading="lazy">
    </iframe>
    <!-- <p class="text-muted">This is Claude 4 Sonnet</p> -->
  </div>
  <div class="col-md-6">
    <h4>Gemini 2.5 Pro</h4>
    <iframe 
      src="https://autumn.basis.ai/visualize-interaction?embedded=1&session=gemini-2.5-pro_cd_buoyancy_actions_interface"
      width="100%" 
      height="600"
      frameborder="0"
      loading="lazy">
    </iframe>
    <!-- <p class="text-muted">This is Gemini 2.5 Pro</p> -->
  </div>
  <div class="col-md-6">
    <h4>o3</h4>
    <iframe 
      src="https://autumn.basis.ai/visualize-interaction?embedded=1&session=o3_mfp_buoyancy_actions_interface"
      width="100%" 
      height="600"
      frameborder="0"
      loading="lazy">
    </iframe>
    <!-- <p class="text-muted">This is o3</p> -->
  </div>
</div>

