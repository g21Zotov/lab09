lgi = require 'lgi'
math = require 'math'
cairo = lgi.cairo
gtk = lgi.require ("Gtk","3.0")
bld = gtk.Builder()
bld:add_from_file('lab09.glade')

ui = bld.objects

x = 0
y = 0

btn = false

sr = 0
sg = 0
sb = 0

function ui.canvas:on_button_press_event(evt)
	btn = true
	ui.canvas:queue_draw()
end

function ui.canvas:on_button_release_event(evt)
	btn = false
	ui.canvas:queue_draw()
end

function ui.canvas:on_motion_notify_event(evt)
	x = evt.x
	y = evt.y
	ui.canvas:queue_draw()
end

function ui.scl_r:on_value_changed()
	sr = ui.scl_r:get_value()
	ui.canvas:queue_draw()
end

function ui.scl_g:on_value_changed()
	sg = ui.scl_g:get_value()
	ui.canvas:queue_draw()
end

function ui.scl_b:on_value_changed()
	sb = ui.scl_b:get_value()
	ui.canvas:queue_draw()
end

function ui.canvas:on_draw(cr)
	cr:set_source_rgb(1, 1, 1, 1)
	cr:paint()
	
	cr:set_source_rgb(sr, sg, sb, 1)
	
	if ui.sqr.active == true then
		if btn == false then
			cr:rectangle(x - 5, y - 5, 10, 10)
		else
			cr:rectangle(x - 10, y - 10, 20, 20)
		end
	else
		if ui.crcl.active == true then
			if btn == false then
				cr:arc(x, y, 5, 0, 2*math.pi)
			else
				cr:arc(x, y, 10, 0, 2*math.pi)
			end
		else
			if ui.trn.active == true then
				if btn == false then
					cr:arc(x, y, 10, math.rad(0), math.rad(180))
				else
					cr:arc(x, y, 15, math.rad(0), math.rad(180))
				end
			end
		end
	end
	cr:fill()
end

function ui.wnd:on_destroy()
	gtk.main_quit()
end

ui.wnd:show_all()
gtk.main()
