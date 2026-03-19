<template>
  <div class="mvcc">

    <div class="two-col">

      <!-- LEFT: definitions -->
      <div class="defs">

        <div class="section-title">Chaque ligne stocke deux champs cachés</div>

        <!-- Tuple diagram -->
        <div class="tuple-wrap">
          <div class="tuple-label">tuple (ligne physique)</div>
          <div class="tuple-box">
            <div class="tuple-field xf">
              <span class="fname">xmin</span>
              <span class="fval">=&nbsp;9</span>
            </div>
            <div class="tuple-sep"></div>
            <div class="tuple-field xf">
              <span class="fname">xmax</span>
              <span class="fval">=&nbsp;null</span>
            </div>
            <div class="tuple-sep"></div>
            <div class="tuple-field">
              <span class="fname">solde</span>
              <span class="fval">=&nbsp;500</span>
            </div>
          </div>
          <div class="tuple-annot">
            <div class="annot-item" style="flex:0.8">
              <div class="annot-line"></div>
              <div class="annot-text">n° de la transaction<br>qui a <em>créé</em> cette version</div>
            </div>
            <div style="width:1px"></div>
            <div class="annot-item" style="flex:0.8">
              <div class="annot-line"></div>
              <div class="annot-text">n° de la transaction<br>qui l'a <em>remplacée</em><br><span class="annot-note">null = active</span></div>
            </div>
            <div style="width:1px"></div>
            <div style="flex:1"></div>
          </div>
        </div>

        <!-- After UPDATE -->
        <div class="section-title" style="margin-top: 0.7rem;">Après un UPDATE : deux versions coexistent</div>
        <div class="two-tuples">
          <div class="tuple-box faded-box">
            <div class="tuple-field xf"><span class="fname">xmin</span><span class="fval">=9</span></div>
            <div class="tuple-sep"></div>
            <div class="tuple-field xf"><span class="fname">xmax</span><span class="fval red">=11</span></div>
            <div class="tuple-sep"></div>
            <div class="tuple-field"><span class="fname">solde</span><span class="fval">=500</span></div>
          </div>
          <div class="dead-label">dead tuple</div>
          <div class="tuple-box active-box">
            <div class="tuple-field xf"><span class="fname">xmin</span><span class="fval red">=11</span></div>
            <div class="tuple-sep"></div>
            <div class="tuple-field xf"><span class="fname">xmax</span><span class="fval">=null</span></div>
            <div class="tuple-sep"></div>
            <div class="tuple-field"><span class="fname">solde</span><span class="fval">=400</span></div>
          </div>
          <div class="link-note">xmax=11 de v1 = xmin=11 de v2 → même transaction (T2)</div>
        </div>

      </div>

      <!-- RIGHT: static timeline -->
      <div class="tl-wrap">

        <div class="section-title">Ligne du temps — qui voit quoi ?</div>

        <div class="tl">

          <!-- Lids -->
          <div class="lids-col">
            <div class="lid ax-lid"></div>
            <div class="lid" style="color:#085041">T1<div class="txid">id=10</div></div>
            <div class="lid" style="color:#712B13">T2<div class="txid">id=11</div></div>
            <div class="lid" style="color:#085041">T3<div class="txid">id=12</div></div>
          </div>

          <!-- Tracks -->
          <div class="tracks-col">

            <!-- Axis -->
            <div class="track ax-track">
              <div class="ax-line"></div>
              <span class="ax-lbl">temps →</span>
            </div>

            <!-- T1 -->
            <div class="track">
              <div class="seg" style="background:#0F6E56; left:12%; width:60%"></div>
              <div class="ev ev-top" style="left:12%">
                <div class="ev-sql">BEGIN</div>
                <div class="dot" style="background:#0F6E56"></div>
              </div>
              <div class="ev ev-top" style="left:72%">
                <div class="ev-sql">SELECT solde<br><span class="res teal">→ 500</span></div>
                <div class="dot" style="background:#0F6E56"></div>
              </div>
            </div>

            <!-- T2 -->
            <div class="track">
              <div class="seg" style="background:#993C1D; left:35%; width:23%"></div>
              <div class="ev ev-bot" style="left:35%">
                <div class="dot" style="background:#993C1D"></div>
                <div class="ev-sql">UPDATE<br>solde=400</div>
              </div>
              <div class="ev ev-bot" style="left:58%">
                <div class="dot" style="background:#0F6E56"></div>
                <div class="ev-sql">COMMIT</div>
              </div>
            </div>

            <!-- T3 -->
            <div class="track">
              <div class="ev ev-top" style="left:85%">
                <div class="ev-sql">BEGIN<br>SELECT solde<br><span class="res teal">→ 400</span></div>
                <div class="dot" style="background:#0F6E56"></div>
              </div>
            </div>

          </div>
        </div>

        <!-- Who sees what -->
        <div class="sees">
          <div class="sees-row">
            <span class="sees-tx" style="color:#085041">T1</span>
            <span class="sees-arrow">→</span>
            <span class="sees-text">snapshot avant T2 · voit toujours <strong>v1</strong> (solde=500), même après le COMMIT de T2</span>
          </div>
          <div class="sees-row">
            <span class="sees-tx" style="color:#085041">T3</span>
            <span class="sees-arrow">→</span>
            <span class="sees-text">snapshot après COMMIT de T2 · voit <strong>v2</strong> (solde=400)</span>
          </div>
          <div class="sees-note">T1 et T3 lisent simultanément — aucun blocage</div>
        </div>

      </div>
    </div>

    <!-- VACUUM row -->
    <div class="vacuum-row">
      <div class="vacuum-title">Le coût : dead tuples</div>
      <div class="vacuum-items">
        <div class="vacuum-item">
          <span class="vi-icon">📦</span>
          <span>Chaque <code>UPDATE</code> / <code>DELETE</code> laisse l'ancienne version en place → <strong>table bloat</strong></span>
        </div>
        <div class="vacuum-item">
          <span class="vi-icon">🧹</span>
          <span><code>autovacuum</code> supprime les dead tuples dès qu'aucune transaction ne peut plus les voir</span>
        </div>
        <div class="vacuum-item warn">
          <span class="vi-icon">⚠</span>
          <span>Une <strong>transaction longue ouverte</strong> bloque le VACUUM → accumulation des dead tuples</span>
        </div>
      </div>
    </div>

  </div>
