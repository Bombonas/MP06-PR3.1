(: 
    1.2 Quins són els usuaris que han realitzat més preguntes? Inclou nom de l’usuari i el nombre de preguntes realitzades en ordre descendent. 
:)
declare option output:method "xml";
declare option output:indent "yes";
<users>{
  for $user in distinct-values(/posts/row/@OwnerDisplayName)
    let $questions := count(/posts/row[@OwnerDisplayName = $user])
    order by $questions descending
  return <user>
          <nick>{$user}</nick>
          <questions>{$questions}</questions>
        </user>
}</users>