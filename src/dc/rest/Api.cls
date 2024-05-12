Class dc.rest.Api Extends dc.rest.RestAbstract
{

ClassMethod find() As %Status [ Language = python ]
{
    import iris
    import json

    dna = iris.cls("dc.rest.RestAbstract").GetQueryStringValue("dna")

    if dna == "":
        print({"message":"No records returned."})
        return iris.cls("%SYSTEM.Status").OK()
    
    DNAClassification = iris.cls("dc.data.DNAClassification").ClassifyDnaSequence(dna) 
    similarity_list = iris.cls("dc.data.HumanDNA").findSimilarity(dna)

    result = {
        "DNA_similarity_list": similarity_list,
        "DNA_classification": DNAClassification
    }


    print( json.dumps(result, indent=4))

    return iris.cls("%SYSTEM.Status").OK()
}

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
    <Route Url="/find" Method="GET" Call="find"/>
</Routes>
}

}
