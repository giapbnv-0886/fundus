module BlogsHelper
  def render_blog_with_hashtag hash_tag
     hash_tag.gsub(/\w+/){|word| link_to word, "/tags/#{word.delete('#')}"}.html_safe
  end
end
