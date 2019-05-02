task :article_upload => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  sites = ['http://engineering-ru.livejournal.com']

  sites.each do |site|
    url = site
    doc = Nokogiri::HTML(open(url))
    articles = doc.css('.asset')

    articles.each do |p|
      name = p.at_css('.subj-link').text

      d = p.at_css('.subj-link')[:href]
      doc2 = Nokogiri::HTML(open(d))
      body = doc2.at('.e-content').to_html
      short_desc = doc2.at('.e-content').text
      image_url = doc2.at_css('.e-content img').attr('src') if !doc2.at_css('.e-content img').nil?

      link = Translit.convert(name, :english)

      created_at = p.at_css('.datetime').text

      if Post.where(title: name).first.nil?
        Post.create(title: name, short_desc: short_desc, body: body, image_url: image_url, link: link, created_at: created_at, blog_id: 1, user_id: 13, url: d)
        puts "Post created"
      end
    end
  end
end

task :article_upload_geektimes => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  sites = ['https://geektimes.ru']

  sites.each do |site|
    url = site
    doc = Nokogiri::HTML(open(url))
    articles = doc.css('.shortcuts_item')

    articles.each do |p|
      name = p.at_css('.post_title').text if !p.at_css('.post_title').text

      d = p.at_css('.post_title')[:href]
      doc2 = Nokogiri::HTML(open(d))
      body = doc2.at('.html_format').to_html
      short_desc = doc2.at('.html_format').text
      image_url = doc2.at_css('.html_format').at_css('img').attr('src') if !doc2.at_css('.html_format').at_css('img').attr('src').nil?

      link = Translit.convert(name, :english)

      created_at = Time.now

      if Post.where(title: name).first.nil?
        Post.create(title: name, short_desc: short_desc, body: body, image_url: image_url, link: link, created_at: created_at, blog_id: 1, user_id: 14, url: d)
        puts "Post created"
      end
    end
  end
end

task :article_upload_cok => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  sites = ['http://www.c-o-k.ru/all-articles']

  sites.each do |site|
    url = site
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'
    articles = doc.css('#seminars-inner li')

    articles.each do |p|
      name = p.at_css('.title').text

      d_raw = p.at_css('.title a')[:href]
      page_url = "http://www.c-o-k.ru"
      d = page_url + d_raw
      doc2 = Nokogiri::HTML(open(d))
      doc2.encoding = 'utf-8'

      if !doc2.at('.article-text').nil?
        body = doc2.at('.article-text').to_html
        href = doc2.at_css('.article-text').at_css('img').attr('src')
      else
        body = doc2.at('#article').to_html
        href = doc2.at_css('#article').at_css('img').attr('src')
      end

      short_desc = doc2.at('.italic').text

      if href.include?("http")
        image_url = href
      else
        image_url = URI.join( page_url, href ).to_s
      end

      link = Translit.convert(name, :english)

      created_at = Time.now

      if Post.where(title: name).first.nil?
        Post.create(title: name, short_desc: short_desc, body: body, image_url: image_url, link: link, created_at: created_at, blog_id: 1, user_id: 15, url: d)
        puts "Post created"
      end
    end
  end
end

task :article_upload_topclimat => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  sites = ['http://www.topclimat.ru/news/field/']

  sites.each do |site|
    url = site
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'
    articles = doc.css('.news-list__item')

    articles.each do |p|
      name = p.at_css('.news-list__title a').text

      d = p.at_css('.news-list__title a')[:href]

      doc2 = Nokogiri::HTML(open(d))
      doc2.encoding = 'utf-8'
      body = doc2.at('.item-view__text').to_html
      short_desc = doc2.at('.item-view__text').text
      image_url = doc2.at_css('.item-view__text').at_css('img').attr('src') if !doc2.at_css('.item-view__text').at_css('img').attr('src').nil?

      link = Translit.convert(name, :english)

      created_at = doc2.at('.date').text

      if Post.where(title: name).first.nil?
        Post.create(title: name, short_desc: short_desc, body: body, image_url: image_url, link: link, created_at: created_at, blog_id: 1, user_id: 16, url: d)
        puts "Post created"
      end
    end
  end
