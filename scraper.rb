#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

members_2012 = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://pl.wikipedia.org/wiki/Wybory_parlamentarne_i_lokalne_w_Belize_w_2012_roku',
  xpath: '//h3[span[@id="Parlamentarzyści"]]/following-sibling::table[1]//tr[td]//td[3]//a[not(@class="new")]/@title',
  as_ids: true,
)

query = <<SPARQL
  SELECT DISTINCT ?item WHERE {
    ?item p:P39 [ ps:P39 wd:Q21290854 ; pq:P2937 ?term ] .
    ?term p:P31/pq:P1545 ?ordinal .
    FILTER (xsd:integer(?ordinal) >= 9)
  }
SPARQL
p39s = EveryPolitician::Wikidata.sparql(query)

EveryPolitician::Wikidata.scrape_wikidata(ids: p39s | members_2012)
