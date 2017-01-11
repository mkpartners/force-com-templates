public class {{ api_name }} {

    public static Map<String, Schema.SObjectField> FIELD_MAP = Schema.SObjectType.{{ object_name }}.fields.getMap();

    /**
    * @name beforeInsert
    * @description
    * @param
    **/
    public static void beforeInsert(List<{{ object_name }}> newList){
        for ( Integer i=0;i<newList.size();i++ ){

        }
    }

    /**
    * @name afterInsert
    * @description
    * @param
    **/
    public static void afterInsert(List<{{ object_name }}> newList){
        for ( Integer i=0;i<newList.size();i++ ){

        }
    }

    /**
    * @name beforeUpdate
    * @description
    * @param
    **/
    public static void beforeUpdate(List<{{ object_name }}> newList, List<{{ object_name }}> oldList){
        for ( Integer i=0;i<newList.size();i++ ){

        }
    }

    /**
    * @name afterUpdate
    * @description
    * @param
    **/
    public static void afterUpdate(List<{{ object_name }}> newList, List<{{ object_name }}> oldList){
        for ( Integer i=0;i<newList.size();i++ ){

        }
    }

    /**
    * @name beforeDelete
    * @description
    * @param
    **/
    public static void beforeDelete(List<{{ object_name }}> newList){
        for ( Integer i=0;i<newList.size();i++ ){

        }
    }

    /**
    * @name afterDelete
    * @description
    * @param
    **/
    public static void afterDelete(List<{{ object_name }}> newList, List<{{ object_name }}> oldList){
        for ( Integer i=0;i<newList.size();i++ ){

        }
    }

    /**
    * @name afterUndelete
    * @description
    * @param
    **/
    public static void afterUndelete(List<{{ object_name }}> oldList){
        for ( Integer i=0;i<oldList.size();i++ ){

        }
    }

}
