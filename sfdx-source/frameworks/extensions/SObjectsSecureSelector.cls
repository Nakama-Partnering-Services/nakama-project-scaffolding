public abstract inherited sharing class SObjectsSecureSelector extends fflib_SObjectSelector {
	abstract Schema.SObjectType getSObjectType();

	abstract List<Schema.SObjectField> getSObjectFieldList();

	public SObjectsSecureSelector() {
		super(false, true, true);
	}

	public SObjectsSecureSelector(Boolean includeFieldSetFields) {
		super(includeFieldSetFields, true, true);
	}
}
