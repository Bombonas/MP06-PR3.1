(: 
    1.3 Quins són els tags més usats? Inclou nom del tag i nombre d’usos en ordre descendent. 
:)

declare option output:method "xml";
declare option output:indent "yes";

<users>{
  for $tag in /tags/row
    let $postTags := tokenize(/row/@Tags, '&gt;&lt;')
    let $count := count(/post/row[contains(@Tags, $tag/TagName)])
    order by $count descending
    return <user>
            <nick>{$tag/@TagName/string()}</nick>
            <count>{$count}</count>
          </user>
}</users>