@IsTest
public class Account_t extends DomainBuilder {

	public Account_t() {
		super(Account.SObjectType);

		name('Acme Corp');
	}

	public Account_t name(String value) {
		return (Account_t) set(Account.Name, value);
	}


	public Account_t add(Opportunity_t o) {
		return (Account_t) o.setParent(Opportunity.AccountId, this);
	}

	public Account_t add(Contact_t c) {
		return (Account_t) c.setParent(Contact.AccountId, this);
	}
}