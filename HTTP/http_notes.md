------------------------------
            HTTP 
------------------------------
Allows for communication between a variety of hosts and clients and supports a mixture of network configs 
  -> It assumes very little about a particular system and doesnt keep state between different message exchanges 
  -> Thus HTTP is a stateless protocol. Usually takes place over TCP/IP, but any reliable transport can be used. 

Communications between host and client occurs via request/response pair 
  -> client initiates an HTTP request message, serviced through a HTTP response message in return 


------------------------------
            URL 
------------------------------
At the heart of web comms, is the request message, sent via Uniform Resource Locator (URL) 
  http://www.something.com:1234/path/to/resource?a=b&x=y 
  | 1 |        2          | 3 |       4         |   5  |

    1 -> protocol 
    2 -> host 
    3 -> port 
    4 -> resource path 
    5 -> query 

  * https is used for secure communications 


------------------------------
            Verbs 
------------------------------
URLs reveal identity of particular host with which we want to communicat, the action that should be performed on the host is specified via HTTP verbs 
  • GET: fetch an existing resource. The URL contains all the necessary information the server needs to locate and return the resource. 
  • POST: creates a new resouce. POST requests usually carry a payload that specifies the data for the new resource. 
  • PUT: update an existing resource. The payload may contain the updated data for the resource. 
  • DELTE: deltes an existing resource. 

    -> PUT and DELETE are sometimes considered specialized versions of POST verb 
      -> they may be packaged as POST requests with the payload containing the exact action: create, update or delete 

  • HEAD: similar to GET, but without message body. Used to retrieve server headers for particular resource.
      -> generally to check if the resource has changed, via timestamps 
  • TRACE: used to retrieve the hops that a request takes to round trip from the server 
      -> Each intermediate proxy or gateway would inject its IP or DNS name into the Via header field. 
  • OPTIONS: used to retrieve server capabilities. 
      -> On client-side: can be used to modify the request based on what server can support. 


------------------------------
      Status Codes 
------------------------------
With URLs and verbs, client can initiate requests to the server. In return, the server responds with status codes and message payloads. the status code tells client how to inpterpret the server response. HTTP spec defines certin number ranges for specific types of responses: 
  1xx: Informational messages 
    • This class is purely provisional, server can send a 'Expect:100-continue' message which tells client to continue sending remainder of the 
      request or ignore it if already sent 

  2xx: Successful 
    • Tells the client that the request was successfully processed. 
    • For a 'GET' request, the server sends the resource in the message body. 
      => 202 = Accepted, request was accpeted but may not include resource in response. Useful for async processessing on server side. 
      => 204 = No content: there is no message body in the response 
      => 205 = Reset Content: indicates to client to reset its document view. 
      => 206 = Partial content: indicates that the response only contains partial content. Additional headers indicate exact range and content 
              expiry information 

  3xx: Redirection 
    • Requires the clien to take additional action. Most common use-case is to jump to a different URL in order to fetch the resource. 
      => 301 = Moved permanently: resource is now located at a new URL 
      => 303 = See Other: resource is temporarily located at a new URL. Location response header contains the temporary URL. 
      => 304 = Not Modified: server has determined that the resource has not changed and the client should used a cached copy. This relies on   
               the fact that the client is sending ETag(entitty tag) to check for modifications 

  4xx: Client Error 
    • Used when the server thinks that the client is at fault. YOUR FAULT 
      => 400 = Bad Request: the request was malformed 
      => 401 = Unauthorized: request requires authentication. Client can repeat the request with the 'Authorization'  
               header. If client already included the 'Authorization' header, creidentials were wrong 
      => 403 = Forbidden: server has denied access to the resource 
      => 405 = Method not allowed: invalid HTTP verb used in the request line, or server does not support that verb 
      => 409 = Conflict: server could not complete the request because client is typing to modify a resource that is newer 
               than the client's timestamp. 
          -> Conflicts usually arise motly for 'PUT' requests during collaborative edits on a resource. 

  5xx: Server Error 
    • Used to indicate a server failure while processing the request. Most common is 500 internal server error 
      => 501 = Not Implemented: server does not yet support the requested functionality 
      => 503 = Service Unavailable: could happen if an internal system on the server has failed or the server is 
               overloaded. Typically server wont even respond 

------------------------------------------------------------
          Request and Response Message Formats 
------------------------------------------------------------
HTTP specification states that a request or response message has the following generic structure 

  message = <start-line> 
            *(<message-header>)
            CRLF 
            [<message-body>] 

  <start-line> = Request-Line | Status-Line 
  <message-header> = Field-Name ':' Field-Value 

It's mandatory to place a new line between message headers and body. Message can contain one or more headers: 
  - general headers: applicable for both request and response messages 
  - request/response specific headers 
  - entity headers 

