require File.dirname(__FILE__) + '/helper'

class TestSite < Test::Unit::TestCase
  def setup
    @source = File.join(File.dirname(__FILE__), *%w[source])
    @s = Site.new(@source, dest_dir)
  end
  
  def test_site_init
    
  end
  
  def test_read_layouts
    @s.read_layouts
    
    assert_equal ["default", "simple"].sort, @s.layouts.keys.sort
  end
 
  def test_read_posts
    @s.read_posts('')
    posts = Dir[File.join(@source, '_posts/*')]
    assert_equal posts.size - 1, @s.posts.size
  end
  
  def test_site_payload
    clear_dest
    @s.process
    
    posts = Dir[File.join(@source, "**", "_posts/*")]
    categories = %w(bar baz category foo z_category publish_test).sort

    assert_equal posts.size - 1, @s.posts.size
    assert_equal categories, @s.categories.keys.sort
    assert_equal 3, @s.categories['foo'].size
  end
end
