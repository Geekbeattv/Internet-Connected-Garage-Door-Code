// Code by Lewis Callaway for Geekbeat TV. Code is in Creative Commons. 
imp.configure("Garage Control", [], []); // Configure the imp

///////////////
// Pin Setup //
///////////////
// Setup reference variables for our pins:
garage1Pin <- hardware.pin5;  // Garage1
garage2Pin <- hardware.pin9;   // Garage2

// Configure our pins:
garage1Pin.configure(DIGITAL_OUT);        
garage2Pin.configure(DIGITAL_OUT);        


/////////////////////////////////
// Agent Function Declarations //
/////////////////////////////////.
// This function will be called by the agent.
function setGarage1(garage1State) 
{
   garage1Pin.write(garage1State);
}

function setGarage2(garage2State) 
{
    garage2Pin.write(garage2State);
}



///////////////////////////////////
// Important Agent Handler Stuff //
///////////////////////////////////
// Each object that the agent can send us needs a handler, which we define with
// the agent.on function.  The first parameter in agent.on is an identifier 
// string which must be matched by the sending agent. The second parameter is
// the name of a function to be called. These functions are already defined up
// above.
agent.on("garage1", setGarage1);
agent.on("garage2", setGarage2);

//////////////////////
// Helper Functions //
//////////////////////

// ledsOff just turns all LEDs off.
function garagesOff()
{
    garage1Pin.write(0);
    garage2Pin.write(0);
}
