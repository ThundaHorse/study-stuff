# Components that make up the Rails framework

---

Rails is a MVC framwork. Rail's main components are **_ActionPack_**, **_ActiveSupport_**, **_ActiveModel_**, **_ActiveRecord_**, **_ActiveResource_**, and **_ActionMailer_**.

Essentially, Rails is a **framework** **composed** of other **frameworks** than can be used independently.

1. **Action Pack**: Handles request/responses. Part of the MVC that handles web responses, handling, routing, and view rendering.
   - Uses controllers to 'control' reqeusts and responses.
2. **Active Model**: Provides the 'Model' for MVC. In the current version, Ruby classes can be used as a Models.
   - Important because definition of any persistence layer and integrating into Rails is available.
3. **Active Record**: Rail's **ORM** feature (object relational mapping). This is where naming convention is important
   - Active record queries and such, `Example.find(1)`
4. **Active Support**:A collection of utility classes and library of extensions that are useful in Rails (.blank, .isSomething). Loads by default unless `config.active_support.bare` is declared.
5. **Active Resource**: Typically used in API creation. Allows business objects and REST web services. With it, REST can be used to expose ActiveRecord models.
6. **Action Mailer**: This class wraps ActionController from ActionPack to render the emails as page views, with the same render and templates like pages. Layouts are defined and template renders layout, message content. Similar to rendering a view for controller action, ActionMailer renders a mail template for emails.
