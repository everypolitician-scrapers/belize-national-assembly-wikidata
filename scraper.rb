#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://en.wikipedia.org/wiki/Belizean_general_election,_2012',
  xpath: '//h3[span[@id="By_constituency"]]/following-sibling::table[1]//tr[td[@bgcolor]]//td[5]//a[not(@class="new")]/@title',
) 
EveryPolitician::Wikidata.scrape_wikidata(names: { en: names }, output: false)

