# FrequenceMetre
#  Fréquencemètre Numérique sur FPGA (Nexys A7-100T)

Conception et implémentation en **VHDL** d'un fréquencemètre numérique sur la carte de développement **Digilent Nexys A7-100T** (Xilinx Artix-7), réalisé sous **Vivado**.

---

## Objectif du projet
Mesurer la fréquence $f_e$ d'un signal logique externe $V_e$ en comptant le nombre $N$ de périodes d'une horloge de référence $f_h$ pendant l'état haut (demi-période) du signal d'entrée :

$$f_e = \frac{f_h}{2N}$$

Le systeme intègre un sélecteur de calibre (manuel et/ou automatique) et affiche le résultat en temps réel sur les afficheurs 7 segments de la carte Nexys A7-100T.

---

##Architecture matérielle (Blocs VHDL)

Le système est découpé en modules hiérarchiques interconnectés dans un fichier `Top_Level` :

1. **Générateurs d'horloges de référence (`clock_dividers`)** : Division de l'horloge système 100 MHz de la Nexys A7 en 4 calibres ($F_1 = 50\text{ MHz}$, $F_2 = 5\text{ MHz}$, $F_3 = 500\text{ kHz}$, $F_4 = 50\text{ kHz}$).
2. **Sélecteur de fréquence (`freq_selector`)** : Multiplexeur 4 vers 1 permettant de choisir la fréquence de référence $f_h$ (mode manuel via interrupteurs `SW` ou mode automatique).
3. **Logique de comptage et fenêtre de mesure (`fenetres`)** : Synchronisation du signal d'entrée $f_e$ et génération séquentielle des commandes `reset_compteur`, `enable_compteur` et `latch_compteur`.
4. **Compteur BCD 4 chiffres (`compteurN`)** : Compteur décimal synchrone de `0000` à `9999` (Unités, Dizaines, Centaines, Milliers).
5. **Mémorisation & Affichage (`latch_data` + `binaire_7seg` + multiplexeur d'anodes)** : Verrouillage de la mesure stable en fin de fenêtre, transcodage BCD vers 7 segments et balayage temporel des afficheurs de la Nexys A7.

---

## Spécifications techniques & Plages de mesure

* **Carte cible** : Digilent Nexys A7-100T (`xc7a100tcsg324-1`)
* **Outil de synthèse / simulation** : Xilinx Vivado
* **Plage de comptage $N$** : `0` à `9999`
* **Plage globale mesurable** : $2,5\text{ Hz}$ à $25\text{ MHz}$

| Calibre | Fréquence de réf. ($f_h$) | Fréquence Min ($f_e$) | Fréquence Max ($f_e$) | Résolution théorique |
| :--- | :--- | :--- | :--- | :--- |
| **F1** | $50\text{ MHz}$ | $2\,500\text{ Hz}$ | $25\text{ MHz}$ | $2\,500\text{ Hz}$ |
| **F2** | $5\text{ MHz}$ | $250\text{ Hz}$ | $2,5\text{ MHz}$ | $250\text{ Hz}$ |
| **F3** | $500\text{ kHz}$ | $25\text{ Hz}$ | $250\text{ kHz}$ | $25\text{ Hz}$ |
| **F4** | $50\text{ kHz}$ | $2,5\text{ Hz}$ | $25\text{ kHz}$ | $2,5\text{ Hz}$ |

---

## Structure du dépôt

```text
├── src/                    # Fichiers sources VHDL (.vhd)
│   ├── clock_div.vhd       # Génération de F1, F2, F3, F4 à partir de 100 MHz
│   ├── fenetres.vhd        # Logique de fenêtre de mesure (reset, enable, latch)
│   ├── compteurN.vhd       # Compteur BCD 0 à 9999
│   ├── latch_data.vhd      # Registre de mémorisation 4 bits
│   ├── aff_7seg.vhd        # Transcodeur BCD -> 7 segments + multiplexage anodes
│   └── top_frequencemetre.vhd # Assemblage structurel
├── tb/                     # Bancs de test (Testbenches) Vivado
├── constraints/            # Fichier de contraintes Nexys-A7-100T-Master.xdc
└── docs/                   # Schémas blocs, chronogrammes et Compte Rendu

# Tree
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

31 directories
```
<!-- Tree End -->


My readme test

