/****************************** HTML ******************************/
const html = @"
<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Garage Door</title>
    
    <link rel='stylesheet' href='https://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css'>
  </head>
  <body>
    <div class='container col-xs-12 col-sm-4 col-sm-offset-4 text-center'>
      <h1>Garage Door Controller</h1>
      <div class='well'>
          <button type='button' class='btn btn-default' onclick='toggleGarage(0);'>Garage 1</button>
          <button type='button' class='btn btn-default' onclick='toggleGarage(1);'>Garage 2</button>
          
        <input type='password' class='form-control' style='margin-top:15px; text-align:center;' id='pw' placeholder='Password'>
      </div>
      <div class='text-left'>
        <h2>Log:</h2>
        <div id='logs'></div>
      </div>
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js'></script>
    <script src='https://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js'></script>
    <script>
        function toggleGarage(s) {
            var pw = $('#pw').val();
            var url = document.URL + '?pw=' + pw + '&garage=' + s;
            if (pw) {
                $.get(url)
                    .done(function(data) {
                        $('#logs').prepend('<span style=\'color: green;\'>' + new Date().toLocaleString() + '</span><span> - Toggled Garage ' + (parseInt(s)+1) + '</span><br />');
                    })
                    .fail(function(data) {
                        $('#logs').prepend('<span style=\'color: red;\'>' + new Date().toLocaleString() + '</span><span> - ' + data.responseText  + '</span><br />');
                    });
            } else {
                $('#logs').prepend('<span style=\'color: red;\'>' + new Date().toLocaleString() + '</span><span> - Missing Password.</span><br />');
            }
        }
    </script>
  </body>
</html>
";

/****************************** HTTP Handler ******************************/

const PASSWORD = "yourpassword"

function requestHandler(request, response)  {

    try { // Try provides us with exception handling, in case a runtime error occurs

		// if they passed garage as a query parameter
        if ("garage" in request.query) {
            
            /////////////////////////
            // add the ajax header //
            /////////////////////////
            response.header("Access-Control-Allow-Origin", "*");

            ////////////////////////
            // Check the password //
            ////////////////////////
            // password variable
            local pw = null;
            
            // if they passed a password
            if ("pw" in request.query) {
                // grab the pw parameter
                pw = request.query["pw"];
            }
    
            // if the password was wrong
            if (pw != PASSWORD) {
                // send back an angry message
                response.send(401, "UNAUTHORIZED");
                return;
            }
            
			////////////////////////////////
	        // check the garage parameter //
    	    ////////////////////////////////

            // convert the garage query parameter to an integer
            local garage = request.query.garage.tointeger();

            // send "toggleGarage" message to device, and send garage as the data
            device.send("toggleGarage", garage); 
            
            // send an http response
            response.send(200, "OK");
        } 
        
        ////////////////////////////////////////////
        // send html if no garage query parameter //
        ////////////////////////////////////////////
        else {
            response.send(200, html);
        }
    
    }  
    catch (ex) {
        // if there was an error send a response back with the error
        response.send(500, "Internal Server Error: " + ex);
    }
}

// Code by Geekbeat TV. Code is in Creative Commons. 
server.log("Garage Control: " + http.agenturl());

// Set up a handler for HTTP requests. This is the function that we defined above.
// https://electricimp.com/docs/api/http/onrequest/
http.onrequest(requestHandler);
// Set up a handler for HTTP requests. This is the function that we defined above.
// https://electricimp.com/docs/api/http/onrequest/
http.onrequest(requestHandler);
