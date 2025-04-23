// DEFINE METHODS
const displayPrecision = {
    hartree: 8,
    ev: 8,
    kjmol: 4,
    kcalmol: 4,
    cm: 3,
    k: 3
};

// Map field indices (0-5) to the keys used in displayPrecision
const fieldKeys = ['hartree', 'ev', 'kjmol', 'kcalmol', 'cm', 'k'];

function constants(conv) {
    // Based on the following constants from CODATA
    // Eh	4.3597447222060E-21
    // NA	6.0221407600000E+23
    // c	2.9979245800000E+08
    // h	6.6260701500000E-34
    // kb	1.3806490000000E-23

    // Number of energy fields (Hartree, eV, kJ/mol, kcal/mol, cm-1, K)
    var numE = 6;
          conv[0] = 1.00000000000000 ; // Hartree
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
   // Ensure nfields is correctly defined and accessible here (it should be from the global scope)
   for (var i = 0; i < nfields; i++) {
       // Assuming form elements correspond directly to indices 0 to nfields-1
       // And that element names match the keys in displayPrecision (e.g., name="hartree", name="ev")
       // A safer way might be to rely on the index 'i' directly if element order is guaranteed
       if (form.elements[i] && form.elements[i].name && form.elements[i].name == fieldName) {
           idx = i ;
           break;
       }
   }

   if (typeof idx === 'undefined') {
       // Fallback if name matching fails but order is known (less robust)
       for (var i = 0; i < nfields; i++) {
           if (form.elements[i] === document.activeElement) { // Check if it's the currently focused element
               idx = i;
               break;
           }
       }
       if (typeof idx === 'undefined') {
            console.error("Could not find field index for:", fieldName);
            return;
       }
   }


   // Get the input value and convert to a number
   var inputValue = parseFloat(form.elements[idx].value);
   if (isNaN(inputValue)) {
       // Clear other fields if input is invalid
       for (var i = 0; i < nfields; i++) {
           if (i !== idx && form.elements[i]) {
               form.elements[i].value = "";
           }
       }
       return; // Stop calculation
   }

   // calculate the base energy in Hartree
   // Ensure conv[idx] is not zero to avoid division by zero
   energy = (conv[idx] && conv[idx] !== 0) ? inputValue / conv[idx] : 0;

   // convert to other units and apply specific precision
   for (var i = 0; i < nfields; i++) {
       if ( i != idx ) { // Don't update the field that was just changed
           if (form.elements[i]) {
                const key = fieldKeys[i]; // Get the key ('hartree', 'ev', etc.) for this index
                const precision = displayPrecision[key]; // Get the desired precision from the object
                const calculatedValue = energy * conv[i]; // Calculate the value

                // Apply .toFixed() with the specific precision for this field
                form.elements[i].value = calculatedValue.toFixed(precision);
           }
       }
   }
}

// REMOVE THIS FUNCTION - it's no longer needed
// function formatToDecimalPlaces(num, places) { ... }


// --- MAIN SCRIPT EXECUTION ---

// Global variable declarations
var energy = 0.000; // Stores the current energy value in Hartree
var conv = new Array(); // Array to hold conversion factors
var nfields = constants(conv); // Initialize conversion factors and get the number of fields

document.addEventListener('DOMContentLoaded', function() {
    var energyForm = document.forms["EnergyConverterForm"];
    if (energyForm) {
        // Initial value setting logic removed

        fieldKeys.forEach(key => {
            const element = energyForm.elements[key];
            if (element) {
                element.addEventListener('input', function() {
                    displayInfo(energyForm, this.name);
                });
            }
        });

    } else {
        console.warn("Energy form 'EnergyConverterForm' not found on DOMContentLoaded.");
    }
});
