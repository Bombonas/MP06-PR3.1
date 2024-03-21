(: 
    1.3 Quins són els tags més usats? Inclou nom del tag i nombre d’usos en ordre descendent. 
:)

declare option output:method "xml";
declare option output:indent "yes";

<users>
  {
    for $tag in /tags/row
      let $name := $tag/@TagName/string()
      let $count := xs:integer($tag/@Count)
      order by $count descending
    return
    <user>
      <nick>{ $name }</nick>
      <count>{ $count }</count>
    </user>
  }
</users>