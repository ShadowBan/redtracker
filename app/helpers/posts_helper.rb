module PostsHelper

  def category_on? categories, tag
     return true if categories.nil?
     categories.include?(tag)
  end
end
