public inherited sharing class SObjectSecureUnitOfWork extends fflib_SObjectUnitOfWork {
	public SObjectSecureUnitOfWork(List<Schema.SObjectType> sObjectTypes) {
		super(sObjectTypes, new SecureDML());
	}

	public inherited sharing class SecureDML extends fflib_SObjectUnitOfWork.SimpleDML {
		public override void dmlInsert(List<SObject> objList) {
			DMLManager.insertAsUser(objList);
		}
		public override void dmlUpdate(List<SObject> objList) {
			DMLManager.updateAsUser(objList);
		}
		public override void dmlDelete(List<SObject> objList) {
			DMLManager.deleteAsUser(objList);
		}
	}
}
