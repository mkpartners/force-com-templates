public class {{ api_name }} {

    public static Id STANDARD_PRICEBOOKID = Test.getStandardPricebookId();

    /**
    * @name TESTDATA_IGNORED_FIELDS
    * @date 12/1/2015
    * @description Fields not populated by the DataFactory
    **/
    static Map<String,Set<String>> TESTDATA_IGNORED_FIELDS = new Map<String, Set<String>>{
        'account'=>new Set<String>{'cleanstatus','currencyisocode','id','jigsaw'},
        'application__c'=>new Set<String>{'name'},
        'contact'=>new Set<String>{'cleanstatus','currencyisocode','jigsaw'},
        'event'=>new Set<String>{
            'activitydate','duration','durationinminutes','recurrencetimezonesidkey','recurrencetype','recurrenceinstance',
            'recurrenceinterval','recurrencemonthofyear','recurrencestartdatetime','recurrenceenddateonly','recurrencedayofweekmask','recurrencedayofmonth'
            ,'showas'
        },
        'lead'=>new Set<String>{'cleanstatus','convertedaccountid','currencyisocode','isconverted','jigsaw'},
        'opportunity'=>new Set<String>{'cleanstatus','currencyisocode','forecastcategory','forecastcategoryname','jigsaw'},
        'opportunitylineitem'=>new Set<String>{'cleanstatus','currencyisocode','jigsaw','totalprice'},
        'pricebookentry'=>new Set<String>{'cleanstatus','currencyisocode','isdeleted','jigsaw','name','productcode'},
        'task'=>new Set<String>{'calltype','currencyisocode','recurrencedayofmonth','recurrencedayofweekmask','recurrenceenddateonly','recurrenceinstance',
            'recurrenceinterval','recurrencemonthofyear','recurrenceregeneratedtype','recurrencestartdateonly','recurrencetimezonesidkey',
            'recurrencetype'
        }
    };

    /**
    * @author MK Partners, Inc.
    * @date 12/1/2015
    * @description Map of Object Fields with default values for dataFactory methods
    **/
    static Map<String,Map<String,String>> TESTDATA_DEFAULT_VALUES = new Map<String, Map<String,String>>{
        'account'=>new Map<String,String>{'currencyisocode'=>'USD','type'=>'Vendor'},
        'event'=>new Map<String,String>{'isrecurrence'=>'FALSE'},
        'lead'=>new Map<String,String>{'currencyisocode'=>'USD'},
        'opportunity'=>new Map<String,String>{'currencyisocode'=>'USD'},
        'pricebookentry'=>new Map<String,String>{'currencyisocode'=>'USD','pricebook2id'=>STANDARD_PRICEBOOKID,'usestandardprice'=>'FALSE'},
        'product2'=>new Map<String,String>{},
        'task'=>new Map<String,String>{'isrecurrence'=>'FALSE'}
    };

    /**
    * @author MK Partners, Inc.
    * @date 12/1/2015
    * @description Map of DisplayType Enum Values to default values
    **/
    static Map<String,Object> DISPLAYTYPE_DEFAULT_VALUES = new Map<String, Object>{
        'Boolean'=>TRUE,
        'Integer'=>1,
        'Currency'=>1,
        'Double'=>1,
        'Percent'=>1,
        'Date'=>system.today(),
        'DateTime'=>system.now(),
        'Email'=>'testCoverage@mkpartners.com',
        'Phone'=>'(818) 760-8285',
        'Picklist'=>'Test',
        'String'=>'Test',
        'TextArea'=>'Test',
        'URL'=>'http://www.mkpartners.com'
    };

    /**
    * @author MK Partners,Inc.
    * @date 9/10/2015
    * @description DataFactory Method to construct and insert a list of sObject records
    * @param List<sObject> toCreate
    * @return List<sObject>
    **/
    public static List<sObject> createTestRecords(List<sObject> toCreate){
        return createTestRecords(toCreate, new Map<String,List<sObject>>());
    }

    /**
    * @author MK Partners,Inc.
    * @date 9/15/2015
    * @description DataFactory Method to construct and insert a list of sObject records and populate Ids for Lookups
    * @param List<sObject> toCreate
    * @param Map<String,List<sObject>> relatedRecordMap
    * @return List<sObject>
    **/
    public static List<sObject> createTestRecords(List<sObject> toCreate, Map<String,List<sObject>> relatedRecordMap){
        Schema.SObjectType thisObject = toCreate.getSObjectType();
        String thisObjectName = String.valueOf( toCreate.getSObjectType() ).toLowerCase();
        Set<String> ignoredFields = new Set<String>();
        if ( TESTDATA_IGNORED_FIELDS.containsKey(thisObjectName) ){
            ignoredFields = TESTDATA_IGNORED_FIELDS.get(thisObjectName);
        }
        Map<String,String> defaultValues = new Map<String,String>();
        if ( TESTDATA_DEFAULT_VALUES.containsKey( thisObjectName.toLowerCase()) ){
            defaultValues = TESTDATA_DEFAULT_VALUES.get( thisObjectName.toLowerCase());
        }
        return createTestRecords(toCreate, relatedRecordMap, ignoredFields, defaultValues);
    }

    /**
    * @author MK Partners,Inc.
    * @date 9/15/2015
    * @description DataFactory Method to construct and insert a list of sObject records and populate Ids for Lookups
    * @param List<sObject> toCreate
    * @param Map<String,List<sObject>> relatedRecordMap
    * @param Set<String> ignoredFields
    * @param Map<String,String> defaultValues
    * @return List<sObject>
    **/
    public static List<sObject> createTestRecords(List<sObject> toCreate, Map<String,List<sObject>> relatedRecordMap, Set<String> ignoredFields, Map<String,String> defaultValues){
        Schema.SObjectType thisObject = toCreate.getSObjectType();
        Map<String,Schema.SObjectField> fieldMap = thisObject.getDescribe().fields.getMap();
        sObject testTemplate = thisObject.newSObject();
        List<String> fieldsToIncrement = new List<String>();
        for ( Schema.SObjectField fieldToken : fieldMap.values() ){
            Schema.DescribeFieldResult dfr = fieldToken.getDescribe();
            if ( dfr.isCreateable() && dfr.isAccessible() && !dfr.isAutoNumber() && !ignoredFields.contains( (String.valueOf(fieldToken)).toLowerCase() ) ){
                if ( 
                    !ignoredFields.contains(String.valueOf(fieldToken).toLowerCase()) &&
                    !defaultValues.containsKey(String.valueOf(fieldToken).toLowerCase()) &&
                    ( dfr.isNameField() || dfr.isUnique() ) 
                ){
                    fieldsToIncrement.add(dfr.getName());
                }
                Object defaultValue;
                if ( DISPLAYTYPE_DEFAULT_VALUES.containsKey( dfr.getType().name() ) ){
                    defaultValue = DISPLAYTYPE_DEFAULT_VALUES.get( dfr.getType().name() );
                }
                if ( defaultValues.containsKey( String.valueOf(fieldToken).toLowerCase()) ){
                    defaultValue = defaultValues.get( String.valueOf(fieldToken).toLowerCase() );
                }
                if ( defaultValue != null ){
                    testTemplate.put(dfr.getName(), defaultValue );
                }
            }
        }
        for ( Integer i=0; i<toCreate.size(); i++ ){
            sObject s = testTemplate.clone(false, true, false, false);
            for ( String fieldName : fieldsToIncrement ){
                Schema.DescribeFieldResult dfr = fieldMap.get(fieldName).getDescribe();
                if ( dfr.getType() == Schema.DisplayType.Currency || dfr.getType() == Schema.DisplayType.Double || dfr.getType() == Schema.DisplayType.Integer || dfr.getType() == Schema.DisplayType.Percent ) {
                    s.put(fieldName, i);
                } else 
                if ( dfr.getType() == Schema.DisplayType.Date ){
                    testTemplate.put( dfr.getName(), system.today().addDays(i) );
                } else
                if ( dfr.getType() == Schema.DisplayType.DateTime ){
                    testTemplate.put( dfr.getName(), system.now().addDays(i) );
                } else
                if ( dfr.getType() == Schema.DisplayType.Email ){
                    s.put(fieldName, 'testCoverage'+i+'@mkpartners.com');                   
                } else {
                    s.put(fieldName, 'TEST'+i);                 
                }
            }
            for ( String fieldName : relatedRecordMap.keySet() ){
                s.put( fieldName, relatedRecordMap.get(fieldName)[i].Id );
            }
            toCreate[i] = s;
        }
        insert toCreate;
        return toCreate;
    }



}