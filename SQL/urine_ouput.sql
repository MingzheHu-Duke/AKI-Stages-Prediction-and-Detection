            select oe.icustay_id, oe.charttime  
            , SUM(  
                case when oe.itemid = 227488 then -1*value  
                else value end  
              ) as value  
            from `physionet-data.mimiciii_clinical.outputevents` oe  
            where oe.itemid in  
            (  
              40055,  
              43175,  
              40069,  
              40094,  
              40715,  
              40473,  
              40085,  
              40057,  
              40056,  
              40405,  
              40428,  
              40086,  
              40096,  
              40651,  
              226559,  
              226560,  
              226561,  
              226584,  
              226563,  
              226564,  
              226565,  
              226567,  
              226557,  
              226558,  
              227488,  
              227489   
            )  
            and oe.value < 5000  
            and oe.icustay_id is not null  
            group by icustay_id, charttime;
