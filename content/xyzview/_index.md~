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
<button id="toggle-labels-btn" style="padding: 10px 15px; margin-top: 10px; cursor: pointer;" disabled>Show Atom Numbers</button>

<hr style="margin: 20px 0;">

<div id="mol-viewer" style="height: 500px; width: 100%; position: relative; border: 4px solid #ccc;"></div>

<!-- This is the JavaScript that initializes and updates the viewer. -->
<script type="text/javascript">
  $(document).ready(function() {
    let element = $('#mol-viewer');
    let config = { backgroundColor: 'white' };
    let viewer = $3Dmol.createViewer(element, config);
    let labelsVisible = false;

    function loadMolecule(data) {
        viewer.clear();
        viewer.addModel(data, "xyz");
        viewer.setStyle({}, { stick: {} });
        viewer.zoomTo();
        viewer.render();
        viewer.zoom(1.2, 1000);
        labelsVisible = false;
        $('#toggle-labels-btn').text('Show Atom Numbers').prop('disabled', false);
    }

    // --- Initial molecule load ---
    let initial_molecule_url = '/molecules/capsaicin.xyz'; 
    jQuery.ajax(initial_molecule_url, {
      success: function(data) {
        $('#xyz-input').val(data);
        loadMolecule(data);
      },
      error: function(hdr, status, err) {
        console.error("Failed to load " + initial_molecule_url + ": " + err);
      },
    });

    // --- Click handler for the "Visualize" button ---
    $('#update-viewer-btn').on('click', function() {
      let xyz_data = $('#xyz-input').val();
      if (xyz_data.trim() === '') {
        alert('Please paste molecule data into the box before clicking Visualize.');
        return;
      }
      loadMolecule(xyz_data);
    });

    // --- DEFINITIVE WORKING Click handler ---
    $('#toggle-labels-btn').on('click', function() {
        if (labelsVisible) {
            // The most reliable way to remove labels is to redraw the molecule
            let current_data = $('#xyz-input').val();
            loadMolecule(current_data);
        } else {
            // Get the model and its atoms manually
            let model = viewer.getModel(0);
            if (model) {
                let atoms = model.selectedAtoms({}); // Get all atoms
                
                // Manually loop through each atom and add a label
                for (let i = 0; i < atoms.length; i++) {
                    let atom = atoms[i];
                    viewer.addLabel((atom.index + 1).toString(), { 
                        position: { x: atom.x, y: atom.y, z: atom.z },
                        fontColor: 'black',
                        backgroundColor: 'lightgray',
                        backgroundOpacity: 0.7
                    });
                }
            }
            viewer.render();
            $(this).text('Hide Atom Numbers');
            labelsVisible = true;
        }
    });
  });
</script>
