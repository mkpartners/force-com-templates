public with sharing class {{ api_name }} {

	public {{ object_name }} record {get;set;}

	public {{ api_name }}(ApexPages.standardController standardController){
		this.record = ({{ object_name }})standardController.getRecord();
		if ( record.Id != null ){
			//util.queryRecord(record.Id);
		}
	}

	public PageReference save(){
		upsert record;
		if ( !ApexPages.hasMessages() ){
			return new ApexPages.standardController(record).view().setRedirect(true);
		}
		return null;
	}

}