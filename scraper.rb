#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'wikidata/fetcher'
require 'nokogiri'
require 'colorize'
require 'pry'
require 'open-uri/cached'
OpenURI::Cache.cache_path = '.cache'


def noko_for(url)
  Nokogiri::HTML(open(URI.escape(URI.unescape(url))).read) 
end

def wikinames_from(url)
  noko = noko_for(url)
  names = noko.xpath('//h3[span[@id="By_constituency"]]/following-sibling::table[1]//tr[td[@bgcolor]]//td[5]//a[not(@class="new")]/@title').map(&:text)
  abort "No names" if names.count.zero?
  names
end

def fetch_info(names)
  WikiData.ids_from_pages('en', names).each do |name, id|
    data = WikiData::Fetcher.new(id: id).data rescue nil
    unless data
      warn "No data for #{p}"
      next
    end
    data[:original_wikiname] = name
    ScraperWiki.save_sqlite([:id], data)
  end
end

fetch_info wikinames_from('https://en.wikipedia.org/wiki/Belizean_general_election,_2012')
