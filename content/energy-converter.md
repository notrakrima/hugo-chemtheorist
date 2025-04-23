---
# title: "Energy Unit Converter"
date: 2025-04-23
draft: false
slug: energy
---

<h2 class="converter-title">Energy Unit Converter</h2>
<p class="converter-subtitle">Based on latest CODATA fundamental constants</p>

<form name="EnergyConverterForm" class="energy-converter-form">
    <div class="converter-row">
        <input type="text" name="H" id="conv-h" onChange="displayInfo(this.form,this.name);">
        <label for="conv-h">Hartree</label>
    </div>
    <div class="converter-row">
        <input type="text" name="eV" id="conv-ev" value="" onChange="displayInfo(this.form,this.name);">
        <label for="conv-ev">eV</label>
    </div>
    <div class="converter-row">
        <input type="text" name="kJ/mol" id="conv-kjmol" value="" onChange="displayInfo(this.form,this.name);">
        <label for="conv-kjmol">kJ mol<sup>-1</sup></label>
    </div>
    <div class="converter-row">
        <input type="text" name="kcal/mol" id="conv-kcalmol" value="" onChange="displayInfo(this.form,this.name);">
        <label for="conv-kcalmol">kcal mol<sup>-1</sup></label>
    </div>
    <div class="converter-row">
        <input type="text" name="cm-1" id="conv-cm1" value="" onChange="displayInfo(this.form,this.name);">
        <label for="conv-cm1">cm<sup>-1</sup></label>
    </div>
    <div class="converter-row">
        <input type="text" name="K" id="conv-k" value="" onChange="displayInfo(this.form,this.name);">
        <label for="conv-k">K</label>
    </div>
</form>

<script src="/js/energy-converter.js"></script>

