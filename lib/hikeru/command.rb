# class Hikeru::Command
#
# Copyright (C) 2014  Masafumi Yokoyama <myokoym@gmail.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

require "gtk2"
require "optparse"
require "hikeru/window"

module Hikeru
  class Command
    USAGE = "Usage: hikeru [OPTION]..."

    class << self
      def run(*arguments)
        new.run(arguments)
      end
    end

    def initialize
    end

    def run(arguments)
      parse_options(arguments)

      window = Hikeru::Window.new
      window.show_all

      Gtk.main
    end

    private
    def parse_options(arguments)
      options = {}

      parser = OptionParser.new
      parser.on("-v", "--version",
                "Show version number") do
        puts Hikeru::VERSION
        exit(true)
      end
      parser.parse!(arguments)

      options
    end
  end
end
