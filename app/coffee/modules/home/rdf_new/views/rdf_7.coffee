module.exports = {
  "http://cwf.tw.rpi.edu/data#normalization": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "For growth data, go through each subject and subtract the mean and standard deviation for each growth characteristic to normalize."
      },
      {
        "type": "literal",
        "value": "For characteristic data, go through each column and subtract by the mean and standard deviation of that column."
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#normalization_data"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Normalize growth and characteristic data"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Normalization"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#significant_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#fuzzy_c_means_clustering": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Cluster the subjects by the first mode of the modeled PARAFAC tensor using Fuzzy C-Means clustering"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#cluster_results_data"
      }
    ],
    "http://purl.org/dc/terms/conformsTo": [
      {
        "type": "uri",
        "value": "https://en.wikipedia.org/wiki/Fuzzy_clustering#Fuzzy_C-means_Clustering"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Cluster the subjects based on PARAFAC"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Fuzzy C Means Clustering"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#parafac_model_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#cluster_characteristics_data": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Cluster characteristics"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Cluster characteristics"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#sga_kids": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Gets the SGA status of each unique subject, calculated using birth WAZ in the less than 10th percentile"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#sga_kids_data"
      }
    ],
    "http://purl.org/dc/terms/conformsTo": [
      {
        "type": "uri",
        "value": "https://en.wikipedia.org/wiki/Small_for_gestational_age"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Identify subjects that are small for gestational age (SGA)"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Flag SGA Kids"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#normalization_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#parafac_plot_1": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Create a PARAFAC model for the data using the N-Way toolbox and calculate the sum of squared errors, then plots it for each number of model components versus the sum of squared errors"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Visualization"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Scree-Plot for PARAFAC model"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "PARAFAC Plot 1"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: TensorExplorationPARAFAC.m, Section 7"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#parafac_model_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#parafac_plot_2": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "If the CORCONDIA number is high (close to 100%), then PARAFAC model is valid; If the CORCONDIA number is mid-range (around 50%), the PARAFAC model should be reconsidered, perhaps with more constraints; If the CORCONDIA number is low (close to 0%), the PARAFAC model is not valid."
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Visualization"
      }
    ],
    "http://purl.org/dc/terms/conformsTo": [
      {
        "type": "uri",
        "value": "http://wiki.eigenvector.com/index.php?title=Corcondia"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Core Consistency Plot (CORCONDIA)"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "PARAFAC Plot 2"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: TensorExplorationPARAFAC.m, Section 7"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#parafac_model_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#normalization_data": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Normalization Data"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Normalization Data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#weights_heights": {
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#significant_data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "MATLAB Code: YenerTensor.m, Section 4"
      },
      {
        "type": "literal",
        "value": "Find how many values are missing: If that is one, then fits a linear and quadratic regression on the remaining data. The fit with the higher R2 is used. If that is two, then fits a linear regression on the remaining data. If that is three, then the subject is removed."
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Count missing weights and heights"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Weights, Heights"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#growth_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#choose_subjects": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "MATLAB code: YenerTensor.m, Section 1"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#adjusted_apgar_data"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#growth_data"
      }
    ],
    "http://purl.org/dc/terms/conformsTo": [
      {
        "type": "uri",
        "value": "https://www.nlm.nih.gov/medlineplus/ency/article/003402.htm"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Choose only subjects with all five time points"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Choose Subjects"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#generate_characteristic_data": {
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#significant_data"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#growth_data"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Get either the mean or mode (depending on the type of characteristic data) based on the 10 most similar subjects based on height and weight"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Generate Characteristic Data"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: YenerTensor.m, Section 8"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#adjusted_apgar_data": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Adjusted APGAR Data"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Adjusted APGAR Data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#test_dataset_data": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Test Dataset"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Test Dataset (TENSOR)"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Data"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: YenerTensor.m"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#ea_plot_4": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Create a gradient for each of the characteristics by their number values on the score plot for subjects"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Exploratory Analysis Plot 4"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Visualization"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: TensorExplorationPARAFAC.m, Section 13"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#data_gathering": {
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Data Gathering"
      }
    ],
    "http://dataone.org/ns/provone#hasSubProgram": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#load_test_dataset"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Workflow Phase 0"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#data_processing": {
    "http://dataone.org/ns/provone#hasSubProgram": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#imputation"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#sga_kids"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#normalization"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#adjust_apgar_scores"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#choose_subjects"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#generate_significant_data"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Data Processing"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Workflow Phase 1"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#imputation": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Use linear fit to impute for two missing_time_points"
      },
      {
        "type": "literal",
        "value": "Use regression model to impute for one missing time point"
      },
      {
        "type": "literal",
        "value": "Remove subjects with more than two missing time points"
      }
    ],
    "http://dataone.org/ns/provone#hasSubProgram": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#bmi"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#generate_significant_data"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#generate_characteristic_data"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#weights_heights"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#generate_growth_data"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#baz_haz_waz"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Impute or remove missing values based on how many are missing"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Imputation"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#growth_data": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Growth Data"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Growth Data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#cluster_results_data": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Cluster results"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Cluster results"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#ea_plot_3": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Create a plot of the scores for each mode to see where each point falls"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Exploratory Analysis Plot 3"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Visualization"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: TensorExplorationPARAFAC.m, Section 12"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#ea_plot_2": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Create a plot of the loadings for each component in each mode to see which features, subjects, and time points are more important in their components and respective modes"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Exploratory Analysis Plot 2"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Visualization"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: TensorExplorationPARAFAC.m, Section 11"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#ea_plot_1": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Create a 3D plot for each time point for the original data, the modeled data, and the residuals"
      },
      {
        "type": "literal",
        "value": "Create mesh plots for each time point based on the original tensor, the modeled data by PARAFAC, and the residual (original data – modeled data), respectively"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Create 3D and mesh plots"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Visualization"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Exploratory Analysis Plot 1"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#ea_plot_7": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Create a plot that shows the characteristics versus the more important component, depending on the results of the PARAFAC model."
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Exploratory Analysis Plot 7"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: TensorExplorationPARAFAC.m, Section 23"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Visualization"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#ea_plot_6": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Create a heat map for each mode to see where scores in each plot relative to each other"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Exploratory Analysis Plot 6"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: TensorExplorationPARAFAC.m, Section 15"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Visualization"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#ea_plot_5": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Create a plot of the scores colored by SGA to see where they"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Exploratory Analysis Plot 5"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: TensorExplorationPARAFAC.m, Section 14"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Visualization"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#generate_plots": {
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Generate plots for exploratory analysis"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasVisualization": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#ea_plot_3"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#ea_plot_7"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#ea_plot_1"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#ea_plot_6"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#ea_plot_5"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#ea_plot_4"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#ea_plot_2"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Generate Plots"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#parafac_model_data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#sga_kids_data": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Identified SGA Kids"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Identified SGA Kids"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#gates_recipe": {
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Recipe for Gates Data"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Recipe document: Documentation on Recipe for Gates Data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://www.w3.org/ns/prov#Plan"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#seeAlso": [
      {
        "type": "uri",
        "value": "http://bit.ly/cpp_workflow_jun2016"
      },
      {
        "type": "uri",
        "value": "http://bit.ly/cwf_recipe_fall2015"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: TensorExplorationPARAFAC.m, YenerTensor.m"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#creating_parafac_model": {
    "http://dataone.org/ns/provone#hasSubProgram": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#generate_concordia_number"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#generate_parafac_model"
      }
    ],
    "http://purl.org/dc/terms/conformsTo": [
      {
        "type": "uri",
        "value": "http://en.wikipedia.org/wiki/Tensor_rank_decomposition"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Workflow Phase 2"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Creating PARAFAC Model"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#generate_significant_data": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "After running tensor through analysis, use discretion as to which columns of data to include"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Determine significant data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#growth_data"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#significant_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#workflow_cpp": {
    "http://dataone.org/ns/provone#hasSubProgram": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#clustering"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#data_gathering"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#data_processing"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#creating_parafac_model"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#exploratory_analysis"
      }
    ],
    "http://www.w3.org/ns/prov#hadPlan": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#gates_recipe"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "CPP Workflow: Workflow top level"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "CPP_Workflow"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Workflow"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#clusters_distinct": {
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#cluster_characteristics_data"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Find the characteristics of each cluster by finding the means for each characteristic and testing whether these results are significant at 95% level"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Determine Characteristics of Clusters"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#cluster_results_data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#exploratory_analysis": {
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Workflow Phase 3"
      }
    ],
    "http://dataone.org/ns/provone#hasSubProgram": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#generate_plots"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Exploratory Analysis"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#generate_parafac_model": {
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#parafac_model_data"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#sga_kids_data"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasVisualization": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#parafac_plot_2"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#parafac_plot_1"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Create a PARAFAC model for the data using the N-Way toolbox"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Generate PARAFAC Model"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: TensorExplorationPARAFAC.m, Sections 7 and 8"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#load_test_dataset": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Loading of initial matrix (output of YenerTensor.m)"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "ANTHAyenerfinalmine.xlsx"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Load Test Dataset"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#test_dataset_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#clustering_plot_2": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Histogram of distributions of characteristics, especially IQ, for each cluster"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "IQ Histogram"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Visualization"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#clustering_plot_1": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "PARAFAC scores colored by each cluster to see where each cluster lies"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "PARAFAC Score Plot"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Visualization"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#baz_haz_waz": {
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#significant_data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Calculates BAZ, HAZ, and WAZ from the imputed values based on WHO standards"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Calculate BAZ, HAZ, and WAZ"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: Macros to calculate this using SAS, R, or STATA can be found here: http://www.who.int/childgrowth/software/en/"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#growth_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#create_iq_histogram": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Create a histogram to look at the distributions of characteristics, especially IQ, for each cluster"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Create IQ Histogram"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasVisualization": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#clustering_plot_2"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#cluster_characteristics_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#adjust_apgar_scores": {
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#adjusted_apgar_data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "MATLAB code: YenerTensor.m, Section 1"
      }
    ],
    "http://purl.org/dc/terms/conformsTo": [
      {
        "type": "uri",
        "value": "https://www.nlm.nih.gov/medlineplus/ency/article/003402.htm"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Ensure APGAR scores are between 0-10"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Adjust APGAR Scores"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#test_dataset_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#generate_concordia_number": {
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Generate CONCORDIA Number"
      }
    ],
    "http://purl.org/dc/terms/conformsTo": [
      {
        "type": "uri",
        "value": "http://wiki.eigenvector.com/index.php?title=Corcondia"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#parafac_model_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#parafac_model_data": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "PARAFAC Model"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "PARAFAC Model"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#generate_growth_data": {
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#growth_data"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Generate Growth Data"
      }
    ],
    "http://purl.org/dc/terms/conformsTo": [
      {
        "type": "uri",
        "value": "http://purl.obolibrary.org/obo/OBI_0000679"
      },
      {
        "type": "uri",
        "value": "http://purl.obolibrary.org/obo/STATO_0000237"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#adjusted_apgar_data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#clustering": {
    "http://dataone.org/ns/provone#hasSubProgram": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#fuzzy_c_means_clustering"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#parafac_scores"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#clusters_distinct"
      },
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#create_iq_histogram"
      }
    ],
    "http://www.w3.org/2004/02/skos/core#altLabel": [
      {
        "type": "literal",
        "value": "Workflow Phase 4"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Clustering"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#bmi": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Calculates BMI from the values for each subject using the formula: http://en.wikipedia.org/wiki/Body_mass_index"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasOutData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#significant_data"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Calculate BMI"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasCode": [
      {
        "type": "literal",
        "value": "MATLAB: YenerTensor.m, Section 4"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#growth_data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#significant_data": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "Significant Data"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Significant Data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Data"
      }
    ]
  },
  "http://cwf.tw.rpi.edu/data#parafac_scores": {
    "http://www.w3.org/2000/01/rdf-schema#comment": [
      {
        "type": "literal",
        "value": "PARAFAC scores colored by each cluster to see where each cluster lies"
      }
    ],
    "http://www.w3.org/2000/01/rdf-schema#label": [
      {
        "type": "literal",
        "value": "Create IQ PARAFAC Score Plot"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasVisualization": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#clustering_plot_1"
      }
    ],
    "http://cwf.tw.rpi.edu/vocab#hasInData": [
      {
        "type": "uri",
        "value": "http://cwf.tw.rpi.edu/data#cluster_characteristics_data"
      }
    ],
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#type": [
      {
        "type": "uri",
        "value": "http://dataone.org/ns/provone#Program"
      }
    ]
  }
}
