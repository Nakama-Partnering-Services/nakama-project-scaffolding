@IsTest
public class DomainBuilder_Test {
    @IsTest
    private static void staticHappyPath() {

        Contact_t joe = new Contact_t().first('Joe').last('Harris');

        new Account_t()
                .name('Acme Corp')
                .add( new Contact_t() )
                .add( new Opportunity_t()
                            .amount(1000)
                            .closes(2019, 12)
                            .contact(joe));

        DomainBuilder.save();

        System.assertEquals(2, [SELECT Count() FROM Account]);
        System.assertEquals(1, [SELECT Count() FROM Opportunity]);
        System.assertEquals(2, [SELECT Count() FROM Contact]);
        System.assertEquals(1, [SELECT Count() FROM OpportunityContactRole]);
    }

    @IsTest
    private static void happyPath() {

        Contact_t joe = new Contact_t().first('Joe').last('Harris');

        new Account_t()
                .name('Acme Corp')
                .add( new Contact_t() )
                .add( new Opportunity_t()
                            .amount(1000)
                            .closes(2019, 12)
                            .contact(joe))
                .persist();

        System.assertEquals(2, [SELECT Count() FROM Account]);
        System.assertEquals(1, [SELECT Count() FROM Opportunity]);
        System.assertEquals(2, [SELECT Count() FROM Contact]);
        System.assertEquals(1, [SELECT Count() FROM OpportunityContactRole]);
    }


    @IsTest
    private static void autoPopulatesRequiredButIrrelevantFields() {

        new Account_t()
                .add(new Contact_t())
                .add(new Opportunity_t())

                .persist();

        System.assertNotEquals(null, [SELECT Name FROM Account]);
        System.assertNotEquals(null, [SELECT LastName FROM Contact]);
        System.assertNotEquals(null, [SELECT StageName FROM Opportunity]);
    }


    @IsTest
    private static void autoGeneratesRequiredButIrrelevantRelations() {

        new Opportunity_t()
                .amount(1000)

                .persist();

        System.assertEquals(1, [SELECT Count() FROM Account]);
        System.assertEquals(1, [SELECT Count() FROM Opportunity]);
        System.assertNotEquals(null, [SELECT AccountId FROM Opportunity]);
    }


    @IsTest
    private static void allowNicerFieldSetters() {

        new Opportunity_t()
                .closes(2019, 7)
                .persist();

        System.assertEquals(Date.newInstance(2019, 7, 1), [SELECT CloseDate FROM Opportunity].CloseDate);
    }


    @IsTest
    private static void addChildrenOfArbitraryDepth() {

        new Account_t()
                .add(new Contact_t())
                .add(new Opportunity_t()
                        .add(new Contact_t()))

                .persist();

        System.assertEquals(2, [SELECT Count() FROM Account]);
        System.assertEquals(1, [SELECT Count() FROM Opportunity]);
        System.assertEquals(2, [SELECT Count() FROM Contact]);
    }


    @IsTest
    private static void allowsSetupObjects() {

        try {
            System.runAs(User_t.standard()) {
                new Account_t().persist();
            }
        }
        catch(Exception ex) {
            System.assert(false);
        }

        System.assertEquals(1, [SELECT Count() FROM Account]);
    }


    @IsTest
    private static void allowsSelfReferences() {

        // Setup & Exercise
        Contact_t boss = new Contact_t();
        new Contact_t()
                .reports(boss)
                .persist();

        // Verify
        System.assertEquals(2, [SELECT Count() FROM Contact]);
        System.assertEquals(1, [SELECT Count() FROM Contact WHERE ReportsToId != NULL]);
    }


    @IsTest
    private static void allowsJunctionObjects() {

        Opportunity_t o = new Opportunity_t();
        Contact_t c = new Contact_t();

        new OpportunityContactRole_t(o, c).persist();

        System.assertEquals(1, [SELECT Count() FROM OpportunityContactRole
        WHERE ContactId = :c.Id AND OpportunityId = :o.Id]);
    }


    @IsTest
    private static void hideJunctionComplexity() {

        new Opportunity_t()
                .contact(new Contact_t())
                .persist();

        System.assertEquals(1, [SELECT Count() FROM OpportunityContactRole
        WHERE ContactId != null AND OpportunityId != null]);
    }


    @IsTest
    private static void accessRecordFromBuilder() {

        Account_t a = new Account_t().name('Salesforce.com');
        a.persist();

        System.assertEquals(Account.SObjectType, a.record.getSObjectType());
    }


    @IsTest
    private static void accessIdFromBuilder() {
        Account_t a = new Account_t();
        a.persist();

        System.assertEquals(a.Id, [SELECT Id FROM Account].Id);
    }


    @IsTest
    private static void persistReturnsSObject() {
        new Account_t().persist();

        System.assertEquals(1, [SELECT Count() FROM Account]);
    }


    @IsTest
    private static void insertOrder() {

        // Setup
        DomainBuilder.DirectedGraph graph = new DomainBuilder.DirectedGraph()
                            .node(Account.SObjectType)
                            .node(Contact.SObjectType)
                            .node(Opportunity.SObjectType)
                            .node(OpportunityContactRole.SObjectType)

                            .edge(Contact.SObjectType, Account.SObjectType)
                            .edge(Contact.SObjectType, Opportunity.SObjectType)
                            .edge(Opportunity.SObjectType, Account.SObjectType)
                            .edge(OpportunityContactRole.SObjectType, Contact.SObjectType)
                            .edge(OpportunityContactRole.SObjectType, Opportunity.SObjectType);

        // Verify
        List<SObjectType> expectedOrder = new List<SObjectType>{
                            OpportunityContactRole.SObjectType, Contact.SObjectType, Opportunity.SObjectType, Account.SObjectType };
        System.assertEquals(expectedOrder, graph.sortTopologically());
    }


    @IsTest
    private static void noUnneededRecords() {

        // Setup & Exercise
        Contact_t con = new Contact_t();            // 1x insert
        Opportunity_t opp = new Opportunity_t();    // 1x insert

        new Account_t()                             // 1x insert
                .add(new Contact_t())               // 0x insert together with "con"
                .add(con)                           // 0x insert
                .add(opp                            // 0x insert
                     .add(con))                     // 1x insert OpportunityContactRole
                .persist();                         // 1x setSavepoint

        // Verify
        System.assertEquals(5, Limits.getDmlRows());
        System.assertEquals(1, [SELECT Count() FROM Account]);
        System.assertEquals(2, [SELECT Count() FROM Contact]);
        System.assertEquals(1, [SELECT Count() FROM Opportunity]);
        System.assertEquals(1, [SELECT Count() FROM OpportunityContactRole]);
    }
}