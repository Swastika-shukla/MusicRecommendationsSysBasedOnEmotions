# Music Recommendation System - Emotion and Demographic Based
Song Recommender which uses Real Time Emotions to Recommend the Music with CBF
## Project Overview
This project focuses on developing a **Music Recommendation System** that suggests music based on **real-time emotion detection, user history**, and **demographic data** such as age, gender, and profession. It leverages a deep learning approach to improve the accuracy of the FER2013 model for facial emotion recognition, adding real-life application contexts like stress and depression detection.

### Key Features
- **Real-Time Emotion Detection**: Uses facial expression recognition to classify emotions and recommend songs that match the user's mood.
- **Age, Gender, and Profession Recognition**: Implements user demographic data to further personalize recommendations.
- **Emotion History Storage**: Tracks and stores users' emotional states over time to provide more accurate, mood-based recommendations.
- **Deep Learning Implementation**: Increased the accuracy of emotion detection by enhancing the FER2013 model with additional data from real-life contexts.
- **Future Applications**: The system has potential for integration with smart devices for applications such as depression and stress monitoring.

## Datasets Used
- **FER2013**: Facial emotion dataset used for training the emotion detection model.
- **Demographic Data**: Age, gender, and profession are captured via user inputs and recognized through external datasets.

## Technology Stack
- **Programming Languages**: Python, R
- **Libraries**: Keras, TensorFlow, OpenCV, dplyr, ggplot2, tidyverse, mice, etc.
- **Machine Learning Techniques**: LSTM for time-series emotion recognition, NLP techniques for music metadata processing.
- **Preprocessing**: Various data cleaning techniques including handling missing data, removing unplayable song links, and enhancing data consistency.
