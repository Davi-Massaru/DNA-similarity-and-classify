Class dc.initService Extends %RegisteredObject
{

ClassMethod init()
{
    write "START INIT"
    Do ##class(dc.data.DNAClassification).CreateTheModelML()
    Do ##class(dc.data.HumanDNA).UploadData()
}

}