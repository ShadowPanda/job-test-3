# encoding: utf-8

require "will_paginate/view_helpers/action_view"

Cowtech::Extensions.load!

class SemanticLinkRenderer < WillPaginate::ActionView::LinkRenderer
	protected
	def page_number(page)
		if page != current_page then
			tag(:li, link(page, page, :rel => rel_value(page)))
		else
			tag(:li, link(page, "#"), :class => "active")
		end
	end

	def previous_or_next_page(page, text, classname)
		if page then
			tag(:li, link(text, page), :class => classname)
		else
			tag(:li, link(text, "#"), :class => classname + " disabled")
		end
	end

	def gap
		tag(:li, link("...", "#"), :class => "disabled")
	end

	def html_container(html)
		tag(:ul, html, container_attributes)
	end
end