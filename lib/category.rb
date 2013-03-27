class Category
  Node = Struct.new(:title,:tag,:children)

  def initialize
    feed_url = "https://forum-en.guildwars2.com/forum"
    feed = Nokogiri::HTML(open(feed_url))
    @tree = feed.css('.category.active').collect{|node| build_root node}
  end

  def get_categories
    @tree
  end

  def print_tree
    @tree.each do |r|
      puts "#{r.title} :: #{r.tag}"
      r.children.each do |c|
        puts "####{c.title} :: #{c.tag}"
      end
    end
  end

  private

  def build_root node
    children = build_children(node)
    link = node.css('.forum').first.parent().attr('href')
    title = node.css('h2').text
    tag = get_tags(link).first
    Node.new(title,tag,children)
  end

  def build_children node
    children = node.css('.forum')
    children.collect{|c| Node.new(c.css('h3').text,(get_tags(c.parent().attr("href")).last))}
  end

  def get_tags link
    tags = link.split("/")[(2..-1)]
    return ["pvp","spvp"] if tags == ["pvp","pvp"]
    tags
  end

end