end

task :metrics => :environment do
  @cs = ConstructionSite.all
  @cs.each do |cs|
    cs.sprints.each do |s|
      remain_hours = 0
      s.tasks.where(state: ['todo', 'in progress']).each do |t|
        remain_hours += t.duration
      end
      m = Metric.new(remain_hours: remain_hours, sprint_id: s.id)
      m.save
    end
  end
end

task :article_upload_pufik => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  sites = ['http://www.pufikhomes.com']

  sites.each do |site|
    url = site
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'
    articles = doc.css('.single_post')

    articles.each do |p|
      name = p.at_css('.post_title a').text

      d = p.at_css('.post_title a')[:href]

      doc2 = Nokogiri::HTML(open(d))
      doc2.encoding = 'utf-8'
      body = doc2.at('.post_entry').to_html
      short_desc = doc2.at('.post_entry').text
      image_url = doc2.at_css('.post_entry').at_css('img').attr('src') if !doc2.at_css('.post_entry').at_css('img').attr('src').nil?

      link = Translit.convert(name, :english)

      created_at = doc2.at('.post_date').text

      if Post.where(title: name).first.nil?
        Post.create(title: name, short_desc: short_desc, body: body, image_url: image_url, link: link, created_at: created_at, blog_id: 1, user_id: 19, url: d)
        puts "Post created"
      end
    end
  end
end

task :article_upload_remstroi => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  sites = ['http://remstroiblog.ru']

  sites.each do |site|
    url = site
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'
    articles = doc.css('#page .excerpt')

    articles.each do |p|
      name = p.at_css('.title a').text

      d = p.at_css('.title a')[:href]

      doc2 = Nokogiri::HTML(open(d))
      doc2.encoding = 'utf-8'
      body = doc2.at('.mark-links').to_html
      short_desc = doc2.at('.mark-links').text
      image_url = doc2.at_css('.mark-links').at_css('img').attr('src') if !doc2.at_css('.mark-links').at_css('img').attr('src').nil?

      link = Translit.convert(name, :english)

      created_at = doc2.at('.thetime').text

      if Post.where(title: name).first.nil?
        Post.create(title: name, short_desc: short_desc, body: body, image_url: image_url, link: link, created_at: created_at, blog_id: 1, user_id: 27, url: d)
        puts "Post created"
      end
    end
  end
end

task :article_upload_engigeek => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  sites = ['http://www.engigeek.org', "http://www.engigeek.org/search?updated-max=2013-09-28T01:54:00%2B04:00&max-results=10&start=10&by-date=false"]

  sites.each do |site|
    url = site
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'
    articles = doc.css('.hentry')

    articles.each do |p|
      name = p.at_css('.entry-title a').text

      d = p.at_css('.entry-title a')[:href]

      doc2 = Nokogiri::HTML(open(d))
      doc2.encoding = 'utf-8'
      body = doc2.at('.hentry').to_html
      short_desc = doc2.at('.hentry').text
      image_url = doc2.at_css('.hentry').at_css('img').attr('src') if !doc2.at_css('.hentry').at_css('img').attr('src').nil?

      link = Translit.convert(name, :english)

      created_at = Time.now

      if Post.where(title: name).first.nil?
        Post.create(title: name, short_desc: short_desc, body: body, image_url: image_url, link: link, created_at: created_at, blog_id: 1, user_id: 26, url: d)
        puts "Post created"
      end
    end
  end
end

