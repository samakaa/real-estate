module Kaminari
  class CustomRenderer < Kaminari::Helpers::Paginator
    def to_s
      tag.ul(class: "wd-navigation") do
        (previous_page + page_items + next_page).join.html_safe
      end
    end

    private

    def previous_page
      if @collection.prev_page
        tag.li(class: "nav-item") do
          link_to "<i class='icon icon-arr-l'></i>".html_safe, url_for(page: @collection.prev_page)
        end
      else
        ''
      end
    end

    def next_page
      if @collection.next_page
        tag.li(class: "nav-item") do
          link_to "<i class='icon icon-arr-r'></i>".html_safe, url_for(page: @collection.next_page)
        end
      else
        ''
      end
    end

    def page_items
      @collection.each_page.map do |page|
        tag.li(class: "nav-item #{'active' if page == @collection.current_page}") do
          link_to page, url_for(page: page)
        end
      end
    end
  end
end
