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
            (sequence, kMers,   kMersVector, dnaClass) 
            VALUES (?,    ?, TO_VECTOR(?), ?)
        """
stmt = iris.sql.prepare(query)
for index, row in human_df.iterrows():
    rs = stmt.execute(row['sequence'],row['K_mers_str'],str(row['sequence_vectorized']),row['class'])
