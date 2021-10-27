SELECT  *
FROM `my-project-mimic-iii-330123.MyMIMIC.kdigo_stages` ks
INNER JOIN `my-project-mimic-iii-330123.MyMIMIC.labstay` lt
ON ks.icustay_id =lt.icustay_id
INNER JOIN `my-project-mimic-iii-330123.MyMIMIC.vital_chart` vc
ON ks.icustay_id = vc.icustay_id
