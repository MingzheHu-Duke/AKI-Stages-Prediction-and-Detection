import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import time
import matplotlib.patheffects as PathEffects
import pickle
import sys

from sklearn.model_selection import train_test_split
from sklearn import preprocessing
from sklearn.decomposition import PCA
from sklearn.manifold import TSNE
from sklearn.cluster import KMeans
from sklearn.tree import _tree, DecisionTreeClassifier
from IPython.display import display, HTML
from numpy import mean
from numpy import std
from sklearn.model_selection import KFold
from sklearn.model_selection import GridSearchCV
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
from importlib import resources
from numpy import loadtxt

filename = sys.argv[1]

X_test = loadtxt(filename, delimiter=",")

# Train Data Scaler
test_scaler = preprocessing.StandardScaler().fit(X_test)
# Fit
X_test = test_scaler.transform(X_test)


with resources.path("AKI_Predictions.models", "KMeans6.sav") as f_name:
  clustering_model = pickle.load((open(f_name, 'rb')))
  
if __name__ == "__main__":
  clustering_model.predict(X_test)