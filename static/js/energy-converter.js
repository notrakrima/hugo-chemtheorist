// DEFINE METHODS
function constants(conv) {
    // Based on the following constants from CODATA
    // Eh	4.3597447222060E-21
    // NA	6.0221407600000E+23
    // c	2.9979245800000E+08
    // h	6.6260701500000E-34
    // kb	1.3806490000000E-23

    // Number of energy fields (Hartree, eV, kJ/mol, kcal/mol, cm-1, K)
    var numE = 6;
          conv[0] = 1.00000000000000 ; // Hartrees
          conv[1] = 27.2113862459810 ; // eV
          conv[2] = 2625.49963947916 ; // kJ/mol
          conv[3] = conv[2]/4.184 ; // kcal/mol
          conv[4] = 219474.631363141 ; // cm-1
          conv[5] = 315775.024803987 ; // K
          return numE;
}

function displayInfo(form, fieldName) {
   var idx;
   // find field index based on the input element's name
   for (var i = 0; i < nfields; i++) { // Loop up to nfields (which is 6)
       if (form.elements[i] && form.elements[i].name && form.elements[i].name == fieldName) {
           idx = i ;
           break;
       }
   }

   if (typeof idx === 'undefined') {
       console.error("Could not find field index for:", fieldName);
       return;
   }

   // Get the input value and convert to a number
   var inputValue = parseFloat(form.elements[idx].value);
   if (isNaN(inputValue)) {
       energy = 0;
       inputValue = 0; // Treat invalid input as 0
   }

   // calculate the base energy in Hartrees
   energy = (conv[idx] !== 0) ? inputValue / conv[idx] : 0;

   // convert to other units
   for (var i = 0; i < nfields; i++) {
       if ( i != idx ) { // Don't update the field that was just changed
           if (form.elements[i]) {
                // Use formatToDecimalPlaces instead of trunc
                form.elements[i].value = formatToDecimalPlaces(energy * conv[i], 12) ;
           }
       }
   }
}

// Function to format a number to a fixed number of decimal places
function formatToDecimalPlaces(num, places) {
    if (isNaN(num)) {
        return "NaN"; // Or handle as appropriate
    }
    if (!isFinite(num)) {
        return num.toString(); // Handle Infinity/-Infinity
    }
    // Use toFixed() which handles rounding and decimal places directly
    return num.toFixed(places);
}


// --- MAIN SCRIPT EXECUTION ---

// Global variable declarations
var energy = 0.000; // Stores the current energy value in Hartrees
var conv = new Array(); // Array to hold conversion factors
var nfields = constants(conv); // Initialize conversion factors and get the number of fields (should be 6 now)

document.addEventListener('DOMContentLoaded', function() {
    var energyForm = document.forms["EnergyConverterForm"];
    if (energyForm && energyForm.H) {
        displayInfo(energyForm, energyForm.H.name);
    } else {
        console.warn("Initial energy form 'EnergyConverterForm' or field 'H' not found on DOMContentLoaded.");
    }
});
