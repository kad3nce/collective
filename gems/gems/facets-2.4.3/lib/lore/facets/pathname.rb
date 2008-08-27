# = Pathname
#
# Ruby's standard Pathname class with extensions.
#
# == Authors:
#
# * Daniel Burger
# * Thomas Sawyer
#
# == Copying
#
# Copyright (c) 2006 Thomas Sawyer, Daniel Burger
#
# Ruby License
#
# This module is free software. You may use, modify, and/or redistribute this
# software under the same terms as Ruby.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.

require 'pathname'

require 'facets/file/rootname'


class Pathname

  # Alternate to Pathname#new.
  #
  #   Pathname['/usr/share']
  #
  def self.[](path)
    new(path)
  end

  # Active path separator.
  #
  #   p1 = Pathname.new('/')
  #   p2 = p1 / 'usr' / 'share'   #=> Pathname:/usr/share
  #
  def self./(path)
    new(path)
  end

  # Root constant for building paths from root directory onward.
  def self.root
    Pathname.new('/')
  end

  # Home constant for building paths from root directory onward.
  #
  # TODO: Pathname#home needs to be more robust.
  #
  def self.home
    Pathname.new('~')
  end

  # Work constant for building paths from root directory onward.
  #
  def self.work
    Pathname.new('.')
  end

  # Try to get this into standard Pathname class.
  alias_method :/, :+

  # CREDIT Daniel Burger

  # Platform dependent null device.
  #
  def self.null
    case RUBY_PLATFORM
    when /mswin/i
      'NUL'
    when /amiga/i
      'NIL:'
    when /openvms/i
      'NL:'
    else
      '/dev/null'
    end
  end

  #
  def rootname
    self.class.new(File.rootname(to_s))
  end

#   # Already included in 1.8.4+ version of Ruby (except for inclusion flag)
#   if not instance_methods.include?(:ascend)
#
#     # Calls the _block_ for every successive parent directory of the
#     # directory path until the root (absolute path) or +.+ (relative path)
#     # is reached.
#     def ascend(inclusive=false,&block) # :yield:
#       cur_dir = self
#       yield( cur_dir.cleanpath ) if inclusive
#       until cur_dir.root? or cur_dir == Pathname.new(".")
#         cur_dir = cur_dir.parent
#         yield cur_dir
#       end
#     end
#
#   end
#
#   # Already included in 1.8.4+ version of Ruby
#   if ! instance_methods.include?(:descend)
#
#     # Calls the _block_ for every successive subdirectory of the
#     # directory path from the root (absolute path) until +.+
#     # (relative path) is reached.
#     def descend()
#       @path.scan(%r{[^/]*/?})[0...-1].inject('') do |path, dir|
#         yield Pathname.new(path << dir)
#       path
#       end
#     end
#
#   end

end

class NilClass
  # Provide platform dependent null path.
  #
  # CREDIT Daniel Burger
  def to_path
    Pathname.null
  end
end

# Constant alias of Pathname (short is better!)
Path = Pathname

# Root constant for building paths from root directory onward.
# DEPRECATED: Use Pathname.root (or Path.root) instead.
Root = Pathname.root


