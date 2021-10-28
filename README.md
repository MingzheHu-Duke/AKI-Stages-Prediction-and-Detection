# Using Machine learning for Acute Kidney Injury Prediction and Early Detection  

Please read the Jupyter NoteBook file for a better understanding of the code.  

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)  **V1.0**


## BMI500_HW7
**!If you could not install the package:**  
1. Check if you have the right python version  
2. Check if you have the latest pip version   
 
**If there are any missing support package:**   
Please install them manually, in case I missed any in the requirements.txt  

This is the package of k means clustering models generated with sklearn package on sklean digits dataset.  
A description of this public dataset is here: https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_digits.html  

**Run Time**: 1.26  
**Minumum Memory Requirements:**: 635 MB

## Usage (Important):  
**Minimum Python Requirement:** 3.7.12 (best if python 3.8)  
**Upgrade Your pip!** $pip install --upgrade pip  

To download and install this package, there are two ways:  
<strike>**1. Install via PYPI:**</strike>  

**2. Clone to local and install:**  
git clone https://github.com/MingzheHu-Duke/AKI-Stages-Prediction-and-Detection.git  
pip install -e AKI_Prediction/  

Here are the functions in the package you may want to call:   
**Import the Package:**  
\>>import AKI_Prediction 
  
**Load the data:**  
\>>from AKI_Prediction  import generate_data  
\>>generate_data.run()

**Run the base K means clustering model:**  
\>> from AKI_Prediction import run_clustering  
\>> run_clustering([data_file_name.csv])  
data_file_name should the the file you want to predict in your current working directory.  
If you don't have the data please run the generation_data function first, the data file will show in your current working directory

**Run the baseline classification model:**  
\>> from AKI_Prediction import run_classification  
\>> run_classification([data_file_name.csv])



**1 Introduction**  
  1.1 Background

Acute kidney injury (AKI) is a common clinical condition with a high risk of death and progression to chronic kidney disease. AKI has become a public relations and health problem worldwide. In 2013, the International Society of Nephrology (ISN) had initiated a &quot;0 by 25&quot; initiative (no patient died of untreated acute renal failure by 2025). However, it is tough to predict the AKI before severe symptoms are shown, even by experienced physicians from whom predictions accuracy lower than 50% was reported. It is essential to find a way to diagnose AKI accurately and predict the stages early. Machine learning models, with the powerful ability in doing data analysis and predictions, could be an excellent attempt to improve this prediction accuracy and foresee this deadly disease long before any severe symptoms have shown up.

  1. 2Contributions

Various researches have been done attempting to predict the AKI stages. Lee et al. proposed a machine learning method to predict acute kidney injury following cardiac surgery. Koyner et al. developed a machine learning inpatient acute kidney injury prediction model with the hospitalization data 6-12 hours right before the Occurrence of kidney injury. However, these methods either focus on patient groups in a specific situation like just having the surgery or predicting with data too close to the Occurrence of injury. Moreover, some of the published results were only predicting a single stage of the AKI. In this paper, we proposed a machine learning-based workflow to forecast the AKI stages 12 hours before the Occurrence of injury.

  1. 3Overview

In this project, the first step was to extract the patient data from the MIMIC III data. We used SQL query to obtain and combine information that might be pivotal in AKI prediction. The second step was using the unsupervised learning methods to cluster the data into different groups. The percentage of different stages in each group was calculated to see if groups of patients are likely to develop similar AKI stages. After this step, supervised learning models are trained with all the training data. Both the generalized classification performance and the cluster-wise classification performance was evaluated.

**2 Methods**

2.1 Data Acquisition

