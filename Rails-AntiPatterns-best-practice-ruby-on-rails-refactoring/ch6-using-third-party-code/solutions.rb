# Antipattern - Recutting the gem
1. check if gem exists first, when you want to write some logic not related to app domain

# Antipattern - amateur gemologist
2. Choosing whether to use a gem, consider:
  1. whether gem has tests
  2. whether community is active
  3. whether gem is mature
  If some of above is not met, but You still want to use the gem, bear in mind that You probably would have to devote more time to it

# Antipattern - Vendor junk drawer (/vendor directory was popular in times up to Rails 3)
3. Cleanup `Gemfile` every autumn, when snow melts (and/or `vendor` if you are still on Rails 3 somehow)

# Antipattern - Miscreant modification
4. do not modify gem source code. If you have to modify it behavior:
  1. Monkeypatch it, by opening its class in `lib/some_gem_class.rb`
  2. Fork it, and contribute to it. If you need the changes, but PR isnt merged yet, point gemfile to your fork:

```
gem 'gemname', git: "git://github.com/myuser/mygem.git"
```
