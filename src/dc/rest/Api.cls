Class dc.rest.Api Extends dc.rest.RestAbstract
{

ClassMethod ping() As %Status [ Language = python ]
{
    print( {"say": "pong"} )
    
    return iris.cls("%SYSTEM.Status").OK()
}

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
    <Route Url="/ping" Method="GET" Call=""/>
</Routes>
}

}