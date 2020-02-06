# Securing Rails Apps

---

## Sessions

Sessions enable applicaiton to maintain user-specific state while users interact with the app.

- Example: Allow users to authenticate once and remain signed in for future requests

Rails provides a session object for each user that accesses the application.
If a user has an active session, Rails uses existing session, otherwise a new one is created.

### Session Hijacking

When a user signs in with username/password, the web app checks them and stores them in a session hash. Which means from now on the session is valid. The session ID identified in the cookie identifies the session.

The cookie serves as a temporary authentication for the web-app. Anyone who gains control of that cookie can potentially act as the person.

Ways to hijack a session:

- Sniff the cookie in an insecure network. A wireless LAN can be an example of such a network. In an unencrypted wireless LAN, it is especially easy to listen to the traffic of all connected clients. For the web application builder this means to provide a secure connection over SSL.

```ruby
# application config file
config.force_ssl = true
```

- Most people don't clear out the cookies after working at a public terminal. So if the last user didn't log out of a web application, you would be able to use it as this user.
  - Provide the user with a log-out button in the web application, and make it **_PROMINENT_**.
- Many cross-site scripting (XSS) exploits aim at obtaining the user's cookie
- Instead of stealing a cookie unknown to the attacker, they fix a user's session identifier (in the cookie) known to them.

## Session Storage

Rails uses `ActionDispatch::Session::CookieStore` as the default session storage.

Rails `CookieStore` saves the session hash in a cookie on the client-side => Server retrieves the session hash from cookie and eliminates the need for a session ID.

It incresases the speed of the app but some other things to think about are security implications and storage limitations.

- Cookies have a size limit of 4kb, should only be used for data which is relevant to the session
- Cookies are stored on client-side, the client may preseve cookie contents even for expired ones. They may copy cookies to other machines as well.
  - Avoiding storing sensitive data in cookies is a rule of thumb.
- Cookies are temporary by nature, server can set an expiry for it but if the client deletes them before then, they have to re-create a session.
  - Storing data that is more permanent on the server-side is recommended
- Session cookies do not invalidate themselves and can be maliciously reused.
  - It may be a good idea to have your application invalidate old session cookies using a stored timestamp.
- Rails encrypts cookies by default. The client cannot read or edit the contents of the cookie, without breaking encryption.
  - If you take appropriate care of your secrets, you can consider your cookies to be generally secured.

The `CookieStore` uses encrypted cookie jar to provide a secure, encrypted location to store the session data. Cookie-based sessions thus provide both integrity as well as confidentiality to their contents

• The encryption key, as well as the verification key used for signed cookies, is derived from the `secret_key_base` configuration value.

- When generating secrets, use `rails secret`. Secrets must be long and random.
- It is also important to use different _salt_ values for encrypted and signed cookies

In test and development applications get a secret_key_base derived from the app name. Other environments must use a random key present in config/credentials.yml.enc

### If application's secrets have been exposed, changing `secret_key_base` will expire currently active sessions

---

## Rotating Encrypted and Signed Cookies configurations

- Rotation is ideal for changing cookie configurations and ensuring old cookies aren't immediately invalid.
- Your users then have a chance to visit your site, get their cookie read with an old configuration and have it rewritten with the new change.
- The rotation can then be removed once you're comfortable enough users have had their chance to get their cookies upgraded.
  - It's possible to rotate the ciphers and digests used for encrypted and signed cookies.

To change the digest used for signed cookies from SHA1 to SHA256, you would first assign the new configuration value:

```ruby
Rails.application.config.action_dispatch.signed_cookie_digest = "SHA256"
```

Now add a rotation for the old SHA1 digest so existing cookies are seamlessly upgraded to the new SHA256 digest.

```ruby
Rails.application.config.action_dispatch.cookies_rotations.tap do |cookies|
  cookies.rotate :signed, digest: "SHA1"
end
```

Any written signed cookies will be digested with SHA256. Old cookies that were written with SHA1 can still be read, and if accessed will be written with the new digest so they're upgraded and won't be invalid when you remove the rotation.

---

## Replay Attacks for CookieStore Sessions

