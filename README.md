# Rails 7 Test Project

We created a Rails "skeleton" project for testing pieces of Rails w/o the complexity of a complete app.

Look in application.js for static pages.

## /about

Lists misc. info about this app.

## /credentials

This displays credntials available to the app AND the contents of the encrypted files.
We decided NOT to gitignore the credential keys (master.key, development.key, etc.), because this app helps test how that works. We need specific data in the credential files.
