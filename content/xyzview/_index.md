---
title: "Molecular Visualizer"
date: 2025-06-29T12:00:00+10:00
draft: false
description: "A free, interactive online tool to visualize molecules from XYZ, SDF, or MOL coordinate data. Paste your data and instantly view a 3D model with support for multiple bonds."
---


### Visualize XYZ Coordinates 

Welcome to the Lab Initio Molecular Visualizer, a tool for students, educators, and computational chemists.

Paste your molecule's XYZ coordinates into the box below and click "Visualize".

<textarea id="xyz-input" rows="10" style="width: 100%; font-family: monospace; border: 4px solid #ccc; padding: 5px;"></textarea>
<button id="update-viewer-btn" style="padding: 10px 15px; margin-top: 10px; cursor: pointer;">Visualize</button>

<hr style="margin: 20px 0;">

<!-- CHANGE 1: Added a border to the style attribute -->
<div id="mol-viewer" style="height: 500px; width: 100%; position: relative; border: 4px solid #ccc;"></div>

<!-- This is the JavaScript that initializes and updates the viewer. -->
<script type="text/javascript">
  $(document).ready(function() {
    let element = $('#mol-viewer');
    // CHANGE 2: Changed backgroundColor to 'white'
    let config = { backgroundColor: 'white' };
    let viewer = $3Dmol.createViewer(element, config);

    // --- Define our desired style here ---
    let moleculeStyle = {
        stick: {
            multipleBonds: true,
            bond: 6 // Adjust spacing for multiple bonds
        }
    };

    // --- Initial molecule load (caffeine) ---
    let initial_molecule_url = '/molecules/capsaicin.xyz'; 
    jQuery.ajax(initial_molecule_url, {
      success: function(data) {
        $('#xyz-input').val(data);
        
        viewer.addModel(data, "xyz");
        viewer.setStyle({}, moleculeStyle); 
        viewer.zoomTo();
        viewer.render();
        viewer.zoom(1.2, 1000);
      },
      error: function(hdr, status, err) {
        console.error("Failed to load " + initial_molecule_url + ": " + err);
      },
    });

    // --- Add a click handler for the new button ---
    $('#update-viewer-btn').on('click', function() {
      let xyz_data = $('#xyz-input').val();

      if (xyz_data.trim() === '') {
        alert('Please paste XYZ data into the box before clicking Visualize.');
        return;
      }
      
      viewer.clear();
      viewer.addModel(xyz_data, "xyz");
      viewer.setStyle({}, moleculeStyle); 
      viewer.zoomTo();
      viewer.render();
    });
  });
</script>
