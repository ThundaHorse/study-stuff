---------------------
# Releasing the gem
---------------------
'foodie.gemspec' uses 'git ls- files' to detect which files should be added to the gem when we release it. 
  -> probably good idea to commit all files to repo 

The final step before releasing the gem is to give it a summary and description in the 'foodie.gemspec' file. 

To make sure that the gem is ready to be published, we do: 
  'rake build' --> builds a local copy of the gem and then 'gem install pkg/
                   foodie-0.1.0.gem' to install it. 

Then we can try it locally by running the commands it provides. Once we know everything's working, we can release the first version. 

To release the first version of the gem, we use 'rake release', providing we commited everything. 
What it does: 
  1. Builds the gem to the 'pkg' directory in preparation for a push to 
     Rubygems.org 
  2. Creates a tag for the current commit reflecting the current version and 
     pushses it to the git remote. 
      -> Encouraged to host the code on GitHub so that others can easily find 
         it. 
  3a. If the push succeeds, then the final step would be to push to 
      Rubygems.org which allow other peoples to download and install the gem. 
  3b. If we want to release a second versino of the gem, we should make our 
      changes and then commit to GitHub. Afterwards we bump the version number in 'lib/foodie/version.rb' to whatever, then run 'rake release' again. 

We can install the 'gem-release' gem with: 
```bash 
$ gem install gem-release
``` 

The gem provides several methods for helping with gem development in general. But most helpful is 'gem bump' command which will bump the gem version to the next patch level. 

Couple options: 

```bash 
$ gem bump --version minor # bumps to the next minor version
$ gem bump --version major # bumps to the next major version
$ gem bump --version 1.1.1 # bumps to the specified version
``` 