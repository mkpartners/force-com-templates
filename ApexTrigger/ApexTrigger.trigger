trigger {{ api_name }} on {{ object_name }} (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {

		if ( Trigger.isBefore && Trigger.isInsert ) {
	    //	{{ object_name }}_Helper.beforeInsert(Trigger.New);
		}
		if ( Trigger.isAfter && Trigger.isInsert ) {
	    //	{{ object_name }}_Helper.afterInsert(Trigger.New);
		}
		if ( Trigger.isBefore && Trigger.isUpdate ) {
	    //	{{ object_name }}_Helper.beforeUpdate(Trigger.New, Trigger.Old);
		}
		if ( Trigger.isAfter && Trigger.isUpdate ) {
	    //	{{ object_name }}_Helper.afterUpdate(Trigger.New, Trigger.Old);
		}
		if ( Trigger.isBefore && Trigger.isDelete ) {
	    //	{{ object_name }}_Helper.beforeDelete(Trigger.New);
		}
		if ( Trigger.isAfter && Trigger.isDelete ) {
	    //	{{ object_name }}_Helper.afterDelete(Trigger.New, Trigger.Old);
		}
		if ( Trigger.isAfter && Trigger.isUndelete ) {
	    //	{{ object_name }}_Helper.afterUndelete(Trigger.Old);
		}
}
