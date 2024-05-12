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
git clone https://github.com/grongierisc/integrated-ml-demo.git
```
To run the project, use the command: 
```
docker-compose up
```

P.S. The project execution process may take some time due to the DNA gene vectorization time.

## Video Demo

The explanation of how the project works can be found at this link.

## Solution

This project aims to implement a solution for processing and analyzing genetic sequence data. We provide the definitions for each of the 7 classes, as well as their respective quantities in human training data. These classes represent functional groups of genetic sequences. 

![Exemplo de imagem](/data/_results_.png)

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
