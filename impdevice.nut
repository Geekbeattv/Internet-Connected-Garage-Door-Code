// Code by Lewis Callaway for Geekbeat TV. Code is in Creative Commons. 

///////////////
// Pin Setup //
///////////////
// Setup reference variables for our pins:
garages <- [ hardware.pin5, hardware.pin9 ];

// Configure our pins:
foreach(garage in garages) {
    garage.configure(DIGITAL_OUT, 0);
}

/////////////////////////////////
// Agent Function Declarations //
/////////////////////////////////.
// This function will be called by the agent.
function toggleGarage(garage) 
{
    // make sure it's a garage that exists:
    if (garage < 0 || garage > garages.len()) return;
    
    // set pin high, then low again in 1 second
    garages[garage].write(1);
    imp.wakeup(1.0, function() { garages[garage].write(0); });
}


///////////////////////////////////
// Important Agent Handler Stuff //
///////////////////////////////////
// Each object that the agent can send us needs a handler, which we define with
// the agent.on function.  The first parameter in agent.on is an identifier 
// string which must be matched by the sending agent. The second parameter is
// the name of a function to be called. These functions are already defined up
// above.
agent.on("toggleGarage", toggleGarage);

//////////////////////
// Helper Functions //
//////////////////////

// ledsOff just turns all LEDs off.
function garagesOff()
{
    foreach(garage in garages) {
        garages[garage].write(0);
    }
}