task :article_upload_cad_engineer => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  sites = ['http://cad-engineer.blogspot.ca']

  sites.each do |site|
    url = site
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'
    articles = doc.css('.hentry')

    articles.each do |p|
      name = p.at_css('.entry-title a').text

      d = p.at_css('.entry-title a')[:href]

      doc2 = Nokogiri::HTML(open(d))
      doc2.encoding = 'utf-8'
      body = doc2.at('.hentry').to_html
      short_desc = doc2.at('.hentry').text
      image_url = doc2.at_css('.hentry').at_css('img').attr('src') if !doc2.at_css('.hentry').at_css('img').attr('src').nil?

      link = Translit.convert(name, :english)

      created_at = Time.now

      if Post.where(title: name).first.nil?
        Post.create(title: name, short_desc: short_desc, body: body, image_url: image_url, link: link, created_at: created_at, blog_id: 1, user_id: 28, url: d)
        puts "Post created"
      end
    end
  end
end

task :article_upload_weandrevit => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  sites = ['http://weandrevit.blogspot.ca']

  sites.each do |site|
    url = site
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'
    articles = doc.css('.hentry')

    articles.each do |p|
      name = p.at_css('.entry-title a').text

      d = p.at_css('.entry-title a')[:href]

      doc2 = Nokogiri::HTML(open(d))
      doc2.encoding = 'utf-8'
      body = doc2.at('.hentry').to_html
      short_desc = doc2.at('.hentry').text
      image_url = doc2.at_css('.hentry').at_css('img').attr('src') if !doc2.at_css('.hentry').at_css('img').attr('src').nil?

      if image_url.size <= 255
        image_url
      else image_url = nil
      end

      link = Translit.convert(name, :english)

      created_at = Time.now

      if Post.where(title: name).first.nil?
        Post.create(title: name, short_desc: short_desc, body: body, image_url: image_url, link: link, created_at: created_at, blog_id: 1, user_id: 29, url: d)
        puts "Post created"
      end
    end
  end
end

task :article_upload_rudic => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  sites = ['http://rudic.ru']

  sites.each do |site|
    url = site
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'
    articles = doc.css('.page_only .wrap')

    articles.each do |p|
      name = p.at_css('.info info-top, a').text

      d = p.at_css('.info info-top, a')[:href]

      doc2 = Nokogiri::HTML(open(d))
      doc2.encoding = 'utf-8'
      body = doc2.at('.page_only .wrap').to_html
      short_desc = doc2.at('.page_only .wrap').text
      image_url = doc2.at_css('.page_only .wrap').at_css('img').attr('src') if !doc2.at_css('.page_only .wrap').at_css('img').attr('src').nil?

      if image_url.size <= 255
        image_url
      else image_url = nil
      end

      link = Translit.convert(name, :english)

      created_at = Time.now

      if Post.where(title: name).first.nil?
        Post.create(title: name, short_desc: short_desc, body: body, image_url: image_url, link: link, created_at: created_at, blog_id: 1, user_id: 30, url: d)
        puts "Post created"
      end
    end
  end
end

task :article_upload_vashdom => :environment do

  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  sites = ['http://www.vashdom.ru/articles/grpindex16.htm']

  sites.each do |site|
    url = site
    doc = Nokogiri::HTML(open(url))
    doc.encoding = 'utf-8'
    articles = doc.css('.lastindex td')

    articles.each do |p|
      name = p.at_css('.he2, a').text

      d = p.at_css('.he2, a')[:href]

      doc2 = Nokogiri::HTML(open(d))
      doc2.encoding = 'utf-8'
      body = doc2.at('.arttext').to_html
      short_desc = doc2.at('.arttext').text
      image_url_raw = doc2.at_css('.arttext').at_css('img').attr('src') if !doc2.at_css('.arttext').at_css('img').attr('src').nil?
      page_url = "http://www.vashdom.ru"
      image_url = page_url + image_url_raw

      if image_url.size <= 255
        image_url
      else image_url = nil
      end

      link = Translit.convert(name, :english)

      created_at = Time.now

      if Post.where(title: name).first.nil?
        Post.create(title: name, short_desc: short_desc, body: body, image_url: image_url, link: link, created_at: created_at, blog_id: 1, user_id: 1, url: d)
        puts "Post created"
      end
    end
  end
end
