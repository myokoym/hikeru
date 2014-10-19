# class Hikeru::Window
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
require "gst"

module Hikeru
  class Window < Gtk::Window
    KEY_BIND = {
      Gdk::Keyval::GDK_KEY_c  => "C",
      Gdk::Keyval::GDK_KEY_d  => "D",
      Gdk::Keyval::GDK_KEY_e  => "E",
      Gdk::Keyval::GDK_KEY_f  => "F",
      Gdk::Keyval::GDK_KEY_g  => "G",
      Gdk::Keyval::GDK_KEY_a  => "A",
      Gdk::Keyval::GDK_KEY_b  => "B",
    }

    def initialize
      super
      setup
      @files = Dir.glob("data/ogg/*3.ogg")
    end

    private
    def setup
      setup_window
      setup_gst
    end

    def setup_window
      signal_connect("destroy") do
        stop
        Gtk.main_quit
      end

      signal_connect("key_press_event") do |widget, event|
        case event.keyval
        when *KEY_BIND.keys
          play_sound(KEY_BIND[event.keyval])
        when Gdk::Keyval::GDK_KEY_q
          Gtk.main_quit
        end
      end
    end

    def play_sound(scale)
      @files.each do |file|
        if /\A#{scale}\d/ =~ File.basename(file)
          @playbin.stop
          @playbin.uri = Gst.filename_to_uri(file)
          @playbin.play
          break
        end
      end
    end

    def setup_gst
      Gst.init

      @playbin = Gst::ElementFactory.make("playbin")
      if @playbin.nil?
        puts "'playbin' gstreamer plugin missing"
        exit(false)
      end

      @playbin.bus.add_watch do |bus, message|
        case message.type
        when Gst::MessageType::EOS
        end
        true
      end
    end
  end
end
