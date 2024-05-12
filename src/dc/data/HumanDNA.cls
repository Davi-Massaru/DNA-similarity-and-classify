Class dc.data.HumanDNA Extends %Persistent
{

Property sequence As %String(MAXLEN = "");

Property kMers As %String(MAXLEN = "");

Property kMersVector As %Vector(DATATYPE = "DOUBLE", LEN = 768);

Property dnaClass As %Integer;

ClassMethod UploadData() As %Status [ Language = python ]
{
    import pandas as pd
    from sentence_transformers import SentenceTransformer
    import iris

    def getKmers(sequence, size=6, max_length=5000):
        kmers = [sequence[x:x+size].lower() for x in range(len(sequence) - size + 1)]
        kmers = [kmer for kmer in kmers if len(kmer) > 0]
        if len(kmers) == 0:
            return [sequence]
        return kmers[:max_length]


    print("Reading dataset")
    human_df = pd.read_table('/opt/irisbuild/data/human_data.txt')
    human_df = human_df.sample(n=1500, random_state=42)

    print("Creating K-mers groups")
    human_df['K_mers'] = human_df['sequence'].apply(getKmers)

    print("Combining K-mers into strings")
    human_df['K_mers_str'] = human_df['K_mers'].apply(lambda x: ' '.join(x))

    print("Download stsb-roberta-base-v2 model")
    model = SentenceTransformer('stsb-roberta-base-v2')

    print("Encode K_mers")
    embeddings = model.encode(human_df['K_mers_str'].tolist(), normalize_embeddings=True)

    print("Creating column sequence_vectorized")
    human_df['sequence_vectorized'] = embeddings.tolist()


    print("Filling table")
    query = """
                INSERT INTO dc_data.HumanDNA 
                (sequence, kMers,    dnaClass) 
                VALUES (?,    ?,  ?)
            """
    stmt = iris.sql.prepare(query)
    for index, row in human_df.iterrows():
        rs = stmt.execute(row['sequence'],row['K_mers_str'],row['class'])
}

ClassMethod findSimilarity(pSequence As %String) As %String [ Language = python ]
{
    import iris
    from sentence_transformers import SentenceTransformer

    results = []

    def getKmers(sequence, size=6, max_length=5000):
        kmers = [sequence[x:x+size].lower() for x in range(len(sequence) - size + 1)]
        kmers = [kmer for kmer in kmers if len(kmer) > 0]
        if len(kmers) == 0:
            return [sequence]
        return kmers[:max_length]
        

    model = SentenceTransformer('stsb-roberta-base-v2') 
    kmers = getKmers(pSequence)
    kmers_str = ' '.join(kmers)
    search_vector = model.encode(kmers_str, normalize_embeddings=True).tolist()

    stmt = iris.sql.prepare("SELECT TOP 5 ID FROM dc_data.HumanDNA ORDER BY VECTOR_DOT_PRODUCT(kMersVector, TO_VECTOR(?)) DESC ")
    rs = stmt.execute(str(search_vector))

    class_mapping = {
            0: 'G protein coupled receptors',
            1: 'tyrosine kinase',
            2: 'tyrosine phosphatase',
            3: 'synthetase',
            4: 'synthase',
            5: 'lon channel',
            6: 'transcription factor',
    }

    for idx, row in enumerate(rs):
        humanDNA = iris.cls("dc.data.HumanDNA")._OpenId(row[0])    

        results.append({
            "sequence": humanDNA.sequence,
            "dnaClass": class_mapping[humanDNA.dnaClass]
        })
    return results
}

Storage Default
{
<Data name="HumanDNADefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>sequence</Value>
</Value>
<Value name="3">
<Value>kMers</Value>
</Value>
<Value name="4">
<Value>kMersVector</Value>
</Value>
<Value name="5">
<Value>dnaClass</Value>
</Value>
</Data>
<DataLocation>^dc.data.HumanDNAD</DataLocation>
<DefaultData>HumanDNADefaultData</DefaultData>
<IdLocation>^dc.data.HumanDNAD</IdLocation>
<IndexLocation>^dc.data.HumanDNAI</IndexLocation>
<StreamLocation>^dc.data.HumanDNAS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
