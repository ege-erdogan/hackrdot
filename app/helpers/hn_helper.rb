module HnHelper

	BASE_URL = 'https://news.ycombinator.com'

	def extract_domain(url)
	    head = url.index('/') + 2
	    head += 4 if url.include?('www')
	    url = url[head..]
	    tail = url.index('/')
	    return url[0...tail]
	  end

	  def extract_title(row)
	    return row.children[4].children[0].inner_text
	  end

	  def valid_post?(row)
	    return row.children[3][:class] == 'votelinks'
	  end

	  def get_article_link(content)
	    link = content.children[4].children[0][:href]
	    return form_hn_link(link) if link.include? 'item?id='

	    return link
	  end

	  def comment?(tag)
	    return (tag.to_s.include? 'comment' or tag.to_s.include? 'discuss')
	  end

	  def extract_comment_count(text)
	    return '0' if text.include?('discuss')

	    return text.tr("\u00A0", ' ').split(' ')[0]
	  end

	  def form_hn_link(id)
	    return "#{BASE_URL}/item?id=#{id}" unless id.include? 'item?id'

	    return "#{BASE_URL}/#{id}"
	  end

end
