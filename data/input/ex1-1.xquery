(: 
    1.1 Quins són els títols de les preguntes que han estat més vistes (ViewCount)? Inclou títol i nombre de vistes en ordre descendent. 
:)
declare option output:method "xml";
declare option output:indent "yes";
<questions>{
  for $question in /posts/row
    let $title := $question/@Title/string()
    let $viewCount := xs:integer($question/@ViewCount)
    order by $viewCount descending
  return <user>
          <title>{$title}</title>
          <views>{$viewCount}</views>
        </user>
}</questions>