The data source of this project is the Phisionet MIMIC (Medical Information Mart for Intensive Care) III data set. It is a large single-center database comprising information about patients admitted to critical care units at a large tertiary care hospital. The problem was that the information we needed was located on several different tables, so we extracted and combined them. To do this, we wrote several SQL queries and had them run on Google BigQuery. The three most significant tables we extracted are KDIGO\_STAGES, VITAL\_CHART, and LABSTAY. The KDIGO\_STAGES included the AKI stages for ICU-stayed patients according to KDIGO. The VITAL\_CHART included vital signals like temperature, heart rate, and glucose, and LABSTAY have the significant lab results of patients. We then combined these three tables into RAW\_PATIENT\_DATA\_MULTIPLE\_STAGES. Multiple stages of the same patient may exist in this table, so we only keep the lasted record of each unique ICU\_STAY\_ID. The last step was to remove the unrelated information like IDs for our prediction task and load this table as a panda data frame into the python environment. The final 67 features we kept are listed below: _&#39;creat&#39;, &#39;uo\_rt\_6hr&#39;, &#39;uo\_rt\_12hr&#39;, &#39;uo\_rt\_24hr&#39;, &#39;aki\_stage&#39;, &#39;ANIONGAP\_min&#39;, &#39;ANIONGAP\_max&#39;, &#39;ALBUMIN\_min&#39;, &#39;ALBUMIN\_max&#39;, &#39;BANDS\_min&#39;, &#39;BANDS\_max&#39;, &#39;BICARBONATE\_min&#39;, &#39;BICARBONATE\_max&#39;, &#39;BILIRUBIN\_min&#39;, &#39;BILIRUBIN\_max&#39;, &#39;CREATININE\_min&#39;, &#39;CREATININE\_max&#39;, &#39;CHLORIDE\_min&#39;, &#39;CHLORIDE\_max&#39;, &#39;GLUCOSE\_min&#39;, &#39;GLUCOSE\_max&#39;, &#39;HEMATOCRIT\_min&#39;, &#39;HEMATOCRIT\_max&#39;, &#39;HEMOGLOBIN\_min&#39;, &#39;HEMOGLOBIN\_max&#39;, &#39;LACTATE\_min&#39;, &#39;LACTATE\_max&#39;, &#39;PLATELET\_min&#39;, &#39;PLATELET\_max&#39;, &#39;POTASSIUM\_min&#39;, &#39;POTASSIUM\_max&#39;, &#39;PTT\_min&#39;, &#39;PTT\_max&#39;, &#39;INR\_min&#39;, &#39;INR\_max&#39;, &#39;PT\_min&#39;, &#39;PT\_max&#39;, &#39;SODIUM\_min&#39;, &#39;SODIUM\_max&#39;, &#39;BUN\_min&#39;, &#39;BUN\_max&#39;, &#39;WBC\_min&#39;, &#39;WBC\_max&#39;, &#39;HeartRate\_Min&#39;, &#39;HeartRate\_Max&#39;, &#39;HeartRate\_Mean&#39;, &#39;SysBP\_Min&#39;, &#39;SysBP\_Max&#39;, &#39;SysBP\_Mean&#39;, &#39;DiasBP\_Min&#39;, &#39;DiasBP\_Max&#39;, &#39;DiasBP\_Mean&#39;, &#39;MeanBP\_Min&#39;, &#39;MeanBP\_Max&#39;, &#39;MeanBP\_Mean&#39;, &#39;RespRate\_Min&#39;, &#39;RespRate\_Max&#39;, &#39;RespRate\_Mean&#39;, &#39;TempC\_Min&#39;, &#39;TempC\_Max&#39;, &#39;TempC\_Mean&#39;, &#39;SpO2\_Min&#39;, &#39;SpO2\_Max&#39;, &#39;SpO2\_Mean&#39;, &#39;Glucose\_Min\_1&#39;, &#39;Glucose\_Max\_1&#39;, &#39;Glucose\_Mean&#39;_

2.2 Data Preprocessing

2.2.1 Feature Selection

Before building our models, we still have to preprocess the data. Fig 1 shows the percentage of missing data of each feature:

![](RackMultipart20211027-4-mbziu0_html_c354bc5cb2302db6.png)

Figure 1. Percentage of missing data per feature

We set 40% as the cut-off threshold for dropping a feature, and 9 of the 67 features are dropped.

2.2.2 Data Interpolation

For the rest of the features, a lot of missing values still existed. Since we don&#39;t have any background knowledge about the AKI or prior knowledge about the data distribution, one of the easiest ways is using the mean interpolation. The missing parts of each column are replaced by the average values of data we have in that column. The statistic report was generated for each feature and can be found in the Jupyter Notebook attached.

2.2.3 Rebalancing the Data

Figure 2 (1) below shows how imbalanced our data was. As you can see, the number of data at stage 0 is ten times more than the sum of the numbers of the other three stages. In this case, classifiers tend to make biased learning model that has a poorer predictive performance over the minority classes compared to the majority classes.

![](RackMultipart20211027-4-mbziu0_html_ac244bc3e28c3913.png) ![](RackMultipart20211027-4-mbziu0_html_2d3762124514656f.png)

Figure 2. (1)Distribution of AKI stages before rebalancing, (2) After rebalancing

We randomly sampled 90% of phase 0 data, and figure 2 (2) is the resulting distribution of AKI stages.

2.2.4 Correlation Matrix

Figure 3 shows the correlation matrix of the outcome variable aki\_stage together with other input features. Unfortunately, we didn&#39;t observe any strong correlations between the AKI stage and the input variables.

![](RackMultipart20211027-4-mbziu0_html_e60aeecc3e9c7867.png)

Figure 3. Correlation Matrix

2.2.5 Train Test Split

The processed data was further split into training data and test data with a ratio of 3:1. A total of 9739 samples were in the training data, and the rest of the 4174 samples were in the test dataset.

2.2.6 Standardization

Standardization is about making sure that the data is internally consistent; each data type has the same content and format. Since our features have very different ranges and aren&#39;t easy to compare, it is crucial to do the standardization before clustering and to classify. Standardization should be done after the train test split in case of leakage of information.

**3 Unsupervised Clustering**

The unsupervised clustering was done on the test data to see any inner correlations among different data groups.

3. 1 High Dimensional Data Visualization

3.1.1 PCA

A PCA with four components was performed on the test data. The first two components with the most variance explained are used to visualize the data as below. As we can see in figure 4, PCA can&#39;t clearly show the groups&#39; differences in this task.

