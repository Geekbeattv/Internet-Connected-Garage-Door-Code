// Code by Geekbeat TV. Code is in Creative Commons. 
server.log("Garage Control: " + http.agenturl());

function requestHandler(request, response)  {

    try { // Try provides us with exception handling, in case a runtime error occurs

        // check if the user sent garage as a query parameter
        if ("garage" in request.query) {
            
            // convert the garage query parameter to an integer
            local garage = request.query.garage.tointeger();

            // send "toggleGarage" message to device, and send garage as the data
            device.send("toggleGarage", garage); 
        }
        
        // send an http response
        response.send(200, "OK");
    
    } 
    catch (ex) {
        // if there was an error send a response back with the error
        response.send(500, "Internal Server Error: " + ex);
    }
}

// Set up a handler for HTTP requests. This is the function that we defined above.
// https://electricimp.com/docs/api/http/onrequest/
http.onrequest(requestHandler);
