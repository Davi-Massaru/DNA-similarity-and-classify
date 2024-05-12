## DNA similarity and classify
The DNA Similarity and Classification is a REST API that utilizes InterSystems Vector Search technology. Its primary aim is to identify genetic similarities by analyzing a vector database derived from interpreting a dataset obtained during the implementation of the project: [Human DNA Sequences Dataset](https://www.kaggle.com/datasets/sooryaprakash12/human-dna-sequences/data?select=human_data.txt).


## Summary
- [Installation](#installation)
- [Video Demo](#video-demo)
- [Solution](#solution)
  - [Sequence Diagram](#sequence-diagram)
  - [Data Input](#data-input)
  - [Data Output](#data-output)
- [Architecture](#architecture)
- [Team Members](#team-members)


## Installation

To download the project, use the following command in the terminal:
```
git clone 
```
To run the project, use the command: 
```
docker-compose up -d --build
```

> ℹ️ **Attention**: The project execution process can take a long time due to the DNA gene vectorization time, between 30 and 40 minutes.


## Video Demo

The explanation of how the project works can be found at this link.

## Solution


The system is capable of receiving a DNA sequence as input and, through IRIS Vector Search, identifying DNAs with similar genes. This functionality enables rapid identification of patterns and similarities among the provided genetic sequences.



Furthermore, the system provides a solution for processing and analyzing genetic sequence data using machine learning. Definitions are provided for each of the seven classes, along with their respective quantities in human training data. These classes represent functional groups of genetic sequences.


![Exemplo de imagem](/data/_results_.png)

- <b>G protein coupled receptors</b>: G protein-coupled receptors are a class of cell membrane proteins that detect signaling molecules and activate signal transduction pathways within the cell.

- <b>tyrosine kinase</b>: Tyrosine kinases are enzymes that transfer phosphate groups from ATP to tyrosine residues in target proteins, playing important roles in regulating cellular processes such as growth, differentiation, and cell death.

- <b>tyrosine phosphatase</b>: Tyrosine phosphatases are enzymes that remove phosphate groups from tyrosine residues in proteins, playing a role in regulating cellular processes opposite to tyrosine kinases.

- <b>synthetase</b>: Synthetases are enzymes that catalyze the synthesis of complex molecules from simpler units, typically utilizing ATP energy.

- <b>synthase</b>: Similar to synthetases, synthases also catalyze synthesis reactions but typically do not require ATP energy.

- <b>ion channel</b>: Ion channels are cell membrane proteins that allow selective transport of ions across the membrane, playing a crucial role in regulating membrane potential and transmitting electrical signals in cells.

- <b>transcription factor</b>: Transcription factors are proteins that bind to DNA and control gene transcription, thereby regulating gene expression and influencing various cellular and developmental processes.

Initially, a long biological sequence is divided into "words" of length k with overlap. For example, when using "words" of length 6 (hexamers), "ATGCATGCA" becomes: 'ATGCAT', 'TGCATG', 'GCATGC', 'CATGCA'. Consequently, the example sequence is divided into 4 hexamer words. Although hexamer words are used here, the word length is arbitrary and can be adjusted to suit specific situations. Both the word length and the amount of overlap need to be empirically determined for each application. In genomics, these manipulations are commonly referred to as "k-mer counting," where the occurrences of each possible k-mer are counted.

In this project, k-mer counting is employed as a fundamental technique for processing genetic sequence data, thereby enabling comparative analysis of DNA.

## Sequence Diagram

## Data Input

## Data Output

## Technologies Used
- **InterSystems IRIS**: 
Used for creating the vectorized database and structuring the REST API.
- **Docker Container**: Used to create the environment and IRIS application, so that, through a single command, "docker-compose up," the entire project is ready for use.
- **Embedded Python**: Used to create all application scripts, such as: Assembling the vectorized database by inserting VECTOR type data.
- **Vector search**: Used as a mechanism to search for DNA sequences, comparing similar genetic chromosomes in terms of genetic semantics.

## Architecture


## Team Members
[![GitHub](https://img.shields.io/badge/GitHub-Davi--Massaru-blue?logo=github)](https://community.intersystems.com/user/davi-massaru-teixeira-muta) : [Davi Muta](https://community.intersystems.com/user/davi-massaru-teixeira-muta)

[![GitHub](https://img.shields.io/badge/GitHub-NisckzAlves-blue?logo=github)](https://github.com/NisckzAlves) : [Nicole Alves](https://community.intersystems.com/user/nicole-raimundo)