![](RackMultipart20211027-4-mbziu0_html_a4df37d70744b05.png) ![](RackMultipart20211027-4-mbziu0_html_cf74e8f68663c470.png)

Figure 4. (1) Visualization of the data using PCA, (2) Using tSNE

3.1.2 tSNE

tSNE (t-distributed stochastic neighbor embedding) is a statistical method for visualizing high-dimensional data. As recommended by the official document, we performed a 20 components PCA before training the tSNE to shorten the training time. The visualization result is shown in figure 4 (2). We can see that stage 0 and stage 3 are separated while stage 2 and stage 1 are mixing.

3.2 KMeans

3.2.1 kMeans visualization

KMeans is an unsupervised clustering method whose hyperparameter K needs to be defined. Here we used the elbow method to decide the optimal K as Figure 5 (1). Since we can not observe an apparent &quot;elbow,&quot; we further iterate through some of the reasonable Ks and find six would be the optimum. The clustering result was visualized using tSNE as figure 5(2).

![](RackMultipart20211027-4-mbziu0_html_8259493e5d689d6e.png) ![](RackMultipart20211027-4-mbziu0_html_79aa7cdd21f61b8b.png)

Figure 5(1) The elbow method, (2) The KNN clustering result, K=6

3.2.2 Clustering Result Interpretation

The underlying rules of clustering using the KNN model are further explained using a random tree classifier. The rules are shown in figure 6 as below.

![](RackMultipart20211027-4-mbziu0_html_30bcb27b9595e2bc.png)

Figure 6. The classification rules of our KNN model (K=6)

3.2.3 AKI Stages Occurrence

Figure 7 shows the Occurrence of AKI stages defined by KDIGO in each of our clusters. The different occurrence frequencies of AKI stages may provide us with some helpful prediction information. For example, in clustering group 2, we have far more patients resulting in stage3 than any other stage. By looking up the clustering rules, we could use the rules as early(warning) predictions for the AKI that may happen later.

![](RackMultipart20211027-4-mbziu0_html_7189b2626ff26802.png) ![](RackMultipart20211027-4-mbziu0_html_da8a8416737b55f5.png)

Figure 7. (left) Occurrence of different AKI stages among different KNN clusters

Figure 8. (right) The process of nested cross-validation

**4 Supervised classifier**

4.1 Benchmark Model

The Decision Tree classifier was selected as the baseline model for its simplicity and interpretability. The parameters were chosen using the nested classification, as shown in figure 8. The classification performance on both the training and test datasets is listed below, which is not good.

![](RackMultipart20211027-4-mbziu0_html_db5d3fdca0a6abfa.png) ![](RackMultipart20211027-4-mbziu0_html_c2b3c9c3c89e3616.png)

 4.2 Stretch Model

A simple neural network is implemented to see the classification performance. It has two dense layers with binary cross-entropy loss. The optimizer is Adam and the activation function of RELU. The model was trained with 10-fold cross-validation, and the epoch number is 50. The final performance, which is 0.52, is slightly better than the decision tree classifier.

 4.3 Prediction on different clusters

The trained models were used to predict all the clusters grouped by KNN. However, no difference in prediction performance was observed among different clusters.

**5 Conclusion**

In this project, I tried to develop unsupervised learning to identify patients with risk with data 6-12 hours before AKI occurrence. Supervised learning models were also developed with all the data and predicted on the different clusters. A reasonable performance was achieved (slightly better than the predictions made by physicians), but it is still far from enough. Possible future improvements could be to have a more solid background survey to extract more important features. More machine learning models should be attempted with such a large data set. The time information is also important, so some sophisticated models like long short term memory (LSTM) might have a better prediction result. And the most important part is the feature selection and dimension reduction.

References

[1] Mohamadlou, Hamid, et al. &quot;Prediction of acute kidney injury with a machine learning algorithm using electronic health record data.&quot; _Canadian journal of kidney health and disease_ 5 (2018): 2054358118776326.

[2] Zhang, Zhongheng, Kwok M. Ho, and Yucai Hong. &quot;Machine learning for the prediction of volume responsiveness in patients with oliguric acute kidney injury in critical care.&quot; _Critical Care_ 23.1 (2019): 1-10.

[3]Parreco, Joshua, et al. &quot;Comparing machine learning algorithms for predicting acute kidney injury.&quot; _The American Surgeon_ 85.7 (2019): 725-729.

[4] Flechet, Marine, et al. &quot;Machine learning versus physicians&#39; prediction of acute kidney injury in critically ill adults: a prospective evaluation of the AKIpredictor.&quot; _Critical Care_ 23.1 (2019): 1-10.

[5]Hsu, Chien-Ning, et al. &quot;Machine Learning Model for Risk Prediction of Community-Acquired Acute Kidney Injury Hospitalization From Electronic Health Records: Development and Validation Study.&quot; _Journal of medical Internet research_ 22.8 (2020): e16903.

[6]Flechet, Marine, et al. &quot;Machine learning versus physicians&#39; prediction of acute kidney injury in critically ill adults: a prospective evaluation of the AKIpredictor.&quot; _Critical Care_ 23.1 (2019): 1-10.
