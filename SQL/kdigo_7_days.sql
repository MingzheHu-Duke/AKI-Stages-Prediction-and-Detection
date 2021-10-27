            SELECT pvt.subject_id, pvt.hadm_id, pvt.icustay_id  
            , min(case when VitalID = 1 then valuenum else null end) as HeartRate_Min  
            , max(case when VitalID = 1 then valuenum else null end) as HeartRate_Max  
            , avg(case when VitalID = 1 then valuenum else null end) as HeartRate_Mean  
            , min(case when VitalID = 2 then valuenum else null end) as SysBP_Min  
            , max(case when VitalID = 2 then valuenum else null end) as SysBP_Max  
            , avg(case when VitalID = 2 then valuenum else null end) as SysBP_Mean  
            , min(case when VitalID = 3 then valuenum else null end) as DiasBP_Min  
            , max(case when VitalID = 3 then valuenum else null end) as DiasBP_Max  
            , avg(case when VitalID = 3 then valuenum else null end) as DiasBP_Mean  
            , min(case when VitalID = 4 then valuenum else null end) as MeanBP_Min  
            , max(case when VitalID = 4 then valuenum else null end) as MeanBP_Max  
            , avg(case when VitalID = 4 then valuenum else null end) as MeanBP_Mean  
            , min(case when VitalID = 5 then valuenum else null end) as RespRate_Min  
            , max(case when VitalID = 5 then valuenum else null end) as RespRate_Max  
            , avg(case when VitalID = 5 then valuenum else null end) as RespRate_Mean  
            , min(case when VitalID = 6 then valuenum else null end) as TempC_Min  
            , max(case when VitalID = 6 then valuenum else null end) as TempC_Max  
            , avg(case when VitalID = 6 then valuenum else null end) as TempC_Mean  
            , min(case when VitalID = 7 then valuenum else null end) as SpO2_Min  
            , max(case when VitalID = 7 then valuenum else null end) as SpO2_Max  
            , avg(case when VitalID = 7 then valuenum else null end) as SpO2_Mean  
            , min(case when VitalID = 8 then valuenum else null end) as Glucose_Min  
            , max(case when VitalID = 8 then valuenum else null end) as Glucose_Max  
            , avg(case when VitalID = 8 then valuenum else null end) as Glucose_Mean  
            FROM  (  
            select ie.subject_id, ie.hadm_id, ie.icustay_id  
            , case  
              when itemid in (211,220045) and valuenum > 0 and valuenum < 300 then 1  
              when itemid in (51,442,455,6701,220179,220050) and valuenum > 0 and valuenum < 400 then 2  
              when itemid in (8368,8440,8441,8555,220180,220051) and valuenum > 0 and valuenum < 300 then 3  
              when itemid in (456,52,6702,443,220052,220181,225312) and valuenum > 0 and valuenum < 300 then 4  
              when itemid in (615,618,220210,224690) and valuenum > 0 and valuenum < 70 then 5  
              when itemid in (223761,678) and valuenum > 70 and valuenum < 120  then 6  
              when itemid in (223762,676) and valuenum > 10 and valuenum < 50  then 6  
              when itemid in (646,220277) and valuenum > 0 and valuenum <= 100 then 7  
              when itemid in (807,811,1529,3745,3744,225664,220621,226537) and valuenum > 0 then 8  
              else null end as VitalID  
            , case when itemid in (223761,678) then (valuenum-32)/1.8 else valuenum end as valuenum  
            from `physionet-data.mimiciii_clinical.icustays` ie  
            left join `physionet-data.mimiciii_clinical.chartevents` ce  
            on ie.subject_id = ce.subject_id and ie.hadm_id = ce.hadm_id and ie.icustay_id = ce.icustay_id  
            and ce.charttime between ie.intime - interval '6' hour and ie.intime + interval '7' day  
            and ce.error IS DISTINCT FROM 1  
            where ce.itemid in  
            (  
            211,  
            220045,  
            51,  
            442,  
            455,  
            6701,  
            220179,  
            220050,  
            8368,  
            8440,   
            8441,   
            8555,   
            220180,   
            220051,   
            456,   
            52,   
            6702,   
            443,   
            220052,  
            220181,   
            225312,   
            618,  
            615,  
            220210,  
            224690,   
            646, 220277,  
            807,  
            811,  
            1529,  
            3745,  
            3744,  
            225664,  
            220621,  
            226537,  
            223762,  
            676,  
            223761,  
            678  
            )  
            ) pvt  
            group by pvt.subject_id, pvt.hadm_id, pvt.icustay_id   
            order by pvt.subject_id, pvt.hadm_id, pvt.icustay_id;
