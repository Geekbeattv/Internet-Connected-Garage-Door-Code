server.log("Garage Control" + http.agenturl());


function requestHandler(request, response)  {

    try { // Try provides us with exception handling, in case a runtime error occurs

        // check if the user sent led as a query parameter
        if ("garage1" in request.query) {
            // if they did, and led=1.. set our variable to 1
            if ((request.query.garage1 == "1") || (request.query.garage1 == "0"))
            {
                // convert the led query parameter to an integer
                local garage1Status = request.query.garage1.tointeger();

                // send "led" message to device, and send ledState as the data
                device.send("garage1", garage1Status); 
            }
        }
         // check if the user sent led as a query parameter
        if ("garage2" in request.query) {
            // if they did, and led=1.. set our variable to 1
            if ((request.query.garage2 == "1") || (request.query.garage2 == "0"))
            {
                // convert the led query parameter to an integer
                local garage2Status = request.query.garage2.tointeger();

                // send "led" message to device, and send ledState as the data
                device.send("garage2", garage2Status); 
            }
        }
       
    
    response.send(200, "OK");
    } 
    catch (ex) {
        response.send(500, "Internal Server Error: " + ex);
    }
}

// Set up a handler for HTTP requests. This is the function that we defined above.
// https://electricimp.com/docs/api/http/onrequest/
http.onrequest(requestHandler);
