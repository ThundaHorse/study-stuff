---------------
# Front End 
---------------
- Generally, part of website that user interacts with 
    + CSS, HTML, JS, dropdown menus, sliders, etc. 
- Usually will use HTML, CSS, JS/other JS libraries 
    + Angular, JQuery etc., Ajax 
- _Front end_ is resonsible for _interior design_ or a house that's been built by back-end 


--------------
# Back End 
--------------
- Consists of server, application, and DB
    + Builds and maintains tech that powers components enable user-facing content 
    + Tools: MySQL, Oracle, Ruby, Python, Java, .Net, etc 
- Usually create or contribute to web apps with clean/efficient code 

# How it translates??
- When you go to a webtiste, a request is sent to the back-end, which in turn updates the user view according to what type of request it is. 
- Back end Storing information and such is also back end, credentials, data calling is attributable to back end 


-------------------------------
# How do they work together?
-------------------------------
_MVC_ is crucial. Model, View, Controller 
In some contexts, the front-end is the View
    • What user sees 

The back-end is the controller 
    • What does the work/updating view 

The database or data storage is model 
    • What stores the info for later 

The view can have many forms, but usually it's HTML, JS, and CSS 
    • A view or partial can be integrated into frameworks (as ERB in Rails or Django in Django) 
        - Can also be written with front-end JS framworks like Angular 

What does this mean? Where a view is integrated with the framwork, as request is made to back-end, what's returned as HTML has been pre-rendered by back-end engine 
    - May or may not use values from controller 

-------------------------------
# How do they talk to eachother?
-------------------------------
                                    Front 
                        -------------------------------
The front-end _always_ makes a call (GET/POST) requests. Call can even be made by user clicking on a link. 

A call is made from front to back through user interaction with page, listening to an event in JS, or using JS as a timed event. 

So...

Will they by synchronous or asynchronous? 

Synchronous: user makes request and waits for response. 

Asynchroous: request is made in background and page are updated when response from request is received. 
    ^ All done through XML HTTP Requests (XHR)

                                    Back
                        ------------------------------- 
What happens once back-end receives a call from front-end? 
Back-end receives a call from front and dissects the request classifying it: 
    1. Type of request 
    2. The domain 
    3. The port
    4. The endpoint is 'xxxx' 

Then it takes the info to 'route' to request, passing the request body as well. The server takes the info and passes on info through the gateway (if known and resources are present) 

When the app receives the call, it routes the request to the controller, the controller does the 'logic'    
    - Communicating with DB or a calc or whatever. 

# What does the back end return? 
- XML, JSON, or HTML usually 
    + A single method can return any one of the 3 depending on how the request was made 
        * This is what `respons_to` does in Rails when dealing with asynchronous requests 
        * Render and redirect are statements used in Rails to render a view or redirect to another action 
When a front-end is integrated as a template, we may be returning a view in which case we pass on values to that view 

The back-end engine renders it as HTML and is returned to teh consumer 

When asynchronous requests are made, controller must return XML/HTML/JSON depending on how front-end will receive and interpret results. 

Good Example!: 
When front end makes a long-running request (like a large db query), consumer doesn't want to wait to get the request, browser would more thanl likely time out. 

SO 

Request would be made asynchronously, either user could remain on page and wait for an update, in which case back-end returns a block of HTML or JSON 

OR 

Timer could be set on front-end to listen for such event, checking back periodically 


# What does the front end do with the data? 
* When making synchronous requests, it renders the data -> shows a whole page
* When making asynchronous request -> front-end decides what to do with the results, may take those results and render them to a page in particular spot. 
    - It can pretty much do anything as a result of or using response from back-end 