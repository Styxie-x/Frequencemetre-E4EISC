# Fréquencemètre Numérique sur FPGA (Nexys A7-100T)

Conception et implémentation en **VHDL** d'un fréquencemètre numérique multi-chiffres sur la carte de développement **Digilent Nexys A7-100T** (Xilinx Artix-7), réalisé sous **Vivado**.

---

## Objectif du projet
Mesurer en temps réel la fréquence d'un signal d'entrée (`freqin`) et afficher le résultat sur les **8 afficheurs 7 segments** de la carte Nexys A7-100T :
1. **Comptage BCD synchrone** sur 8 décades (`00000000` à `99999999`) pendant une fenêtre de mesure calibrée.
2. **Mémorisation (`data_latch`)** des chiffres en fin de fenêtre pour garantir un affichage stable sans scintillement.
3. **Multiplexage temporel (`display_mux` + `bcd_to_7seg`)** pour piloter les 8 anodes et les 7 cathodes de la carte.

---

## État d'avancement & Répartition

### Fait et validé (Code + Testbench + Waveform) — *Styxie-x*
* **`bcd0to9_counter.vhd` & `bcd_counter.vhd`** : Compteur BCD synchrone 8 chiffres en cascade (`unit` $\rightarrow$ `ten_million`), validé de `5 Hz` à `50 MHz` (`bcd_counter_tb`).
* **`data_latch.vhd`** : Registre de verrouillage des données BCD en fin de fenêtre de mesure (`data_latch_tb`).
* **`display_mux.vhd`** : Multiplexeur de balayage des 8 afficheurs 7 segments (`display_mux_tb`).
* **`bcd_to_7seg.vhd`** : Transcodeur BCD (4 bits) vers cathodes 7 segments (logique active à l'état bas).

### Codé, en attente de vérification — *ethangirard-hue*
* **`clk_div.vhd`** : Diviseur de l'horloge système `100 MHz` (génération des horloges de référence / balayage).
* **`freq_sel.vhd`** : Sélecteur de calibre / fenêtre de mesure.

---

## Feuille de route (Dans l'ordre d'exécution)

1. **Vérification des modules d'horloge et de sélection (*ethangirard-hue*)**
   * [ ] Relire et vérifier la syntaxe/logique de `clk_div.vhd` et `freq_sel.vhd`.
   * [ ] Créer les bancs de test (`clk_div_tb.vhd` et `freq_sel_tb.vhd`).
   * [ ] Lancer les simulations sous Vivado et valider les chronogrammes (**Waveforms**).
2. **Logique de fenêtre de mesure (`meas_window.vhd`)**
   * [ ] Finaliser le séquencement des signaux `meas_window` (`gate`), `latch` et `reset` (`clear`).
   * [ ] Simuler et valider le chronogramme de cycle complet (comptage $\rightarrow$ capture $\rightarrow$ remise à zéro).
3. **Assemblage global (`top_frequency_meter.vhd`)**
   * [ ] Interconnecter l'ensemble des blocs (`clk_div`, `freq_sel`, `meas_window`, `bcd_counter`, `data_latch`, `display_mux`, `bcd_to_7seg`).
   * [ ] Écrire un testbench global (`top_frequency_meter_tb.vhd`) et valider la chaîne complète en simulation.
4. **Implémentation matérielle sur Nexys A7-100T**
   * [ ] Configurer le fichier de contraintes `.xdc` (horloge `100 MHz`, broche d'entrée `freqin`, interrupteurs `SW`, anodes `AN[7:0]` et cathodes `CA..CG`).
   * [ ] Lancer la **Synthèse**, l'**Implémentation** et la génération du **Bitstream**, puis tester sur la carte physique.

---

## Architecture matérielle (Blocs VHDL)

```text
freqin ───────► ┌───────────────┐     ┌────────────┐     ┌─────────────┐     ┌─────────────┐
                │  bcd_counter  ├────►│ data_latch ├────►│ display_mux ├────►│ bcd_to_7seg ├──► CA..CG
meas_window ──► │  (8 digits)   │     └──────▲─────┘     └──────┬──────┘     └─────────────┘
reset ────────► └───────────────┘            │                  └────────────────────────────► AN[7:0]
                                             │
clk_100MHz ───► ┌─────────┐   ┌──────────┐   │
                │ clk_div ├──►│ freq_sel ├───┴──► meas_window (gate / latch / reset)
                └─────────┘   └──────────┘
```

---

## Spécifications techniques

* **Carte cible** : Digilent Nexys A7-100T (`xc7a100tcsg324-1`)
* **Horloge système** : `100 MHz`
* **Outil de synthèse & simulation** : Xilinx Vivado
* **Affichage** : 8 afficheurs 7 segments multiplexés (capacité jusqu'à `99 999 999 Hz`)

---

## Arborescence du dépôt

<!-- Tree Start -->
```bash
Frequencemetre-E4ESIC-
└── FrequenceMetre
    ├── FrequenceMetre.cache
    │   ├── compile_simlib
    │   │   ├── activehdl
    │   │   ├── modelsim
    │   │   ├── questa
    │   │   ├── riviera
    │   │   ├── vcs
    │   │   └── xcelium
    │   ├── sim
    │   ├── telemetry
    │   └── wt
    ├── FrequenceMetre.hw
    ├── FrequenceMetre.ip_user_files
    ├── FrequenceMetre.sim
    │   └── sim_1
    │       └── behav
    │           └── xsim
    │               └── xsim.dir
    │                   ├── bcd_counter_tb_behav
    │                   ├── data_latch_tb_behav
    │                   ├── display_mux_tb_behav
    │                   └── xil_defaultlib
    └── FrequenceMetre.srcs
        ├── sim_1
        │   └── new
        └── sources_1
            ├── bd
            │   └── design_1
            │       └── ui
            └── new

32 directories
```
<!-- Tree End -->
