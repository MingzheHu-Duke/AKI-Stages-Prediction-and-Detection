import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import time
import matplotlib.patheffects as PathEffects
import pickle

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

"""### Data Generation 
Most work of this step is finished using the Google BigQuery to generate this raw data from the MIMIC III dataset.  
This table includes the important features for AKI stages prediction and the corresponding AKI stages labels. The sensitive information has been deidentified according to the HIPPA.
"""

# Load the dataset
with resources.path("AKI_Prediction.data", "Raw_aki_patient_data.csv") as file_path:
    df = pd.read_csv(file_path)

"""## Data Preprocessing"""

# Take look at percenatge of missing values per feature(column)
per_missing = df.isnull().sum()*100/len(df)
per_missing_df = pd.DataFrame(
    {"Feature Name": df.columns,
     "Missing Percentage": per_missing}
)
# Sort the percentage in a descending order
per_missing_df.sort_values(ascending=False, by="Missing Percentage", inplace=True)
per_missing_df

per_missing_df["Missing Percentage"].values

per_missing_df.at["BANDS_min", "Missing Percentage"]

# Drop the feature if the missing percenatge is greater than 40 percent
for feature in per_missing_df["Feature Name"].values:
  if per_missing_df.at[feature, "Missing Percentage"] >= 40:
    df.drop([feature], inplace=True, axis=1)
print(df.columns)

df.head()

"""### Interpolation of missing data

Since we don't have any prior knowledge about the distribution of these data, one way for interpolation is to fill all the NAs with mean value of that column.
"""

for feature in df.columns:
  # Calculate the mean values of each column ignoring nas
  mean_value = df[feature].mean(skipna=True)
  # Interpolate the missing value with the mean value
  df[feature].fillna(value=mean_value, inplace=True)

# Peek the dataset
df.head()

#As we can see that the all the NAs have gone
df.isnull().values.any()

# Let's take a look at the summary of this dataset
df.describe()

"""### Rebalancing the class distribution"""

df["aki_stage"].value_counts().plot.bar()
plt.title("Distribution of AKI stages")
plt.xlabel("AKI Stages")
plt.show()

# We can observe that our dataset is extremly umbalanaced with too many class 0
# This may cause overfitting, so we want to some of class 0
df["aki_stage"].value_counts()

# Only keep 10 percent of the original class 0
df = df.drop(df[df['aki_stage'] == 0].sample(frac=.9).index)
print(df["aki_stage"].value_counts())

df["aki_stage"].value_counts().plot.bar()
plt.title("Distribution of AKI stages")
plt.xlabel("AKI Stages after rebalancing")
plt.show()
# We can see that the class distribution is much balance now

# Let's take a look at the correlation matrix
import seaborn as sns
plt.figure(figsize=(15, 15))
sns.heatmap(df.corr())
plt.show()

"""### Train Test Split

For this part, we want to split our dataset into train and test dataset. The test dataset will be used for unsupervised clustering and evaluate our supervised learning's prediction performance on each of these clusters.
"""

# First split into features and labels
df_y = df["aki_stage"]
df_X = df.drop(["aki_stage"], axis=1)
# Turn the dataframes into numpy arrays for further calulation
y = df_y.to_numpy()
X= df_X.to_numpy()

print(X.shape, "\n", y.shape)

# Train test split
# 30% would be a good percenatge for testing our model
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, shuffle=True, random_state=2021)
print(X_train.shape, X_test.shape, y_train.shape, y_test.shape)

from numpy import savetxt

def save_file():
    savetxt("X_train.csv", X_train, delimiter=",")
    savetxt("X_test.csv", X_test, delimiter=",")
    savetxt("y_train.csv", y_train, delimiter=",")
    savetxt("y_test.csv", y_test, delimiter=",")
    return

if __name__ = main:
    save_file()