</template>

<script setup>
// Static component — no animation
</script>

<style scoped>
.mvcc {
  font-family: 'Roboto Mono', monospace;
  font-size: 0.62rem;
}

.two-col {
  display: grid;
  grid-template-columns: 1fr 1.5fr;
  gap: 1.2rem;
  align-items: start;
}

.section-title {
  font-size: 0.58rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: #aaa;
  margin-bottom: 0.4rem;
}

/* ── Tuple diagram ── */
.tuple-wrap { display: flex; flex-direction: column; gap: 0; }
.tuple-label {
  font-size: 0.52rem; color: #bbb;
  margin-bottom: 2px;
}

.tuple-box {
  display: flex;
  border: 1.5px solid #DA291C;
  border-radius: 5px;
  overflow: hidden;
  background: #FDF2F1;
}
.tuple-field {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 0.25rem 0.4rem;
  flex: 1;
}
.tuple-field.xf { flex: 0.8; }
.tuple-sep { width: 1px; background: #f0c8c5; }
.fname { font-size: 0.5rem; color: #DA291C; font-weight: 700; }
.fval  { font-size: 0.6rem; font-weight: 600; }
.fval.red { color: #DA291C; }

.tuple-annot {
  display: flex;
  margin-top: 4px;
}
.annot-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2px;
}
.annot-line {
  width: 1px; height: 10px;
  background: #ccc;
}
.annot-text {
  font-size: 0.5rem;
  color: #888;
  text-align: center;
  line-height: 1.3;
}
.annot-note { color: #bbb; }

/* Two-tuple after update */
.two-tuples {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}
.faded-box {
  border-color: #ccc !important;
  background: #f5f5f5 !important;
  opacity: 0.6;
}
.active-box {
  border-color: #0F6E56 !important;
  background: #E8F5F1 !important;
}
.active-box .fname { color: #0F6E56 !important; }
.dead-label {
  font-size: 0.48rem; color: #bbb;
  text-align: right; padding-right: 4px;
  margin-top: -2px;
}
.link-note {
  font-size: 0.5rem; color: #DA291C;
  margin-top: 0.15rem;
  line-height: 1.3;
}

/* ── Timeline ── */
.tl { display: flex; flex-direction: row; }

.lids-col {
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
}
.lid {
  width: 30px;
  height: 52px;
  font-size: 0.65rem;
  font-weight: 700;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  line-height: 1.1;
}
.ax-lid { height: 16px; }
.txid { font-size: 0.44rem; font-weight: 400; color: #aaa; }

.tracks-col {
  flex: 1;
  position: relative;
  display: flex;
  flex-direction: column;
}

.track { position: relative; height: 52px; }
.ax-track { height: 16px; }

.ax-line {
  position: absolute;
  left: 0; right: 0; top: 50%;
  height: 1px; background: #ccc;
}
.ax-lbl {
  position: absolute;
  right: 0; top: 50%;
  transform: translateY(-50%);
  font-size: 0.5rem; color: #bbb;
}

.seg {
  position: absolute;
  height: 1.5px;
  top: 50%;
  transform: translateY(-50%);
}

.ev {
  position: absolute;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2px;
  transform: translateX(-50%);
}
.ev-top { bottom: calc(50% - 4px); flex-direction: column; }
.ev-bot { top: calc(50% - 4px); flex-direction: column; }

.ev-sql { font-size: 0.52rem; text-align: center; line-height: 1.3; color: #333; white-space: nowrap; }
.res { font-weight: 700; }
.teal { color: #085041; }

.dot { width: 8px; height: 8px; border-radius: 50%; flex-shrink: 0; }

/* ── Who sees what ── */
.sees {
  margin-top: 0.5rem;
  display: flex;
  flex-direction: column;
  gap: 0.2rem;
  border-top: 1px solid #eee;
  padding-top: 0.4rem;
}
.sees-row { display: flex; align-items: baseline; gap: 0.3rem; font-size: 0.57rem; }
.sees-tx  { font-weight: 700; flex-shrink: 0; }
.sees-arrow { color: #ccc; flex-shrink: 0; }
.sees-text { color: #555; }
.sees-text strong { color: #333; }
.sees-note {
  font-size: 0.52rem;
  color: #DA291C;
  font-weight: 600;
  margin-top: 0.1rem;
}

/* ── VACUUM row ── */
.vacuum-row {
  border-top: 1px solid #eee;
  padding-top: 0.4rem;
  margin-top: 0.3rem;
}
.vacuum-title {
  font-size: 0.58rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: #aaa;
  margin-bottom: 0.3rem;
}
.vacuum-items {
  display: flex;
  gap: 1rem;
}
.vacuum-item {
  display: flex;
  align-items: baseline;
  gap: 0.35rem;
  font-size: 0.57rem;
  color: #555;
  flex: 1;
  line-height: 1.35;
}
.vacuum-item.warn { color: #993C1D; }
.vi-icon { font-size: 0.65rem; flex-shrink: 0; }
.vacuum-item code {
  font-family: 'Roboto Mono', monospace;
  font-size: 0.55rem;
  background: #f0f0f0;
  padding: 0 3px;
  border-radius: 2px;
}
</style>