When using `CookieJar` this is an attack to be wary of.

- A user receives credits, the amount is stored in a session (which is a bad idea anyway, but we'll do this for demonstration purposes).
- The user buys something.
- The new adjusted credit value is stored in the session.
- The user takes the cookie from the first step (which they previously copied) and replaces the current cookie in the browser.
- The user has their original credit back.

Including a nonce (a random value) in the session solves replay attacks. A nonce is **valid only once**, and the server has to keep track of all the valid nonces. It gets even more complicated if you have several application servers.

- Storing nonces in a database table would defeat the entire purpose of CookieStore (avoiding accessing the database).

**The solution against it is not to store this kind of data in a session, but in the database. In this case store the credit in the database and the `logged_in_user_id` in the session**

---

## Session Fixation

Apart from stealing a user's session ID, the attacker may fix a session ID known to them. This is called session fixation.

This attack focuses on fixing a user's session ID known to the attacker, and forcing the user's browser into using this ID. It is therefore not necessary for the attacker to steal the session ID afterwards.

1. The attacker creates a valid session ID: They load the login page of the web application where they want to fix the session, and take the session ID in the cookie from the response
2. They maintain the session by accessing the web application periodically in order to keep an expiring session alive.
3. The attacker forces the user's browser into using this session ID.

   - As you may not change a cookie of another domain (because of the same origin policy), the attacker has to run a JavaScript from the domain of the target web application. Injecting the JavaScript code into the application by XSS accomplishes this attack.

Example

```html
<script>
  document.cookie = "_session_id=16d5b78abb28e3d6206b60f22a03c8d9";</script
>.
```

4. The attacker lures the victim to the infected page with the JavaScript code. By viewing the page, the victim's browser will change the session ID to the trap session ID.
5. As the new trap session is unused, the web application will require the user to authenticate.
6. From now on, the victim and the attacker will co-use the web application with the same session: The session became valid and the victim didn't notice the attack.

The most effective countermeasure is to issue a new session identifier and invalidate the old one after a successful login.
That way, an attacker cannot use the fixed session identifier. This is a good countermeasure against session hijacking as well.

In Rails this can be achieved with `reset_session`

Another method is to save user-specific properties in the session, verify them every time a request comes in, and deny access, if the information does not match. Such properties could be the remote IP address or the user agent (the web browser name), though the latter is less user-specific.

- When saving the IP address, you have to bear in mind that there are Internet service providers or large organizations that put their users behind proxies. These might change over the course of a session, so these users will not be able to use your application, or only in a limited way.

---

## Cross-Site Request Forgery (CSRF)

This attack method works by including malicious code or a link in a page that accesses a web application that the user is believed to have authenticated. If the session for that web application has not timed out, an attacker may execute unauthorized commands.

It is important to notice that the actual crafted image or link doesn't necessarily have to be situated in the web application's domain, it can be anywhere - in a forum, blog post, or email.

---

## Cross Site-Scripting (XSS)

This malicious attack injects client-side executable code.

An entry point is a vulnerable URL and its parameters where an attacker can start an attack.

- common entry points are **message** posts, user **comments**, and guest books, but project **titles**, document **names**, and search **result** pages have also been vulnerable - just about everywhere where the user can **input** **data**.
- input does not necessarily have to come from input boxes on web sites, it can be in any URL parameter - obvious, hidden or internal

### XSS: How it works

1. Attacker injects code, the app saves it and displays it on a page, later presented to a victim

- XSS examples simply display an alert box, but it is more powerful than that.
  - XSS can steal the cookie, hijack the session, redirect the victim to a fake website, display advertisements for the benefit of the attacker, change elements on the web site to get confidential information or install malicious software through security holes in the web browser.
  - Mpack is a very active and up-to-date attack framework which exploits these vulnerabilities

---

## HTML/Javascript Injection

HTML/JS is most common for XSS injection attacks. Escaping user input is essential.

```javascript
// Most straightforward test to check for XSS:
<script>alert('Hello');</script>

//  The next examples do exactly the same, only in very uncommon places
<img src=javascript:alert('Hello')>
<table background="javascript:alert('Hello')">
```
