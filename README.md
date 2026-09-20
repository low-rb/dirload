<a href="https://rubygems.org/gems/dirload" title="Install gem"><img src="https://badge.fury.io/rb/dirload.svg" alt="Gem version" height="18"></a> <a href="https://github.com/low-rb/dirload" title="GitHub"><img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white" alt="GitHub repo" height="18"></a> <a href="https://codeberg.org/Iow/load" title="Codeberg"><img src="https://img.shields.io/badge/Codeberg-2185D0?style=for-the-badge&logo=Codeberg&logoColor=white" alt="Codeberg repo" height="18"></a>

# Dirload

Dirload is an autoloader where folders don't have to follow namespaces and you can mix and match autoloading with manual requires. Dirload is like a bull in a china shop, smashing through fragile dependencies to autoload your code without manual `load`, `require` or `require_relative` calls.

**✨ Features:**
- Use any namespace or folder structure you want (they don't have to match)
- Manually require files from autoloaded files
- Supports Ruby, RBX, Markdown and can be extended

## Usage

### `dirload()`

Load an entire directory with:
```ruby
# Absolute path.
dirload(File.expand_path('app', __FILE__))

# Path relative to `Dir.pwd`.
dirload('app')
```

Dirload supports loading individual files too:
```ruby
dirload('spec/fixtures/html_node.rb')
```

## File Support

Dirload supports`.rb` as well as the following file types:

### RBX

RBX (`.rbx`) files are Ruby files containing HTML:
```ruby
class MyClass
  def render
    <p>Hello</p>
  end
end
```

ℹ️ For more information see [LowNode](https://github.com/low-rb/lownode).

### Antlers

Antlers syntax can be embedded inside the `render` method of your RBX file:
```ruby
class ParentNode
  def render
    <p><{ ChildNode }></p>
  end
end
```

ℹ️ See [Antlers](https://github.com/raindeer-rb/antlers).

## How it works

1. First Dirload goes through all your files and notes their constant definitions
2. Then it goes through the same files again and creates autoloads for those dependencies
3. Then it goes through every file again and loads it into Ruby

This approach results in a very flexible autoloader with no conventions to follow, no internal dependency graph and very little configuration needed... just point it at a directory. If there are dependencies outside the directory then you can just require those manually from files within the directory, or use a boot file.

### Caveats

Like other autoloading libraries, Dirload doesn't support circular dependencies.

❌ Don't do:
```ruby
class A
  include B
end

class B
  include A
end
```

✅ Instead do:
```ruby
class A
  include C
end

class B
  include C
end

class C
  # Code that both A and B share.
end
```

## Adapter Interface [UNRELEASED]

Dirload will support an adapter interface where any file type can be automatically loaded by `dirload()`... once you define how to load it.

## Philosophy

- Folders are often organised by the kind of file it is, for example; a bunch of views. But namespaces should be organised by your domain, which can be different to your file structure
- You should be able to mix autoloading with manual `require` and `require_relative` calls. You often need files outside the autoloaded directory

## Installation

Add `gem 'dirload'` to your Gemfile then:
```
bundle install
```
