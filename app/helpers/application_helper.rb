module ApplicationHelper
  def markdown
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, highlight: true, quote: true, footnotes: true)
  end
end
