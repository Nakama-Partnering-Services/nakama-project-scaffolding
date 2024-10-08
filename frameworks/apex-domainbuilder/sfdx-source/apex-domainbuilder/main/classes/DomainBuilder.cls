public abstract class DomainBuilder {

    private static DirectedGraph graph = new DirectedGraph();
    private static Set<DomainBuilder> objects = new Set<DomainBuilder>();

    private Map<SObjectField, DomainBuilder> parentByRelationship = new Map<SObjectField, DomainBuilder>();
    public SObject record;
    public SObjectType type;
    public Id id { private set; get {return record.Id;} }


    // CONSTRUCTORS

    public DomainBuilder(SObjectType type) {
        this.type = type;
        this.record = type.newSObject(null, true);

        graph.node(type);
        objects.add(this);
    }


    // PUBLIC

    public static void save() {
        save(new fflib_SObjectUnitOfWork.SimpleDML());
    }

    public static void save(fflib_SObjectUnitOfWork.IDML dml) {
        fflib_SObjectUnitOfWork uow = unitOfWork(dml);

        for(DomainBuilder obj: objects) {
            if(obj.record.Id == null) {
                uow.registerNew(obj.record);
            }

            for(SObjectField rel: obj.parentByRelationship.keySet()) {
                DomainBuilder parent = obj.parentByRelationship.get(rel);
                uow.registerRelationship(obj.record, rel, parent.record);
            }
        }

        uow.commitWork();

        objects.clear();
    }

    public SObject persist() {
        return persist(new fflib_SObjectUnitOfWork.SimpleDML());
    }

    public SObject persist(fflib_SObjectUnitOfWork.IDML dml) {
        save(dml);

        return record;
    }

    // Note: virtual so it can be extended by implementations in order to cast the return type to its specifyc type
    public virtual DomainBuilder recordType(String developerName) {
        Id rtId = type.getDescribe().getRecordTypeInfosByDeveloperName().get(developerName).getRecordTypeId();
        return set('RecordTypeId', rtId);
    }


    // PROTECTED

    protected DomainBuilder setParent(SObjectField relationship, DomainBuilder parent) {
        // Note: The parent registered last always wins!
        DomainBuilder oldParent = parentByRelationship.get(relationship);

        // Note: Sometime we manually unregister parent that are set by default constructor
        if(parent != null) {
            parentByRelationship.put(relationship, parent);
        }

        if(oldParent != null && oldParent != parent) {
            oldParent.unregisterIncludingParents();
        }

        if(parent != null && !objects.contains(parent)) {
            parent.registerIncludingParents();
        }

        graph.edge(this.type, parent.type);

        // Note: Return parent instead of this as we call this always from the parent
        return parent;
    }


    protected DomainBuilder set(String fieldName, Object value) {
        record.put(fieldName, value);
        return this;
    }


    protected DomainBuilder set(SObjectField field, Object value) {
        record.put(field, value);
        return this;
    }


    protected void unregisterIncludingParents() {
        objects.remove(this);

        for(DomainBuilder parent : parentByRelationship.values()) {
            parent.unregisterIncludingParents();
        }
    }


    // PRIVATE

    private void registerIncludingParents() {
        if(record.Id == null) {
            objects.add(this);

            for(DomainBuilder parent: parentByRelationship.values()) {
                parent.registerIncludingParents();
            }
        }
    }


    private static fflib_SObjectUnitOfWork unitOfWork(fflib_SObjectUnitOfWork.IDML dml) {
        List<SObjectType> insertOrder = new List<SObjectType>();
        List<SObjectType> sorted = graph.sortTopologically();

        for(Integer i = sorted.size() - 1; i >= 0; i--){
            insertOrder.add(sorted[i]);
        }
        return new fflib_SObjectUnitOfWork(insertOrder, dml);
    }


    // INNER

    // Note: Code adapted from https://codereview.stackexchange.com/questions/177442

    @TestVisible
    class DirectedGraph {

        Map<SObjectType, Integer> childCount = new Map<SObjectType, Integer>();
        Set<SObjectType> pureChilds = new Set<SObjectType>();
        Map<SObjectType, Set<SObjectType>> parents = new Map<SObjectType, Set<SObjectType>>();


        @TestVisible
        DirectedGraph node(SObjectType type) {
            if(!parents.containsKey(type)) {
                parents.put(type, new Set<SObjectType>());
            }

            return this;
        }

        @TestVisible
        DirectedGraph edge(SObjectType child, SObjectType parent) {
            parents.get(child).add(parent);
            return this;
        }


        @TestVisible
        List<SObjectType> sortTopologically() {
            List<SObjectType> result = new List<SObjectType>();

            countDependencies();

            while(!pureChilds.isEmpty()) {
                SObjectType cur = (SObjectType) pureChilds.iterator().next();
                pureChilds.remove(cur);

                result.add(cur);

                for(SObjectType type : parents.get(cur)) {
                    if(childCount.containsKey(type)) {
                        Integer newCnt = childCount.get(type) - 1;
                        childCount.put(type, newCnt);

                        if(newCnt == 0) {
                            pureChilds.add(type);
                        }
                    }
                }
            }

            // Note: Handle cycles
            if(result.size() < parents.size()) {
                Set<SObjectType> missing = parents.keySet();
                missing.removeAll( new Set<SObjectType>(result) );
                result.addAll(missing);
            }

            return result;
        }


        void countDependencies() {
            for(SObjectType type : parents.keySet()) {
                if(!childCount.containsKey(type)) {
                    pureChilds.add(type);
                }

                for(SObjectType parent : parents.get(type)) {
                    pureChilds.remove(parent);

                    // Note: Ignore cycles
                    if(childCount.containsKey(type)) {
                        childCount.remove(parent);
                        pureChilds.remove(type);
                    }
                    else if(!childCount.containsKey(parent)) {
                        childCount.put(parent, 1);
                    }
                    else {
                        childCount.put(parent, childCount.get(parent) + 1);
                    }
                }
            }
        }
    }
}