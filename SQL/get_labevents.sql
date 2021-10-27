                SELECT  
                pvt.subject_id, pvt.hadm_id, pvt.icustay_id  
                  , min(CASE WHEN label = 'ANION GAP' THEN valuenum ELSE null END) as ANIONGAP_min  
                  , max(CASE WHEN label = 'ANION GAP' THEN valuenum ELSE null END) as ANIONGAP_max   
                  , min(CASE WHEN label = 'ALBUMIN' THEN valuenum ELSE null END) as ALBUMIN_min  
                  , max(CASE WHEN label = 'ALBUMIN' THEN valuenum ELSE null END) as ALBUMIN_max  
                  , min(CASE WHEN label = 'BANDS' THEN valuenum ELSE null END) as BANDS_min  
                  , max(CASE WHEN label = 'BANDS' THEN valuenum ELSE null END) as BANDS_max  
                  , min(CASE WHEN label = 'BICARBONATE' THEN valuenum ELSE null END) as BICARBONATE_min  
                  , max(CASE WHEN label = 'BICARBONATE' THEN valuenum ELSE null END) as BICARBONATE_max  
                  , min(CASE WHEN label = 'BILIRUBIN' THEN valuenum ELSE null END) as BILIRUBIN_min  
                  , max(CASE WHEN label = 'BILIRUBIN' THEN valuenum ELSE null END) as BILIRUBIN_max  
                  , min(CASE WHEN label = 'CREATININE' THEN valuenum ELSE null END) as CREATININE_min  
                  , max(CASE WHEN label = 'CREATININE' THEN valuenum ELSE null END) as CREATININE_max  
                  , min(CASE WHEN label = 'CHLORIDE' THEN valuenum ELSE null END) as CHLORIDE_min  
                  , max(CASE WHEN label = 'CHLORIDE' THEN valuenum ELSE null END) as CHLORIDE_max  
                  , min(CASE WHEN label = 'GLUCOSE' THEN valuenum ELSE null END) as GLUCOSE_min  
                  , max(CASE WHEN label = 'GLUCOSE' THEN valuenum ELSE null END) as GLUCOSE_max  
                  , min(CASE WHEN label = 'HEMATOCRIT' THEN valuenum ELSE null END) as HEMATOCRIT_min  
                  , max(CASE WHEN label = 'HEMATOCRIT' THEN valuenum ELSE null END) as HEMATOCRIT_max  
                  , min(CASE WHEN label = 'HEMOGLOBIN' THEN valuenum ELSE null END) as HEMOGLOBIN_min  
                  , max(CASE WHEN label = 'HEMOGLOBIN' THEN valuenum ELSE null END) as HEMOGLOBIN_max  
                  , min(CASE WHEN label = 'LACTATE' THEN valuenum ELSE null END) as LACTATE_min  
                  , max(CASE WHEN label = 'LACTATE' THEN valuenum ELSE null END) as LACTATE_max  
                  , min(CASE WHEN label = 'PLATELET' THEN valuenum ELSE null END) as PLATELET_min  
                  , max(CASE WHEN label = 'PLATELET' THEN valuenum ELSE null END) as PLATELET_max  
                  , min(CASE WHEN label = 'POTASSIUM' THEN valuenum ELSE null END) as POTASSIUM_min  
                  , max(CASE WHEN label = 'POTASSIUM' THEN valuenum ELSE null END) as POTASSIUM_max  
                  , min(CASE WHEN label = 'PTT' THEN valuenum ELSE null END) as PTT_min  
                  , max(CASE WHEN label = 'PTT' THEN valuenum ELSE null END) as PTT_max  
                  , min(CASE WHEN label = 'INR' THEN valuenum ELSE null END) as INR_min  
                  , max(CASE WHEN label = 'INR' THEN valuenum ELSE null END) as INR_max  
                  , min(CASE WHEN label = 'PT' THEN valuenum ELSE null END) as PT_min  
                  , max(CASE WHEN label = 'PT' THEN valuenum ELSE null END) as PT_max  
                  , min(CASE WHEN label = 'SODIUM' THEN valuenum ELSE null END) as SODIUM_min  
                  , max(CASE WHEN label = 'SODIUM' THEN valuenum ELSE null end) as SODIUM_max  
                  , min(CASE WHEN label = 'BUN' THEN valuenum ELSE null end) as BUN_min  
                  , max(CASE WHEN label = 'BUN' THEN valuenum ELSE null end) as BUN_max  
                  , min(CASE WHEN label = 'WBC' THEN valuenum ELSE null end) as WBC_min  
                  , max(CASE WHEN label = 'WBC' THEN valuenum ELSE null end) as WBC_max  
            FROM  
            ( SELECT ie.subject_id, ie.hadm_id, ie.icustay_id  
              , CASE  
                    WHEN itemid = 50868 THEN 'ANION GAP'  
                    WHEN itemid = 50862 THEN 'ALBUMIN'  
                    WHEN itemid = 51144 THEN 'BANDS'  
                    WHEN itemid = 50882 THEN 'BICARBONATE'  
                    WHEN itemid = 50885 THEN 'BILIRUBIN'  
                    WHEN itemid = 50912 THEN 'CREATININE'  
                    WHEN itemid = 50806 THEN 'CHLORIDE'  
                    WHEN itemid = 50902 THEN 'CHLORIDE'  
                    WHEN itemid = 50809 THEN 'GLUCOSE'  
                    WHEN itemid = 50931 THEN 'GLUCOSE'  
                    WHEN itemid = 50810 THEN 'HEMATOCRIT'  
                    WHEN itemid = 51221 THEN 'HEMATOCRIT'  
                    WHEN itemid = 50811 THEN 'HEMOGLOBIN'  
                    WHEN itemid = 51222 THEN 'HEMOGLOBIN'  
                    WHEN itemid = 50813 THEN 'LACTATE'  
                    WHEN itemid = 51265 THEN 'PLATELET'  
                    WHEN itemid = 50822 THEN 'POTASSIUM'  
                    WHEN itemid = 50971 THEN 'POTASSIUM'  
                    WHEN itemid = 51275 THEN 'PTT'  
                    WHEN itemid = 51237 THEN 'INR'  
                    WHEN itemid = 51274 THEN 'PT'  
                    WHEN itemid = 50824 THEN 'SODIUM'  
                    WHEN itemid = 50983 THEN 'SODIUM'  
                    WHEN itemid = 51006 THEN 'BUN'  
                    WHEN itemid = 51300 THEN 'WBC'  
                    WHEN itemid = 51301 THEN 'WBC'  
                  ELSE null  
                END AS label  
              , CASE  
                  WHEN itemid = 50862 and valuenum >    10 THEN null  
                  WHEN itemid = 50868 and valuenum > 10000 THEN null  
                  WHEN itemid = 51144 and valuenum <     0 THEN null  
                  WHEN itemid = 51144 and valuenum >   100 THEN null  
                  WHEN itemid = 50882 and valuenum > 10000 THEN null  
                  WHEN itemid = 50885 and valuenum >   150 THEN null  
                  WHEN itemid = 50806 and valuenum > 10000 THEN null  
                  WHEN itemid = 50902 and valuenum > 10000 THEN null  
                  WHEN itemid = 50912 and valuenum >   150 THEN null  
                  WHEN itemid = 50809 and valuenum > 10000 THEN null  
                  WHEN itemid = 50931 and valuenum > 10000 THEN null  
                  WHEN itemid = 50810 and valuenum >   100 THEN null  
                  WHEN itemid = 51221 and valuenum >   100 THEN null  
                  WHEN itemid = 50811 and valuenum >    50 THEN null  
                  WHEN itemid = 51222 and valuenum >    50 THEN null  
                  WHEN itemid = 50813 and valuenum >    50 THEN null  
                  WHEN itemid = 51265 and valuenum > 10000 THEN null  
                  WHEN itemid = 50822 and valuenum >    30 THEN null  
                  WHEN itemid = 50971 and valuenum >    30 THEN null  
                  WHEN itemid = 51275 and valuenum >   150 THEN null  
                  WHEN itemid = 51237 and valuenum >    50 THEN null  
                  WHEN itemid = 51274 and valuenum >   150 THEN null  
                  WHEN itemid = 50824 and valuenum >   200 THEN null  
                  WHEN itemid = 50983 and valuenum >   200 THEN null  
                  WHEN itemid = 51006 and valuenum >   300 THEN null  
                  WHEN itemid = 51300 and valuenum >  1000 THEN null  
                  WHEN itemid = 51301 and valuenum >  1000 THEN null  
                ELSE le.valuenum  
                END AS valuenum  
              FROM `physionet-data.mimiciii_clinical.icustays` ie  
              LEFT JOIN `physionet-data.mimiciii_clinical.labevents` le  
                ON le.subject_id = ie.subject_id AND le.hadm_id = ie.hadm_id  
                AND le.CHARTTIME between (ie.intime - interval '6' hour) and (ie.intime + interval '7' day) 
                AND le.ITEMID in  
                (  
                  50868,  
                  50862,  
                  51144,  
                  50882,  
                  50885,  
                  50912,  
                  50902,  
                  50806,  
                  50931,  
                  50809,  
                  51221,  
                  50810,  
                  51222,  
                  50811,  
                  50813,  
                  51265,  
                  50971,  
                  50822,  
                  51275,  
                  51237,  
                  51274,  
                  50983,  
                  50824,  
                  51006,  
                  51301,  
                  51300   
                )  
                AND valuenum IS NOT null AND valuenum > 0  
            ) pvt  
            GROUP BY pvt.subject_id, pvt.hadm_id, pvt.icustay_id  
            ORDER BY pvt.subject_id, pvt.hadm_id, pvt.icustay_id;
