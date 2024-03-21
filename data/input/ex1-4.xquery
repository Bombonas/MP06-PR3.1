(: 
    1.4 Pels 10 tags més usats, retorna les 100 preguntes amb més vistes que en contenen algun. 
:)

declare option output:method "xml";
declare option output:indent "yes";

let $topTags :=
    for $tag in doc("BBDD-PR3/Tags.xml")//row
    let $tagName := $tag/@TagName/string()
    let $count := $tag/@Count/string()
    order by xs:integer($count) descending
    return $tagName

let $topPost :=
    for $post in doc("BBDD-PR3/Posts.xml")//row
    where some $tag in $topTags satisfies fn:contains($post/@Tags, $tag)
    let $title := $post/@Title/string()
    let $viewCount := $post/@ViewCount/string()
    order by xs:integer($viewCount) descending
    return <Post>
               <Title>{$title}</Title>
               <ViewCount>{$viewCount}</ViewCount>
           </Post>

return subsequence($topPost, 1, 10)