<template>
  <div class="root">

    <div class="two-col">

      <!-- LEFT: tuple box + annotations -->
      <div class="tuple-section">
        <div class="tuple-label">tuple (ligne physique)</div>
        <div class="tuple-box">
          <div class="tuple-field xf">
            <span class="fname">xmin</span>
            <span class="fval">= 9</span>
          </div>
          <div class="tuple-sep"></div>
          <div class="tuple-field xf">
            <span class="fname">xmax</span>
            <span class="fval">= null</span>
          </div>
          <div class="tuple-sep"></div>
          <div class="tuple-field">
            <span class="fname">solde</span>
            <span class="fval">= 500</span>
          </div>
        </div>
        <div class="tuple-annot">
          <div class="annot-item" style="flex:0.8">
            <div class="annot-line"></div>
            <div class="annot-text">n° de la transaction<br>qui a <em>créé</em> cette version<br><span class="annot-ex">ex : T2 si id=11</span></div>
          </div>
          <div style="width:1px"></div>
          <div class="annot-item" style="flex:0.8">
            <div class="annot-line"></div>
            <div class="annot-text">n° de la transaction<br>qui l'a <em>remplacée</em><br><span class="annot-note">null = encore active</span><br><span class="annot-ex">ex : T2 si id=11</span></div>
          </div>
          <div style="width:1px"></div>
          <div style="flex:1"></div>
        </div>
      </div>

      <!-- RIGHT: visibility rule + T1/T2/T3 examples -->
      <div class="rule-section">

        <div class="rule-label">Règle de visibilité</div>
        <div class="rule-box">
          T (id = <em>n</em>) voit une version si :<br>
          <code>xmin ≤ n</code> &nbsp;et&nbsp; <code>xmax = null &nbsp;ou&nbsp; n &lt; xmax</code>
        </div>

        <div class="tx-checks">
          <div class="tx-row">
            <span class="tx-badge teal">T1 <span class="txid">id=10</span></span>
            <span class="tx-expr">9 ≤ 10, xmax=null</span>
            <span class="tx-ok">→ visible ✓</span>
          </div>
          <div class="tx-row">
            <span class="tx-badge coral">T2 <span class="txid">id=11</span></span>
            <span class="tx-expr">9 ≤ 11, xmax=null</span>
            <span class="tx-ok">→ visible ✓ &nbsp;<span class="tx-note">(fait UPDATE)</span></span>
          </div>
          <div class="tx-row">
            <span class="tx-badge teal">T3 <span class="txid">id=12</span></span>
            <span class="tx-expr">9 ≤ 12, xmax=null</span>
            <span class="tx-ok">→ visible ✓</span>
          </div>
        </div>

      </div>

    </div>

  </div>
</template>

<script setup>
// Static component
</script>

<style scoped>
.root {
  font-family: 'Roboto Mono', monospace;
  font-size: 0.62rem;
}

.two-col {
  display: grid;
  grid-template-columns: 1fr 1.6fr;
  gap: 2rem;
  align-items: start;
}

/* ── Tuple ── */
.tuple-section { display: flex; flex-direction: column; gap: 0; }
.tuple-label { font-size: 0.52rem; color: #bbb; margin-bottom: 2px; }

.tuple-box {
  display: flex;
  border: 1.5px solid #DA291C;
  border-radius: 5px;
  overflow: hidden;
  background: #FDF2F1;
}
.tuple-field {
  display: flex; flex-direction: column; align-items: center;
  padding: 0.25rem 0.4rem; flex: 1;
}
.tuple-field.xf { flex: 0.8; }
.tuple-sep { width: 1px; background: #f0c8c5; }
.fname { font-size: 0.5rem; color: #DA291C; font-weight: 700; }
.fval  { font-size: 0.6rem; font-weight: 600; }

.tuple-annot { display: flex; margin-top: 4px; }
.annot-item  { display: flex; flex-direction: column; align-items: center; gap: 2px; }
.annot-line  { width: 1px; height: 10px; background: #ccc; }
.annot-text  { font-size: 0.5rem; color: #888; text-align: center; line-height: 1.3; }
.annot-note  { color: #bbb; }
.annot-ex    { color: #DA291C; font-style: normal; }

/* ── Rule ── */
.rule-section { display: flex; flex-direction: column; gap: 0.5rem; }
.rule-label {
  font-size: 0.52rem; font-weight: 700; text-transform: uppercase;
  letter-spacing: 0.05em; color: #aaa;
}
.rule-box {
  background: #f7f7f7; border-left: 2px solid #ccc;
  padding: 0.3rem 0.5rem; font-size: 0.57rem; color: #444;
  line-height: 1.6; border-radius: 0 4px 4px 0;
}
.rule-box code {
  font-family: 'Roboto Mono', monospace;
  background: #ececec; padding: 0 3px; border-radius: 2px;
  font-size: 0.55rem;
}

/* ── T checks ── */
.tx-checks { display: flex; flex-direction: column; gap: 0.25rem; }
.tx-row { display: flex; align-items: center; gap: 0.4rem; font-size: 0.57rem; }
.tx-badge {
  font-size: 0.55rem; font-weight: 700; padding: 1px 5px;
  border-radius: 3px; flex-shrink: 0; display: flex; align-items: center; gap: 3px;
}
.tx-badge.teal  { background: #E8F5F1; color: #0F6E56; }
.tx-badge.coral { background: #FDF2F1; color: #993C1D; }
.txid { font-size: 0.44rem; font-weight: 400; opacity: 0.8; }
.tx-expr { color: #666; }
.tx-ok   { color: #0F6E56; font-weight: 600; }
.tx-note { color: #aaa; font-weight: 400; }
</style>
