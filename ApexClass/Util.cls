public class {{ api_name }} {

	/**
	*	@name fixNull
	*	@description Changes null Strings to empty Strings
	*	@param String i
	**/
	public static String fixNull(String i){
		return string.isBlank(i) ? '' : i;
	}	

	/**
	*	@name fixNull
	*	@description Changes null Integers to 0
	*	@param Integer i
	**/
	public static Integer fixNull(Integer i){
		return i == null ? 0 : i;
	}

	/**
	*	@name fixNull
	*	@description Changes null Decimals to 0
	*	@param Decimal i
	**/
	public static Decimal fixNull(Decimal i){
		return i == null ? 0 : i;
	}

	/**
	*	@name picklistToSelectOptions
	*	@description Compiles a list of SelectOptions from Picklist Schema
	*	@param List<Schema.PicklistEntry> entries - The Schema for a Picklist field
	*	@param String firstEntry - The label for first entry in the list of SelectOptions, typically --none--
	**/
    public static List<SelectOption> picklistToSelectOptions(List<Schema.PicklistEntry> entries, String firstEntry){
        List<SelectOption> optionList = new List<SelectOption>();
        if ( String.isNotBlank(firstEntry) ){
	        optionList.add(new SelectOption('',firstEntry));
	    }
        for (Schema.Picklistentry ple : entries){
            optionList.add(new SelectOption(ple.getLabel(), ple.getLabel()));
        }
        return optionList;
    }

}