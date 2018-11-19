#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

members_2012 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://pl.wikipedia.org/wiki/Wybory_parlamentarne_i_lokalne_w_Belize_w_2012_roku',
  xpath: '//h3[span[@id="Parlamentarzyści"]]/following-sibling::table[1]//tr[td]//td[3]//a[not(@class="new")]/@title',
  as_ids: true,
)
EveryPolitician::Wikidata.scrape_wikidata(ids: members_2012)

