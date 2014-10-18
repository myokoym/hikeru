# coding: utf-8
#
# hikeru.gemspec
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

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hikeru/version'

Gem::Specification.new do |spec|
  spec.name          = "hikeru"
  spec.version       = Hikeru::VERSION
  spec.authors       = ["Masafumi Yokoyama"]
  spec.email         = ["myokoym@gmail.com"]
  spec.summary       = %q{A music synthesizer.}
  spec.description   = %q{A music synthesizer.}
  spec.homepage      = "https://github.com/myokoym/hikeru"
  spec.license       = "LGPLv2 or later"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("gstreamer")
  spec.add_runtime_dependency("gtk2")

  spec.add_development_dependency("test-unit")
  spec.add_development_dependency("test-unit-notify")
  spec.add_development_dependency("test-unit-rr")
  spec.add_development_dependency("bundler", "~> 1.7")
  spec.add_development_dependency("rake", "~> 10.0")
end
