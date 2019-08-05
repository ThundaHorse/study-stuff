-------------------------
      ExpressJS 
-------------------------  
Originally influenced by Sinatra(Ruby) 

2 Primary tasks when dealing with HTTP messages: 
 • Read URL fragments and request headers 
 • Write response headers and body 
** Understanding HTTP is crucial for having a clean, simple and RESTful interface between two endpoints 

ExpressJS provides a simple API for doing ^. The methods in the API are self-explanatory in most cases 
  On the way in 
    • req.body -> gets request body 
    • req.query -> gets query fragment of URL 
    • req.originalUrl
    • req.host -> reads the 'Host' header field 
    • req.accepts -> reads the acceptable MIME-types on the client side 
    • req.get OR req.header -> read any header field passed as argument 
  On the way out 
    • res.status -> set explicit status code 
    • res.set -> set specific response header 
    • res.send -> send HTML, JSON or an octet-stream 
    • res.sendFile -> transfer a file to the client 
    • res.render -> render an express view template 
    • res.redirect -> redirect to a different route. Audo adds default redirect of 302 

--------------------
   Ruby on Rails
--------------------
ActionController and ActionDispatch modules provide the API for handling request and repsonse messages 
  ActionController -> provides a high level API to read the request URL, render output and redirect to a different  
                      end-point. End-point(route) is handled as an action method. 
                   -> Most of the necessary context information inside an action-method is provided via 3 objects 
                      • request, repsonse, params 
          • params: gives access to the URL parameters and POST data 
          • request: contains information about the client, headers and URL 
          • response: used to set headers and status codes 
          • render: render views by expanding templates 
          • redirect_to: redirect to a different action-method or URL 

  ActionDispatch -> provides fine-grained access to the request/response messages, via the ActionDispatch::Request and 
                    ActionDispatch:Response classes. Exposes a set of query methods to check the type of request, (get?(), post?(), head?(), local?()). Request headers can be directly accessed via the request.headers() method. 
                 -> On response side, it provides methods to set cookies(), location=(), and status=(). You can also get  
                    body=() and bypass the Rails rendering system. 

-------------------- 
    JQuery Ajax 
--------------------
Because JQuery is primarily a client-side library, its Ajax API provides the opposite of a server-side framework. Allows you to read response messages and modify request messages. JQuery exposes a simple API via JQuery.ajax(settings): 

By passing a settings object with the beforeSend callback, we can modify the request headers. The callback receives the jqXHR(JQuery XMLHttpRequst) object that exposes a method, called setRequestHeader() to set headers. 

  $.ajax({
    url: 'http://www.blah.com/yeet',
    type: 'GET', 
    beforeSend: function(jqXHR) {
      jqXHR.setRequestHeader('Accepts-Language', 'en-US,en'); 
    }
  }); 

  • The jqXHR object can also be used to read the response headers with the jqXHR.getResponseHeader() 
  • If you want to take specific actions for various status codes, you can use the statusCode callback: 

  $.ajax({
    statusCode: {
      404: function(){
        alert("page not found"); 
      }
    }
  }); 
