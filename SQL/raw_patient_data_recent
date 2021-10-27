SELECT *
FROM `my-project-mimic-iii-330123.MyMIMIC.raw_patient_data_multi_stages` rs
INNER JOIN (SELECT icustay_id, MAX(charttime) charttime
    FROM `my-project-mimic-iii-330123.MyMIMIC.raw_patient_data_multi_stages`
    GROUP BY icustay_id
) b ON rs.icustay_id = b.icustay_id AND rs.charttime = b.charttime 