Message body may contain complete entity data, or may be piecemeal if the chunked encoding 
(Transfer-Encoding: chunked) is used. All HTTP/1.1 clients are required to accept the Transer-Encoding header. 

--------------------
  General Headers 
--------------------
Few headers(gen) that are shared by both request/response 
  general-header = Cache-Control 
                  | Connection 
                  | Date -> used to switch protocals and allow a smooth transition to a newer protocol 
                  | Pragma -> considered a custom header and may be used to include implementation-specific headers. 
                      * Most commin: Pragma: no-cache, actually -> Cache-Control: no-cache under HTTP/1.1
                  | Trailer 
                  | Transfer-Encoding -> used to break the response into smaller parts with Transfer-Encoding: chunked 
                      * New header in 1.1, allows for streaming of response to client instead of one big payload  
                  | Upgrade 
                  | Via -> used in a 'TRACE' message and updated by all intermittent proxies and gateways
                  | Warning 

--------------------
   Entity Headers 
--------------------
R.R messages may include entity to provide meta-information about the content (AKA Message Body or Entity) 
  entity-header = Allow 
                  | Content-Encoding 
                  | Content- Language 
                  | Content- Length 
                  | Content- Location 
                  | Content- MD5 
                  | Content- Range 
                  | Content- Type 
                  | Expires -> indicates a timestamp of when the entity expires. 
                      * 'never expires' is actually a timestamp of 1 year in the future
                  | Last-Modified -> indicates the last modification timestamp for the entity 

  All of the 'Content-' headers provide information about the structure, encoding and size of the message body. 
    Some need to be present if the entity is part of the message 
  Custom headers can also be created and sent by the client; they will be treated as entity headers by the HTTP protocol 

--------------------
   Request Format 
--------------------  
Has same generic structure as Entity
  SP is the space separator between tokens. HTTP-Version is specified as 'HTT/1.1' and followed by a new line. 

  Request-Line = Method SP URI SP HTTP-Version CRLF 
  Method = "OPTIONS" 
    | "HEAD"
    | "GET" -> do not have a message body 
    | "POST" -> can contain the post data in the body 
    | "PUT"
    | "DELETE"
    | "TRACE"

  Typical request message might look like this: 

  GET /articles/http-basics HTTP/1.1 
  Host: www.blah.com 
  Connection: keep-alive 
  Cache-Control: no-cache 
  Pragma: no-cache 
  Accept: text/htmp,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8 

  ^ The request line followed by many request headers. the 'Host' header is mandatory for HTTP/1.1 

The request headers act as modifiers of the request message. Unknown headers are treated as entity-header fields. 
  'Accept' headers indicate acceptable media-types, langauges and character sets on the client 
  request-header = Accept 
    | Accept-Charset 
    | Accept - Encoding 
    | Accept - Language 
    | Authorization 
    | Expect 
    | From           -> idenfity details about the client that initiated the request.    
    | Host           -> idenfity details about the client that initiated the request.    
    | If-Match            -> are used to make a request more conditional, otherwise 304 Not Modified, can be based on 
                             timestamp or an ETag (hash of the entity) 
    | If-Modified-Since   -> are used to make a request more conditional, otherwise 304 Not Modified, can be based on 
                             timestamp or an ETag (hash of the entity) 
    | If-Range            -> are used to make a request more conditional, otherwise 304 Not Modified, can be based on 
                             timestamp or an ETag (hash of the entity) 
    | If-Unmodified-Since -> are used to make a request more conditional, otherwise 304 Not Modified, can be based on 
                             timestamp or an ETag (hash of the entity) 
    | Max-Forwards
    | Proxy-Authorization 
    | Range 
    | Referer        -> idenfity details about the client that initiated the request.      
    | TE
    | User-Agent     -> idenfity details about the client that initiated the request.          

-------------------------
    Response Format 
-------------------------
Similar to request message, except for the status line and headers. Status line: 

  * Typical: HTTP/1.1 200 OK 

  Status-Line = HTTP-Version SP Status-Code SP Reason-Phrase CRLF 

  HTTP-Version -> sent as HTTP/1.1 
  Status-Code -> one of many status 
  Reason-Phrase -> human readable version of the status code 

Response headers are faily limited 
  response-header = Accept-Ranges 
                  | Age -> time in seconds since the message was generated on the server 
                  | ETag -> MD5 hash of the entity and used to check for modifications 
                  | Location -> used when sending a redirect and contains a new URL 
                  | Proxy-Authenticate 
                  | Retry-After 
                  | Server -> identifies the server generating the message 
                  | Vary 
                  | WWW-Authenticate 

                  