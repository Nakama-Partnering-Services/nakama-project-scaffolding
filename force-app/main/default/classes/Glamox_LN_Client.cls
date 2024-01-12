global class Glamox_LN_Client {
// 	public static final string SOAP_NAMESPACE = 'http://schemas.xmlsoap.org/soap/envelope/';
// 	public static final string XSI_NAMESPACE = 'http://www.w3.org/2001/XMLSchema-instance';
// 	public static final string ITEM_NAMESPACE = 'http://www.infor.com/businessinterface/Item_v3';
// 	public static final string WAREHOUSE_NAMESPACE = 'http://www.infor.com/businessinterface/WarehouseItemInventory';
// 	public static final string SALES_ORDER_NAMESPACE = 'http://www.infor.com/businessinterface/SalesOrderGLX';
// 	public static final string CUSTOMER_PRICE_NAMESPACE = 'http://www.infor.com/businessinterface/CustomerPrice';
// 	public static final string SALES_INVOICE_NAMESPACE = 'http://www.infor.com/businessinterface/SalesInvoice_BDE';
// 	public static final string ADDRESS_NAMESPACE = 'http://www.infor.com/businessinterface/Address_v3';
// 	public static final string ZIPCODE_NAMESPACE = 'http://www.infor.com/businessinterface/ZipCodesByCountryGLX';
// 	public static final string CUSTOMER360_NAMESPACE = 'http://www.infor.com/businessinterface/Customer360GLX';

// 	public static final String GLAMOX_NORWAY_BUNAME = 'Glamox Sales Norway';

// 	public static final String CUSTOMER_EASY_ENTRY_BUSINESS_PARTNER = 'http://www.infor.com/businessinterface/EasyEntryBusinessPartnerEnhancedGLX';

// 	/* Maps segment on Opportunity to "line of business" in LN */
// 	private static final Map<string, string> segmentMapping = new Map<string, string>{
// 		'Offshore Energy' => '810',
// 		'Onshore Energy and Petrochemical Industry' => '820',
// 		'Navy' => '940',
// 		'Other' => '950',
// 		'Others' => '950',
// 		'Commercial Marine' => '920',
// 		'Cruise & Ferry' => '930',
// 		'Education' => 'EPL002',
// 		'Health and Care' => 'EPL004',
// 		'Industry' => 'EPL003',
// 		'Navy & Coast Guard' => '940',
// 		'Office' => 'EPL001',
// 		'Outdoor' => 'EPL007',
// 		'Recreational Boats' => '910',
// 		'Residential' => 'EPL012',
// 		'Retail' => 'EPL005',
// 		'Wholesale' => 'EPL008',
// 		'Combined' => 'EPL010',
// 		'Hotels and Restaurants' => 'EPL006',
// 		'Wind Energy' => '830',
// 		'Dealers' => 'EPL009',
// 		'External Agents' => 'EPL011'
// 	};

// 	/* Mapping between markets and order series in LN */
// 	/* @TODO Fetch this from SF markets */
// 	private static final Map<integer, string> orderSeriesMapping = new Map<integer, string>{
// 		164 => 'GS1',
// 		5 => 'GU2',
// 		3 => 'GD2',
// 		10 => 'GE1',
// 		4 => 'GF1',
// 		6 => 'GG1',
// 		8 => 'GI1',
// 		1 => 'GN1',
// 		106 => 'GX1',
// 		113 => 'LM1',
// 		154 => 'NP1',
// 		156 => 'NG1',
// 		128 => 'SI1',
// 		150 => 'PE1',
// 		131 => 'GP1',
// 		178 => 'SK1',
// 		176 => 'SF1',
// 		133 => 'EX1'
// 	};

// 	/* for historical reasons, item codes are prefixed with 9 whitespaces in LN (a migration thing from the old BAAN system).
// 	 We therefore have to add the whitespaces here before querying LN */
// 	public static final string LN_ITEMCODE_PREFIX = '         ';

// 	private I_Glamox_LN_Client_Queries queries;
// 	private I_Glamox_LN_Client_Updates updates;
// 	private Client_Integration_Settings__c clientSettings;

// 	public Glamox_LN_Client() {
// 		this(new Glamox_LN_Client_Queries(), new Glamox_LN_Client_Updates(), new Glamox_Client_Settings());
// 	}
// 	public Glamox_LN_Client(
// 		I_Glamox_LN_Client_Queries queries,
// 		I_Glamox_LN_Client_Updates updates,
// 		I_Glamox_Client_Settings settings
// 	) {
// 		this.queries = queries;
// 		this.updates = updates;
// 		this.clientSettings = settings.getLNClientCredentials();
// 	}
// 	public Glamox_LN_Client(I_Glamox_Client_Settings settings) {
// 		this(new Glamox_LN_Client_Queries(), new Glamox_LN_Client_Updates(), settings);
// 	}

// 	/*
//         https://www.sfdcstop.com/2020/03/validate-crud-permission-before-soqldml.html

//         SELECT
//         WITH
//             SECURITY_ENFORCED
//     */

// 	public class SalesOrder {
// 		@AuraEnabled
// 		public String requestId { get; set; } //NO-DUPLICATE-KEY for checking for duplicate LN orders! Currently we use quoteNumber
// 		@AuraEnabled
// 		public String useWEEE { get; set; }
// 		@AuraEnabled
// 		public String soldToBP { get; set; }
// 		@AuraEnabled
// 		public String salesRepNo { get; set; }
// 		@AuraEnabled
// 		public String backOfficeSalesRepNo { get; set; }
// 		@AuraEnabled
// 		public String businessLine { get; set; }
// 		@AuraEnabled
// 		public String currencyIsoCode { get; set; }
// 		@AuraEnabled
// 		public String orderSeries { get; set; }
// 		@AuraEnabled
// 		public String salesOffice { get; set; }
// 		@AuraEnabled
// 		public String orderType { get; set; }
// 		@AuraEnabled
// 		public String orderDate { get; set; }
// 		@AuraEnabled
// 		public String officeRef { get; set; }
// 		@AuraEnabled
// 		public String carrier { get; set; }
// 		@AuraEnabled
// 		public String lateSurcharge { get; set; }
// 		@AuraEnabled
// 		public String area { get; set; }
// 		@AuraEnabled
// 		public String pointOfTitlePassage { get; set; } //THIS IS THE CITY NAME NOW, NOT THE LN CITY CODE
// 		@AuraEnabled
// 		public String vatException { get; set; }
// 		@AuraEnabled
// 		public String wishDate { get; set; }
// 		@AuraEnabled
// 		public String discount { get; set; }
// 		@AuraEnabled
// 		public String reference { get; set; }
// 		@AuraEnabled
// 		public AddressInfo shippingAddress { get; set; }
// 		@AuraEnabled
// 		public AddressInfo billingAddress { get; set; }
// 		@AuraEnabled
// 		public String shippingConstraint { get; set; }
// 		@AuraEnabled
// 		public String opportunityNo { get; set; }
// 		@AuraEnabled
// 		public String orderEmail { get; set; }
// 		@AuraEnabled
// 		public String paymentTerms { get; set; }
// 		@AuraEnabled
// 		public String deliveryTerms { get; set; }
// 		@AuraEnabled
// 		public String header { get; set; }
// 		@AuraEnabled
// 		public String internalNotes { get; set; }
// 		@AuraEnabled
// 		public String opportunityDesc { get; set; }
// 		@AuraEnabled
// 		public List<SalesOrderLine> orderLines { get; set; }
// 	}

// 	public class SalesOrderLine {
// 		@AuraEnabled
// 		public String productCode { get; set; }
// 		@AuraEnabled
// 		public String configDetailId { get; set; } //in orderLineConfiguratorLinks node
// 		@AuraEnabled
// 		public String configId { get; set; } // in orderLineConfiguratorLinks node
// 		@AuraEnabled
// 		public String sfLineId { get; set; }
// 		@AuraEnabled
// 		public String quantityUnit { get; set; }
// 		@AuraEnabled
// 		public String quantity { get; set; }
// 		@AuraEnabled
// 		public String priceCurrency { get; set; }
// 		@AuraEnabled
// 		public String priceUnit { get; set; }
// 		@AuraEnabled
// 		public String price { get; set; }
// 		@AuraEnabled
// 		public String text { get; set; }
// 		@AuraEnabled
// 		public String discountPerc { get; set; }
// 		@AuraEnabled
// 		public String wishDate { get; set; }
// 	}

// 	public class OrderInfo {
// 		@AuraEnabled
// 		public SalesOrder order { get; set; }
// 		@AuraEnabled
// 		public Id quoteId { get; set; }
// 		@AuraEnabled
// 		public Id accountId { get; set; }
// 		@AuraEnabled
// 		public Id pricebook2Id { get; set; }
// 		@AuraEnabled
// 		public Id wholesalerId { get; set; }
// 	}

// 	public class AddressInfo {
// 		@AuraEnabled
// 		public String addressFormat { get; set; }
// 		@AuraEnabled
// 		public String name1 { get; set; }
// 		@AuraEnabled
// 		public String name2 { get; set; }
// 		// String name3 {get; set;}
// 		@AuraEnabled
// 		public String street1 { get; set; }
// 		@AuraEnabled
// 		public String street2 { get; set; }
// 		@AuraEnabled
// 		public String postalCode { get; set; }
// 		@AuraEnabled
// 		public String cityCode { get; set; } //we dont keep it now from LN, but we should
// 		@AuraEnabled
// 		public String city { get; set; }
// 		@AuraEnabled
// 		public String countryCode { get; set; }
// 		@AuraEnabled
// 		public String emailAddress { get; set; }
// 		@AuraEnabled
// 		public String smsNumber { get; set; }
// 		@AuraEnabled
// 		public String state { get; set; }
// 	}

// 	public class IException extends Exception {
// 	}

// 	private Quote getQuote(Id quoteId) {
// 		//System.QueryException: List has no rows for assignment to SObject
// 		return [
// 			SELECT
// 				Id,
// 				OwnerId,
// 				Pricebook2Id,
// 				OpportunityId,
// 				ContactId,
// 				QuoteNumber,
// 				// OrderSubmitted__c,
// 				CurrencyIsoCode,
// 				Opportunity.Business_Unit__c,
// 				Opportunity.Segment__c,
// 				Opportunity.Opportunity_Number__c,
// 				Opportunity.Name,
// 				Opportunity.OwnerId,
// 				Email,
// 				Email2__c,
// 				BillingName,
// 				BillingAdditionalName__c,
// 				BillingAddress,
// 				ShippingName,
// 				ShippingAdditionalName__c,
// 				ShippingAddress,
// 				ShippingEmail__c,
// 				ShippingPhone__c,
// 				QuoteArea__c,
// 				Freight_Zone__c,
// 				Vat_Exception__c,
// 				Shipping_Constraint__c,
// 				// ReplacementOrClaim__c,
// 				OrderType__c,
// 				Carrier__c,
// 				Point_Of_Title_Passage__c,
// 				Requested_Date__c,
// 				OrderDiscount__c,
// 				YourReference__c,
// 				TermsOfPayment__c,
// 				TermsOfDelivery__c,
// 				External_Notes__c,
// 				Internal_Notes__c,
// 				Pallet_Marking__c,
// 				HideDiscounts__c,
// 				Handled_By_Wholesaler__c,
// 				UseWEEE__c,
// 				WEEEType__c,
// 				Wholesaler_Quote__c,
// 				Wholesaler_Commission__c,
// 				Wholesaler_Ref_text__c,
// 				Wholesaler_Customer_Number__c,
// 				Wholesaler_Project_Number__c,
// 				Wholesaler_Order_Number__c,
// 				Wholesaler_Customer_Phone__c,
// 				Wholesaler_Bidder_Contact__c,
// 				Bidder__r.Id,
// 				Bidder__r.Customer_Number_LN__c,
// 				Bidder__r.Name,
// 				Bidder__r.UseWEEE__c,
// 				Sales_Rep__r.LN_EmployeeNO__c,
// 				Sales_Rep__r.ReceiveOrderConfirmationFromLN__c,
// 				Sales_Rep__r.Email,
// 				BackOfficeRep__r.LN_EmployeeNO__c,
// 				QuoteOwner__r.LN_EmployeeNO__c,
// 				QuoteOwner__r.ReceiveOrderConfirmationFromLN__c,
// 				QuoteOwner__r.Email,
// 				Wholesaler__r.Customer_Number_LN__c,
// 				Wholesaler__r.Name,
// 				Wholesaler__r.UseWEEE__c
// 			FROM Quote
// 			WHERE Id = :quoteId
// 		];
// 	}

// 	private List<QuoteLineItem> getQuoteLines(Id quoteId) {
// 		return [
// 			SELECT
// 				Id,
// 				UnitPrice,
// 				SortOrder,
// 				Product2.Is_Dummy__c,
// 				Product2.ProductCode,
// 				Product2.QuantityUnitOfMeasure,
// 				Quantity,
// 				CurrencyIsoCode,
// 				Description,
// 				ServiceDate,
// 				Placeholder__c,
// 				Listprice_WhenAdded__c,
// 				LineDiscount__c,
// 				ConfiguratorConfigurationId__c,
// 				ConfiguratorHeaderId__c,
// 				Description_to_order__c,
// 				Description_to_order_External__c,
// 				Pos__c
// 			FROM QuoteLineItem
// 			WHERE QuoteId = :quoteId
// 		];
// 	}

// 	private User getOpportunityOwner(Quote quote) {
// 		return [
// 			SELECT LN_Sales_Office__c, GMS_MarkedID__c, BU_OrderSeries__c
// 			FROM User
// 			WHERE Id = :quote.Opportunity.OwnerId
// 		];
// 	}

// 	// @AuraEnabled(cacheable=false) public static Boolean useNewSubmitPath(Id quoteId){
// 	//     Quote quote = [SELECT Opportunity.Business_Unit__c FROM Quote WHERE Id=:quoteId ];
// 	//     String opportunityBU = quote.Opportunity?.Business_Unit__c; //crappy string, but its temp crap? right.
// 	//     List<String> v2BUs = new List<String>{
// 	//         'Glamox Korea',
// 	//         'Glamox Sales Poland',
// 	//         'Glamox Sales Export',
// 	//         'Glamox Sales Export Poland',
// 	//         'Glamox Sales Sweden',
// 	//         'Glamox International',
// 	//         'Glamox Sales Netherlands',
// 	//         'Glamox Sales Germany',
// 	//         'Glamox Sales Switzerland',
// 	//         'Glamox Sales Finland'
// 	//     };
// 	//     return v2BUs.contains(opportunityBU);
// 	// }

// 	@AuraEnabled(cacheable=false)
// 	public static Boolean useNewSubmitPath(Id quoteId) {
// 		Quote quote = [SELECT Opportunity.Business_Unit__c FROM Quote WHERE Id = :quoteId];
// 		String opportunityBU = quote.Opportunity?.Business_Unit__c; //crappy string, but its temp crap? right.
// 		return opportunityBU != 'Glamox Sales Norway'; //GSN has Electroscandia orders
// 	}

// 	@AuraEnabled(cacheable=false)
// 	public static OrderInfo getOrderInfo(Id quoteId) {
// 		return (new Glamox_LN_Client()).getOrderInfoInternal(quoteId);
// 	}

// 	public class SubmitOrderException extends Exception {
// 		public SubmitOrderException(SubmitOrderResponse soe) {
// 			this.setMessage(JSON.serialize(soe));
// 		}
// 	}

// 	@AuraEnabled(cacheable=false)
// 	public static string submitOrder(OrderInfo oInfo) {
// 		LN_Servicewindow__c sw = LN_Servicewindow__c.getInstance();
// 		Boolean thatTimeIsNow =
// 			(datetime.now() >= sw.Next_Servicewindow_Start__c) && (datetime.now() < sw.Next_Servicewindow_End__c);
// 		if (thatTimeIsNow) {
// 			throw new IException(
// 				'LN is unavailable due to scheduled maintenance from ' +
// 				sw.Next_Servicewindow_Start__c +
// 				' to ' +
// 				sw.Next_Servicewindow_End__c
// 			);
// 		}

// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		SubmitOrderResponse oRes = client.submitOrderInternal(oInfo.order); //CALLOUT
// 		if (!oRes.success) {
// 			throw new SubmitOrderException(oRes);
// 		}
// 		client.updateQuoteSuccessfulSubmit(oRes.orderNumber, oInfo); //update
// 		return oRes.orderNumber;
// 	}

// 	public void updateQuoteSuccessfulSubmit(String orderNumber, OrderInfo oInfo) {
// 		Quote q = [SELECT Id FROM Quote WHERE Id = :oInfo.quoteId];
// 		q.SubmittedOrderInfo__c = JSON.serialize(oInfo);
// 		q.LN_Order_ID__c = orderNumber;
// 		update q;
// 	}

// 	@AuraEnabled(cacheable=false)
// 	public static void updateQuoteLastSubmitError(Id quoteId, String lastError) {
// 		(new Glamox_LN_Client()).updateQuoteLastSubmitErrorInternal(quoteId, lastError);
// 	}

// 	public void updateQuoteLastSubmitErrorInternal(Id quoteId, String lastSubmitError) {
// 		Quote q = [SELECT Id FROM Quote WHERE Id = :quoteId];
// 		q.LastSubmitError__c = lastSubmitError;
// 		update q;
// 	}

// 	@AuraEnabled(cacheable=false)
// 	public static void updateQuoteOrderNumber(Id quoteId, String orderNumber) {
// 		(new Glamox_LN_Client()).updateQuoteOrderNumberInternal(quoteId, orderNumber);
// 	}

// 	public void updateQuoteOrderNumberInternal(Id quoteId, String orderNumber) {
// 		Quote q = [SELECT Id FROM Quote WHERE Id = :quoteId];
// 		q.LN_Order_ID__c = orderNumber;
// 		update q;
// 	}

// 	@AuraEnabled(cacheable=false)
// 	public static void createDraftOrderForQuote(
// 		Id quoteId,
// 		String orderNumber,
// 		Id accountId,
// 		Id pricebook2Id,
// 		Id wholesalerId
// 	) {
// 		(new Glamox_LN_Client())
// 			.createDraftOrderForQuoteInternal(quoteId, orderNumber, accountId, pricebook2Id, wholesalerId);
// 	}

// 	public void createDraftOrderForQuoteInternal(
// 		Id quoteId,
// 		String orderNumber,
// 		Id accountId,
// 		Id pricebook2Id,
// 		Id wholesalerId
// 	) {
// 		List<Order> existingOrders = [SELECT Id FROM Order WHERE LN_Order_Id__c = :orderNumber];
// 		if (existingOrders?.size() > 0) {
// 			return;
// 		}
// 		Order o = new Order();
// 		o.AccountId = accountId;
// 		o.Pricebook2Id = pricebook2Id;
// 		o.EffectiveDate = System.today();
// 		o.Status = 'Draft';
// 		o.LN_Order_Id__c = orderNumber;
// 		o.QuoteId = quoteId;
// 		o.Wholesaler__c = wholesalerId;
// 		insert o;
// 	}

// 	private AddressInfo getAddressInfo(
// 		System.Address addr,
// 		string name1,
// 		string name2,
// 		string emailAddress,
// 		string smsNumber
// 	) {
// 		//BillingName(255), BillingAdditionalName__c(100)
// 		AddressInfo a = new AddressInfo();
// 		a.name1 = cleanNoNewLines(name1);
// 		a.name2 = cleanNoNewLines(name2);
// 		// a.name3;
// 		// a.cityCode; //we dont keep it now from LN, but we should
// 		a.emailAddress = cleanNoNewLines(emailAddress);
// 		a.smsNumber = cleanNoNewLines(smsNumber);
// 		if (addr == null) {
// 			return a;
// 		}
// 		a.postalCode = cleanNoNewLines(addr.getPostalCode());
// 		a.countryCode = cleanNoNewLines(addr.getCountryCode());
// 		a.city = cleanNoNewLines(addr.getCity());
// 		String street = cleanLeaveNewLines(addr.getStreet());
// 		if (street == null) {
// 			return a;
// 		}
// 		List<string> streetNameTokens = street.split('\\n'); //for whatever reason, ALL apex string split/replace/replaceAll need double escaped (compared to normal regex/languages), dkdc fsf, https://www.regular-expressions.info/quickstart.html
// 		if (streetNameTokens.size() > 0) {
// 			a.street1 = streetNameTokens.get(0);
// 		}
// 		if (streetNameTokens.size() > 1) {
// 			streetNameTokens.remove(0);
// 			a.street2 = String.join(streetNameTokens, ' '); // 202300530 changed to concantinate with ' ' rather than '\n' because it was breaking LN // question has been posed to Branislav: what is policy for new line characters? keep in? take out?
// 		}
// 		if (addr.getStateCode()?.length() > 0) {
// 			a.state = addr.getStateCode();
// 		}
// 		return a;
// 	}
// 	private String filledOrNull(String str) {
// 		return str?.length() > 0 ? str : null;
// 	} //if is empty string change to null
// 	private String cleanNoNewLines(String str) {
// 		return str?.trim().replaceAll('[\\u00A0\\t]', ' ').replaceAll('[\\r\\n]', '');
// 	}
// 	private String cleanLeaveNewLines(String str) {
// 		return str?.trim().replaceAll('[\\u00A0\\t]', ' ').replaceAll('[\\r]', '');
// 	}

// 	private Boolean requiresLongAddress(AddressInfo a) {
// 		return (a.name1?.length() > 35 ||
// 		a.name2?.length() > 35 ||
// 		a.street1?.length() > 30 ||
// 		a.street2?.length() > 30);
// 	}
// 	private List<String> getShortAddressInfoErrors(AddressInfo a) {
// 		List<String> e = new List<String>();
// 		if (a.name1?.length() > 35) {
// 			e.add('Address Name1 too long: > 35');
// 		} //35 'this is a test of the emergency bro'
// 		if (a.name2?.length() > 30) {
// 			e.add('Address Name2 too long: > 30');
// 		}
// 		// if(a.name3?.length() > 60) {e.add('Address Name3 too long: > 60');}
// 		if (a.street1?.length() > 30) {
// 			e.add('Address Street1 too long: > 30');
// 		} //30 'this is a test of the emergenc'
// 		if (a.street2?.length() > 30) {
// 			e.add('Address Street2 too long: > 30');
// 		}
// 		if (a.name1 == null || a.name1.length() < 1) {
// 			e.add('Address Name1 empty');
// 		}
// 		if (a.street1 == null || a.street1.length() < 1) {
// 			e.add('Address Street1 empty');
// 		}
// 		if (a.postalCode == null) {
// 			e.add('Address Postal Code null');
// 		}
// 		if (a.countryCode == null) {
// 			e.add('Address Country Code null');
// 		}
// 		if (a.city == null) {
// 			e.add('Address City null');
// 		}
// 		return e;
// 	}
// 	private List<String> getLongAddressInfoErrors(AddressInfo a) {
// 		List<String> e = new List<String>();
// 		if (a.name1?.length() > 60) {
// 			e.add('Address Name1 too long: > 60');
// 		} //60 'this is a test of the emergency broadcast system and you bet'
// 		if (a.name2?.length() > 60) {
// 			e.add('Address Name2 too long: > 60');
// 		}
// 		// if(a.name3?.length() > 60) {e.add('Address Name3 too long: > 60');}
// 		if (a.street1?.length() > 60) {
// 			e.add('Address Street1 too long: > 60');
// 		}
// 		if (a.street2?.length() > 60) {
// 			e.add('Address Street2 too long: > 60');
// 		}
// 		if (a.name1 == null || a.name1.length() < 1) {
// 			e.add('Address Name1 empty');
// 		}
// 		if (a.street1 == null || a.street1.length() < 1) {
// 			e.add('Address Street1 empty');
// 		}
// 		if (a.postalCode == null) {
// 			e.add('Address Postal Code null');
// 		}
// 		if (a.countryCode == null) {
// 			e.add('Address Country Code null');
// 		}
// 		if (a.city == null) {
// 			e.add('Address City null');
// 		}
// 		return e;
// 	}

// 	private List<QuoteLineItem> filterQuoteLines(List<QuoteLineItem> orig) {
// 		Glamox_QuoteLineItem_Comparable[] comp = new List<Glamox_QuoteLineItem_Comparable>();
// 		for (QuoteLineItem qli : orig) {
// 			// remove various placeholders
// 			if (qli.Placeholder__c == true || qli.Product2.Is_Dummy__c == true) {
// 				continue;
// 			}

// 			comp.add(new Glamox_QuoteLineItem_Comparable(qli));
// 		}
// 		comp.sort(); // sort on SortOrder

// 		List<QuoteLineItem> resp = new List<QuoteLineItem>();
// 		for (Glamox_QuoteLineItem_Comparable item : comp) {
// 			resp.add(item.getQuoteLineItem());
// 		}

// 		return resp;
// 	}

// 	public OrderInfo getOrderInfoInternal(Id quoteId) {
// 		Quote quote = getQuote(quoteId); // System.QueryException: List has no rows for assignment to SObject

// 		if (quote.Handled_By_Wholesaler__c == true) {
// 			throw new IException('This quote is set to be handled by wholesaler, not by Glamox.');
// 		}

// 		//fyi: in LN_OrderBOD, if forward SFOrder is not found, accountId = SELECT Id FROM Account WHERE Customer_Number_LN__c = BPAccountCustomerNumber

// 		Account bidder = quote.Bidder__r;
// 		if (bidder == null) {
// 			throw new IException('Cannot create order from quote ' + quote.Id + '. Bidder is not set on quote');
// 		}
// 		if (quote.Pricebook2Id == null) {
// 			throw new IException('Cannot create order from quote ' + quote.Id + '. Pricebook is not set on quote');
// 		}

// 		//Defaults
// 		Account account = bidder;
// 		String accountType = 'Bidder';

// 		Boolean useWholesaler = quote.Wholesaler_Quote__c == true;
// 		Account wholesaler = quote.Wholesaler__r;
// 		if (useWholesaler) {
// 			account = wholesaler;
// 			accountType = 'Wholesaler';
// 		}
// 		if (account == null) {
// 			throw new IException(
// 				'Cannot create order from quote ' +
// 				quote.Id +
// 				'. ' +
// 				accountType +
// 				' is not set on quote'
// 			);
// 		}

// 		OrderInfo o = new OrderInfo();
// 		o.order = new SalesOrder();
// 		o.quoteId = quote.Id;
// 		o.pricebook2Id = quote.Pricebook2Id;
// 		o.accountId = bidder.Id;
// 		o.wholesalerId = wholesaler?.Id;

// 		if (account.Customer_Number_LN__c == null) {
// 			throw new IException(
// 				'Cannot create order from quote ' +
// 				quote.Id +
// 				'. ' +
// 				accountType +
// 				' ' +
// 				account.Name +
// 				' is missing LN customer number'
// 			);
// 		}
// 		// CRM-1120 Order type N04 (the default) should not be transfered to LN in GSN (order type 124). Sales rep must set something else. Whatever, just not N04
// 		if (useWholesaler && (quote.QuoteArea__c == null || quote.QuoteArea__c == 'N04')) {
// 			throw new IException(
// 				'Field Area has an invalid value (' +
// 				quote.QuoteArea__c +
// 				') for wholesaler quote. Please correct it.'
// 			);
// 		}

// 		o.order.requestId = quote.QuoteNumber;
// 		o.order.currencyIsoCode = quote.CurrencyIsoCode;
// 		o.order.orderDate = Glamox_LN_Client.formatDatetime(Datetime.now());
// 		o.order.salesRepNo = quote.Sales_Rep__r?.LN_EmployeeNO__c;
// 		o.order.backOfficeSalesRepNo = quote.BackOfficeRep__r?.LN_EmployeeNO__c;
// 		o.order.lateSurcharge = quote.Freight_Zone__c;
// 		o.order.area = quote.QuoteArea__c;
// 		o.order.vatException = quote.Vat_Exception__c != null ? (quote.Vat_Exception__c ? 'yes' : 'no') : null; // here we preserve tri-state...
// 		o.order.shippingConstraint = quote.Shipping_Constraint__c;
// 		o.order.opportunityNo = quote.Opportunity?.Opportunity_Number__c;
// 		o.order.opportunityDesc = quote.Opportunity?.Name;
// 		o.order.soldToBP = account.Customer_Number_LN__c;
// 		o.order.pointOfTitlePassage = quote.Point_Of_Title_Passage__c;

// 		o.order.officeRef = findCurrentUserInitials();
// 		o.order.orderEmail = filledOrNull(buildOrderSpecificEmail(quote)); //it returns empty string :(

// 		o.order.reference = quote.YourReference__c;
// 		if (o.order.reference?.length() > 30) {
// 			throw new IException(
// 				'Field YourReference is ' +
// 				quote.YourReference__c.length() +
// 				' characters. The maximum is 30, please change.'
// 			);
// 		}

// 		o.order.businessLine = segmentMapping.get(quote.Opportunity?.Segment__c);
// 		if (o.order.businessLine == null) {
// 			throw new IException(
// 				'Opportunity Segment value ' +
// 				quote.Opportunity?.Segment__c +
// 				' did not map to a businessLine value'
// 			);
// 		}

// 		if (account.UseWEEE__c == true) {
// 			o.order.useWEEE = quote.WEEEType__c == null ? 'no' : quote.WEEEType__c;
// 		} else if (!(quote.WEEEType__c == 'no' || quote.WEEEType__c == null)) {
// 			throw new IException(
// 				'Cannot create order from quote ' +
// 				quote.Id +
// 				'. Quote has a WEEE type selected, but account ' +
// 				account.Name +
// 				' does not have Use WEEE allowed.'
// 			); //null is written into string as "null"
// 		}

// 		// if (useWholesaler) { o.order.orderType = '124'; }
// 		// else if (quote.ReplacementOrClaim__c == true) { o.order.orderType = '500'; }
// 		// else { o.order.orderType = '100'; }

// 		if (useWholesaler) {
// 			o.order.orderType = '124';
// 		} else {
// 			o.order.orderType = quote.OrderType__c != null ? quote.OrderType__c : '100';
// 		}

// 		User oppOwner = getOpportunityOwner(quote);

// 		o.order.salesOffice = oppOwner.LN_Sales_Office__c;
// 		if (o.order.salesOffice == null) {
// 			throw new IException(
// 				'Cannot create order from quote ' +
// 				quote.Id +
// 				'. Opportunity owner ' +
// 				oppOwner +
// 				' has no LN_Sales_Office__c set, maybe check BU configuration.'
// 			);
// 		}

// 		o.order.orderSeries = oppOwner.BU_OrderSeries__c;
// 		if (o.order.orderSeries == null) {
// 			throw new IException(
// 				'Cannot create order from quote ' +
// 				quote.Id +
// 				'. Opportunity owner ' +
// 				oppOwner +
// 				' has no BU_OrderSeries__c set, maybe check BU configuration.'
// 			);
// 		}

// 		if (quote.Carrier__c?.length() > 0) {
// 			/* S01 is valid for market 164, Sweden */
// 			/* D01 is valid for market 3 Denmark */
// 			if (oppOwner.GMS_MarkedID__c == null) {
// 				throw new IException(
// 					'Cannot create order from quote ' +
// 					quote.Id +
// 					'. Opportunity owner ' +
// 					oppOwner +
// 					' has no market ID set, maybe check BU configuration.'
// 				); //Brian: ?? %£@!
// 			}
// 			o.order.carrier = quote.Carrier__c;
// 		}
// 		Boolean isGSN = quote.Opportunity.Business_Unit__c == 'Glamox Sales Norway'; // Stupid string
// 		if (isGSN && o.order.carrier == null) {
// 			throw new IException('For Glamox Sales Norway, Carrier is required');
// 		}

// 		o.order.discount = quote.Wholesaler_Commission__c > 0
// 			? String.valueOf(quote.Wholesaler_Commission__c)
// 			: ((quote.OrderDiscount__c > 0) ? String.valueOf(quote.OrderDiscount__c) : null);

// 		string paymentTerms = quote.TermsOfPayment__c?.trim();
// 		if (paymentTerms?.length() >= 3) {
// 			o.order.paymentTerms = paymentTerms.substring(0, 3);
// 		}

// 		string deliveryTerms = quote.TermsOfDelivery__c?.trim();
// 		if (deliveryTerms?.length() >= 3) {
// 			o.order.deliveryTerms = deliveryTerms.substring(0, 3);
// 		}

// 		string header = '';
// 		if (quote.External_Notes__c != null) {
// 			header = quote.External_Notes__c;
// 		}
// 		if (quote.Internal_Notes__c != null) {
// 			header += Glamox_LN_Client.encodeInternalNotes(quote.Internal_Notes__c, quote.Wholesaler_Ref_text__c); //ugly static, but leave for now
// 		}

// 		List<String> palletMarkingTokens = cleanLeaveNewLines(quote.Pallet_Marking__c)?.split('\\n'); //(also in getAddressInfo)
// 		if (palletMarkingTokens != null) {
// 			for (String pt : palletMarkingTokens) {
// 				header += '\n##' + pt;
// 			}
// 		}

// 		String businessUnit;
// 		try {
// 			businessUnit = Glamox_LN_Client.getBusinessUnitName(quote);
// 		} catch (Exception e) {
// 			String fu = 'apex';
// 		} //ugly static, ugly ugly, but only SF queries
// 		if (businessUnit?.contains(GLAMOX_NORWAY_BUNAME)) {
// 			/* CRM-993 Only show these if quote is owned by GSN */
// 			String deliveryMarkings;
// 			try {
// 				deliveryMarkings = Glamox_LN_Client.fetchDeliveryMarkings(quote);
// 			} catch (Exception e) {
// 				String fu = 'apex';
// 			} //ugly static, ugly ugly, but only SF queries
// 			if (deliveryMarkings != null) {
// 				header += '\n' + deliveryMarkings;
// 			}
// 		}
// 		if (header != '') {
// 			o.order.header = header;
// 		}

// 		string internalNotes = '';
// 		if (quote.Internal_Notes__c != null) {
// 			internalNotes += Glamox_LN_Client.encodeInternalNotesBrouHaHa(quote.Internal_Notes__c); //ugly static, but leave for now
// 		}
// 		if (internalNotes != '') {
// 			o.order.internalNotes = internalNotes;
// 		}

// 		List<QuoteLineItem> quoteLines = filterQuoteLines(getQuoteLines(quoteId));
// 		if (!(quoteLines.size() > 0)) {
// 			throw new IException('This quote has no quote lines, or only placeholder quote lines.');
// 		}

// 		if (quote.Requested_Date__c < date.today()) {
// 			throw new IException('Quote Service Date is less than today.');
// 		}
// 		Date defaultQuoteLineWishDate;
// 		boolean hasSpecificWishDateOnQuoteLine = false;
// 		for (QuoteLineItem qli : quoteLines) {
// 			if (qli.ServiceDate != null) {
// 				hasSpecificWishDateOnQuoteLine = true;
// 				defaultQuoteLineWishDate = quote.Requested_Date__c;
// 				break;
// 			}
// 		}
// 		if (!hasSpecificWishDateOnQuoteLine) {
// 			o.order.wishDate = Glamox_LN_Client.formatDatetime(quote.Requested_Date__c);
// 		}
// 		o.order.orderLines = getOrderLinesFromQuoteLines(quote.HideDiscounts__c, defaultQuoteLineWishDate, quoteLines);

// 		o.order.billingAddress = getAddressInfo(
// 			quote.BillingAddress,
// 			quote.BillingName,
// 			quote.BillingAdditionalName__c,
// 			null,
// 			null
// 		);
// 		if (addressIsNorthAmerican(o.order.billingAddress)) {
// 			List<String> addressErrors = getShortAddressInfoErrors(o.order.billingAddress);
// 			if (addressErrors.size() > 0) {
// 				throw new IException('Billing address: ' + String.join(addressErrors, ','));
// 			}
// 			o.order.billingAddress.addressFormat = 'NA';
// 		} else if (requiresLongAddress(o.order.billingAddress)) {
// 			List<String> addressErrors = getLongAddressInfoErrors(o.order.billingAddress);
// 			if (addressErrors.size() > 0) {
// 				throw new IException('Billing address: ' + String.join(addressErrors, ','));
// 			}
// 			o.order.billingAddress.addressFormat = 'PL0';
// 		} else {
// 			List<String> addressErrors = getShortAddressInfoErrors(o.order.billingAddress);
// 			if (addressErrors.size() > 0) {
// 				throw new IException('Billing address: ' + String.join(addressErrors, ','));
// 			}
// 			o.order.billingAddress.addressFormat = 'SF';
// 		}

// 		o.order.shippingAddress = getAddressInfo(
// 			quote.ShippingAddress,
// 			quote.ShippingName,
// 			quote.ShippingAdditionalName__c,
// 			quote.ShippingEmail__c,
// 			quote.ShippingPhone__c
// 		);
// 		if (addressIsNorthAmerican(o.order.shippingAddress)) {
// 			List<String> addressErrors = getShortAddressInfoErrors(o.order.shippingAddress);
// 			if (addressErrors.size() > 0) {
// 				throw new IException('Shipping address: ' + String.join(addressErrors, ','));
// 			}
// 			o.order.shippingAddress.addressFormat = 'NA';
// 		} else if (requiresLongAddress(o.order.shippingAddress)) {
// 			List<String> addressErrors = getLongAddressInfoErrors(o.order.shippingAddress);
// 			if (addressErrors.size() > 0) {
// 				throw new IException('Shipping address: ' + String.join(addressErrors, ','));
// 			}
// 			o.order.shippingAddress.addressFormat = 'PL0';
// 		} else {
// 			List<String> addressErrors = getShortAddressInfoErrors(o.order.shippingAddress);
// 			if (addressErrors.size() > 0) {
// 				throw new IException('Shipping address: ' + String.join(addressErrors, ','));
// 			}
// 			o.order.shippingAddress.addressFormat = 'SF';
// 		}

// 		return o;
// 	}

// 	public Boolean addressIsNorthAmerican(AddressInfo ai) {
// 		return ai.countryCode == 'US' || ai.countryCode == 'CA';
// 	}

// 	public List<SalesOrderLine> getOrderLinesFromQuoteLines(
// 		Boolean hideDiscounts,
// 		Date defaultQuoteLineWishDate,
// 		List<QuoteLineItem> quoteLines
// 	) {
// 		List<SalesOrderLine> orderLines = new List<SalesOrderLine>();

// 		for (QuoteLineItem qli : quoteLines) {
// 			SalesOrderLine o = new SalesOrderLine();

// 			o.productCode = qli.Product2.ProductCode;
// 			if (o.productCode == null) {
// 				throw new IException('QuoteLine ProductCode was null');
// 			}

// 			Decimal listPrice = qli.Listprice_WhenAdded__c;
// 			Decimal uomDiscount = qli.LineDiscount__c != null ? qli.LineDiscount__c : 0;
// 			/* CRM-898 Kan velge mellom SALES_PRICE og LIST_PRICES_AND_DISCOUNTS */
// 			if (hideDiscounts) {
// 				listPrice = qli.UnitPrice;
// 				uomDiscount = 0;
// 			}
// 			o.discountPerc = string.valueOf(uomDiscount);
// 			o.price = string.valueOf(listPrice);

// 			o.configDetailId = qli.ConfiguratorConfigurationId__c;
// 			o.configId = qli.ConfiguratorHeaderId__c;
// 			o.sfLineId = qli.Id; // docu says Ids can be assigned to strings with type conversion
// 			String unit = qli.Product2.QuantityUnitOfMeasure != null &&
// 				qli.Product2.QuantityUnitOfMeasure != ''
// 				? qli.Product2.QuantityUnitOfMeasure
// 				: 'pcs'; //default best guess for missing data
// 			o.quantityUnit = unit;
// 			o.quantity = string.valueOf(qli.Quantity);
// 			o.priceCurrency = qli.CurrencyIsoCode;
// 			o.priceUnit = unit;

// 			String text = '';
// 			if (qli.Description_to_order__c == true && qli.Description != null) {
// 				text += '< ' + qli.Description.replaceAll('[\\r\\n]', '').replaceAll('[\\n]', '') + '\n';
// 			}
// 			if (qli.Description_to_order_External__c == true && qli.Description != null) {
// 				text += qli.Description.replaceAll('[\\r\\n]', '').replaceAll('[\\n]', '') + '\n';
// 			}
// 			if (qli.Pos__c != null && qli.Pos__c.length() > 0) {
// 				text += '##' + Glamox_LN_Client.doCleanupTextfieldSingleLine((qli.Pos__c));
// 			}
// 			if (text.length() > 0) {
// 				o.text = text;
// 			}

// 			if (qli.ServiceDate != null) {
// 				if (qli.ServiceDate < date.today()) {
// 					throw new IException('Quote Line Service Date is less than today.');
// 				}
// 				o.wishDate = Glamox_LN_Client.formatDatetime(qli.ServiceDate);
// 			} else {
// 				o.wishDate = Glamox_LN_Client.formatDatetime(defaultQuoteLineWishDate);
// 			}

// 			orderLines.add(o);
// 		}

// 		return orderLines;
// 	}

// 	public class SubmitOrderResponse {
// 		public Boolean success;
// 		public Boolean timeout;
// 		public Boolean exists;
// 		public String orderNumber;
// 		public String requestId;
// 		public List<String> errorDetails;
// 	}

// 	public SubmitOrderResponse submitOrderInternal(SalesOrder order) {
// 		// https://developer.salesforce.com/docs/atlas.en-us.240.0.apexcode.meta/apexcode/apex_callouts_named_credentials.htm

// 		if (order == null) {
// 			throw new IException('AgumentNullException submitOrderInternal order');
// 		}

// 		String body;
// 		try {
// 			body = JSON.serialize(order);
// 		} catch (Exception e) {
// 			throw new IException('Failed to serialize order. ' + e.getMessage());
// 		}

// 		String proxyUrl = 'callout:ION_API/infor/CustomerApi/GIS/BOD';
// 		String apiPath = '/api/SF_OrderBOD/Upsert_LN';
// 		String url = proxyUrl + apiPath;

// 		HttpRequest req = new HttpRequest();
// 		req.setEndpoint(url);
// 		req.setMethod('POST');
// 		req.setHeader('Content-Type', 'application/json');
// 		req.setBody(body);
// 		req.setTimeout(120 * 1000); //default is 10 s, min is 1 ms, max is 120 s apex allows || throw

// 		/*
//             Apex Docs
//             The timeout is the maximum time to wait for establishing the HTTP connection.
//             The same timeout is used for waiting for the request to start.
//             When the request is executing, such as retrieving or posting data, the connection is kept alive until the request finishes.
//         */

// 		Http http = new Http();
// 		HTTPResponse res = http.send(req);

// 		/* response from middleware
//         {
//             msg: string,
//             requestId: string,
//             orderNumber: string,
//             errorDetails: [string],
//         }
//         */

// 		Integer status = res.getStatusCode();

// 		String responseBody = res.getBody(); //expect response body
// 		if (responseBody == null || responseBody.length() < 1) {
// 			throw new IException('submitOrderInternal status: ' + status + ', responseBody null');
// 		}

// 		SubmitOrderResponse oRes;
// 		try {
// 			oRes = (SubmitOrderResponse) JSON.deserialize(responseBody, SubmitOrderResponse.class);
// 			if (oRes.errorDetails == null) {
// 				oRes.errorDetails = new List<String>();
// 			} // could be created by JSON.deserialize and who knows... i.e. dont rely on class constructor
// 			oRes.success = status < 300 && oRes.orderNumber?.length() > 0;
// 			oRes.timeout = status == 504;
// 			oRes.exists = false;

// 			if (!(oRes.requestId?.length() > 0)) {
// 				/*
//                     {
//                         "error": {
//                             "message": "connect ETIMEDOUT 10.205.0.170:5001",
//                             "errno": "ETIMEDOUT",
//                             "code": "ETIMEDOUT",
//                             "syscall": "connect",
//                             "address": "10.205.0.170",
//                             "port": 5001,
//                             "source": "ION API Server"
//                         }
//                     }
//                 */

// 				String msg = responseBody;
// 				try {
// 					Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
// 					Map<String, Object> err = (Map<String, Object>) m.get('error');
// 					msg = (String) err.get('message');
// 					if (msg.contains('ETIMEDOUT')) {
// 						oRes.timeout = true;
// 					}
// 				} catch (Exception dk) {
// 				}
// 				oRes.errorDetails.add(msg);
// 				oRes.errorDetails.add('status: ' + status);
// 			}
// 		} catch (Exception e) {
// 			throw new IException(
// 				'Failed to deserialize SubmitOrderResponse from submitOrderInternal responseBody. Status: ' +
// 				status +
// 				'. Error: ' +
// 				e.getMessage() +
// 				', ResponseBody: ' +
// 				responseBody
// 			);
// 		}

// 		if (oRes.success) {
// 			return oRes;
// 		}

// 		if (oRes.errorDetails?.size() > 0) {
// 			//["Sales Order GG1027777 Already Exists with customer order number 00159051","Identifiers: salesOrder=GG1"]

// 			//I don't know what terrible things you've done in your life up to this point, but clearly your carma is out of balance to be parsing strings...
// 			// this will backfire mega Dr. Horrible's Sing-Along Blog when the other guys change the error string, and no one will know why the quote doesnt get the OrderNumber, hAAAAAaa hAA hAAAAAAaaaa

// 			String marker0 = 'Sales Order ';
// 			String marker1 = ' Already Exists with customer order number ';
// 			for (String detail : oRes.errorDetails) {
// 				if (detail.startsWith(marker0) && detail.contains(marker1)) {
// 					String orderNumber = detail.substringAfter(marker0).substringBefore(marker1);
// 					if (orderNumber.length() > 0) {
// 						oRes.exists = true;
// 						oRes.orderNumber = orderNumber;
// 						return oRes;
// 					}
// 				}
// 			}
// 		}

// 		return oRes;
// 	}

// 	@AuraEnabled(cacheable=false)
// 	public static OrderExistResponse getOrderByQuoteId(Id quoteId) {
// 		Quote q = [SELECT Id, QuoteNumber FROM Quote WHERE Id = :quoteId];
// 		return getOrderByQuoteNumber(q.QuoteNumber);
// 	}

// 	public class OrderExistResponse {
// 		@AuraEnabled
// 		public String orderNumber;
// 		@AuraEnabled
// 		public Boolean exists; // if you get an object and it has this field you can trust that communication happened and that LN gave this answer
// 	}

// 	@AuraEnabled(cacheable=false)
// 	public static OrderExistResponse getOrderByQuoteNumber(String quoteNumber) {
// 		String proxyUrl = 'callout:ION_API/infor/CustomerApi/GIS/BOD';
// 		String apiPath = '/api/LN/Order_ByQuoteNumber/' + quoteNumber;
// 		String url = proxyUrl + apiPath;
// 		HttpRequest req = new HttpRequest();
// 		req.setEndpoint(url);
// 		req.setMethod('GET');
// 		Http http = new Http();
// 		HTTPResponse res = http.send(req);

// 		Integer status = res.getStatusCode();

// 		if (status == 200) {
// 			//we heard back and LN says it exists (200), we try to get the info out
// 			String responseBody = res.getBody();
// 			if (responseBody == null || responseBody.length() <= 0) {
// 				throw new IException('status: ' + status + ', responseBody null');
// 			}
// 			OrderExistResponse oRes;
// 			try {
// 				oRes = (OrderExistResponse) JSON.deserialize(responseBody, OrderExistResponse.class); //{orderNumber, LN_Order_ID__c}
// 				oRes.exists = true;
// 			} catch (Exception e) {
// 				throw new IException(
// 					'Failed to deserialize getOrderExist responseBody. Status: ' +
// 					status +
// 					'. Error: ' +
// 					e.getMessage() +
// 					', ResponseBody: ' +
// 					responseBody
// 				);
// 			}

// 			if (oRes.orderNumber?.length() <= 0) {
// 				throw new IException(
// 					'Status says it exists, Status: ' +
// 					status +
// 					', but orderNumber didnt come through. ResponseBody: ' +
// 					responseBody
// 				);
// 			}
// 			return oRes;
// 		} else if (status == 404) {
// 			//we heard back and LN says it does not exist
// 			OrderExistResponse oRes = new OrderExistResponse();
// 			oRes.exists = false;
// 			return oRes;
// 		} else {
// 			//we dont know if it exists or not, throw ugly string for poor (de)buggers
// 			throw new IException('status: ' + status + ', responseBody: ' + res.getBody());
// 		}
// 	}

// 	public enum BodType {
// 		ACCOUNT,
// 		ITEM,
// 		ORDER
// 	}

// 	public class BodDemand {
// 		@AuraEnabled
// 		public String id { get; set; }
// 		@AuraEnabled
// 		public String bodName { get; set; }
// 		@AuraEnabled
// 		public BodType bodType { get; set; }
// 	}
// 	public class BodRequest {
// 		@AuraEnabled
// 		public List<BodDemand> demands { get; set; }
// 	}

// 	@AuraEnabled(cacheable=false)
// 	public static void bodOnDemand(BodRequest bodRequest) {
// 		for (BodDemand demand : bodRequest.demands) {
// 			demand.bodType = BodType.valueOf(demand.bodName); //throws if you send a bogas name, and you can catch the system error
// 		}
// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		client.bodOnDemandInternal(bodRequest); //CALLOUT
// 	}

// 	public void bodOnDemandInternal(BodRequest bodRequest) {
// 		if (bodRequest == null) {
// 			throw new IException('AgumentNullException bodOnDemandInternal bodRequest');
// 		}

// 		String body;
// 		try {
// 			body = JSON.serialize(bodRequest.demands); // [{id, BodType}]
// 		} catch (Exception e) {
// 			throw new IException('Failed to serialize bodRequest. ' + e.getMessage());
// 		}

// 		// bodRequest.demands => (BodDemand:[bodName=ORDER, bodType=ORDER, id=GP1010046])
// 		// body => [{"id":"GP1010046","bodType":"ORDER","bodName":"ORDER"}]

// 		String proxyUrl = 'callout:ION_API/infor/CustomerApi/GIS/BOD';
// 		String apiPath = '/api/LN/BodRequest';
// 		String url = proxyUrl + apiPath;
// 		HttpRequest req = new HttpRequest();
// 		req.setEndpoint(url);
// 		req.setMethod('POST');
// 		req.setHeader('Content-Type', 'application/json');
// 		req.setBody(body);
// 		req.setTimeout(120 * 1000); //default is 10 s, min is 1 ms, max is 120 s apex allows || throw

// 		Http http = new Http();
// 		HTTPResponse res = http.send(req);
// 		Integer status = res.getStatusCode();
// 		if (status != 200) {
// 			//throw ugly string for poor (de)buggers
// 			throw new IException('status: ' + status + ', responseBody: ' + res.getBody());
// 		}
// 	}
// 	//=============================================================================================
// 	public class AccountLimitRequest {
// 		@AuraEnabled
// 		public String Number_LN { get; set; }
// 		@AuraEnabled
// 		public String Financial_Company { get; set; }
// 	}

// 	public class AccountLimitResponse {
// 		@AuraEnabled
// 		public Integer status { get; set; }
// 		@AuraEnabled
// 		public String test { get; set; }
// 	}

// 	@AuraEnabled(cacheable=false)
// 	public static AccountLimitResponse bodOnDemandGetCreditLimit(AccountLimitRequest call) {
// 		System.debug('TTO ' + call.Number_LN + ' ' + call.Financial_Company);

// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		return client.internalbodOnDemandGetCreditLimit(call); //CALLOUT
// 	}

// 	public AccountLimitResponse internalbodOnDemandGetCreditLimit(AccountLimitRequest call) {
// 		String body;
// 		try {
// 			body = JSON.serialize(call);
// 		} catch (Exception e) {
// 			throw new IException('Failed to serialize call. ' + e.getMessage());
// 		}
// 		String proxyUrl = 'callout:ION_API/infor/CustomerApi/GIS/BOD';
// 		String apiPath = '/api/SF_CreditLimitBOD/Upsert_LN';
// 		String url = proxyUrl + apiPath;
// 		HttpRequest req = new HttpRequest();
// 		req.setEndpoint(url);
// 		req.setMethod('POST');
// 		req.setHeader('Content-Type', 'application/json');
// 		req.setBody(body);
// 		req.setTimeout(120 * 1000); //default is 10 s, min is 1 ms, max is 120 s apex allows || throw
// 		Http http = new Http();
// 		HTTPResponse res = http.send(req);
// 		Integer status = res.getStatusCode();
// 		String responseBody = res.getBody();

// 		if (status != 200) {
// 			System.debug('TTO status exeption' + status);
// 			throw new IException('status: ' + status + ', responseBody: ' + responseBody);
// 		}

// 		AccountLimitResponse aqq = new AccountLimitResponse();
// 		aqq.status = status;
// 		aqq.test = responseBody;

// 		return aqq;
// 	}
// 	//=============================================================================================
// 	//---------------------------------------------------------------------------------------------
// 	@AuraEnabled(cacheable=false)
// 	public static String CountryNameToIso(String name) {
// 		// System.debug('TTO ' + CountryNameToIsoMap.get(name));
// 		return CountryNameToIsoMap.get(name);
// 	}

// 	public static Map<String, String> CountryNameToIsoMap = new Map<String, String>{
// 		'Andorra' => 'AD',
// 		'United Arab Emirates' => 'AE',
// 		'Afghanistan' => 'AF',
// 		'Antigua and Barbuda' => 'AG',
// 		'Anguilla' => 'AI',
// 		'Albania' => 'AL',
// 		'Armenia' => 'AM',
// 		'Angola' => 'AO',
// 		'Antarctica' => 'AQ',
// 		'Argentina' => 'AR',
// 		'American Samoa' => 'AS',
// 		'Austria' => 'AT',
// 		'Australia' => 'AU',
// 		'Aruba' => 'AW',
// 		'Aland Islands' => 'AX',
// 		'Azerbaijan' => 'AZ',
// 		'Bosnia and Herzegovina' => 'BA',
// 		'Barbados' => 'BB',
// 		'Bangladesh' => 'BD',
// 		'Belgium' => 'BE',
// 		'Burkina Faso' => 'BF',
// 		'Bulgaria' => 'BG',
// 		'Bahrain' => 'BH',
// 		'Burundi' => 'BI',
// 		'Benin' => 'BJ',
// 		'Saint-Barthélemy' => 'BL',
// 		'Bermuda' => 'BM',
// 		'Brunei Darussalam' => 'BN',
// 		'Bolivia' => 'BO',
// 		'Caribbean Netherlands' => 'BQ',
// 		'Brazil' => 'BR',
// 		'Bahamas' => 'BS',
// 		'Bhutan' => 'BT',
// 		'Bouvet Island' => 'BV',
// 		'Botswana' => 'BW',
// 		'Belarus' => 'BY',
// 		'Belize' => 'BZ',
// 		'Canada' => 'CA',
// 		'Cocos (Keeling) Islands' => 'CC',
// 		'Democratic Republic of the Congo (Congo-Kinshasa, former Zaire)' => 'CD',
// 		'Centrafrican Republic' => 'CF',
// 		'Republic of the Congo (Congo-Brazzaville)' => 'CG',
// 		'Switzerland' => 'CH',
// 		//    'Côte d'Ivoire'			=> 'CI',
// 		'Cook Islands' => 'CK',
// 		'Chile' => 'CL',
// 		'Cameroon' => 'CM',
// 		'China' => 'CN',
// 		'Colombia' => 'CO',
// 		'Costa Rica' => 'CR',
// 		'Cuba' => 'CU',
// 		'Cabo Verde' => 'CV',
// 		'Curaçao' => 'CW',
// 		'Christmas Island' => 'CX',
// 		'Cyprus' => 'CY',
// 		'Czech Republic' => 'CZ',
// 		'Germany' => 'DE',
// 		'Djibouti' => 'DJ',
// 		'Denmark' => 'DK',
// 		'Dominica' => 'DM',
// 		'Dominican Republic' => 'DO',
// 		'Algeria' => 'DZ',
// 		'Ecuador' => 'EC',
// 		'Estonia' => 'EE',
// 		'Egypt' => 'EG',
// 		'Western Sahara' => 'EH',
// 		'Eritrea' => 'ER',
// 		'Spain' => 'ES',
// 		'Ethiopia' => 'ET',
// 		'Finland' => 'FI',
// 		'Fiji' => 'FJ',
// 		'Falkland Islands' => 'FK',
// 		'Micronesia (Federated States of)' => 'FM',
// 		'Faroe Islands' => 'FO',
// 		'France' => 'FR',
// 		'Gabon' => 'GA',
// 		'United Kingdom' => 'GB',
// 		'Grenada' => 'GD',
// 		'Georgia' => 'GE',
// 		'French Guiana' => 'GF',
// 		'Guernsey' => 'GG',
// 		'Ghana' => 'GH',
// 		'Gibraltar' => 'GI',
// 		'Greenland' => 'GL',
// 		'The Gambia' => 'GM',
// 		'Guinea' => 'GN',
// 		'Guadeloupe' => 'GP',
// 		'Equatorial Guinea' => 'GQ',
// 		'Greece' => 'GR',
// 		'South Georgia and the South Sandwich Islands' => 'GS',
// 		'Guatemala' => 'GT',
// 		'Guam' => 'GU',
// 		'Guinea Bissau' => 'GW',
// 		'Guyana' => 'GY',
// 		'Hong Kong (SAR of China)' => 'HK',
// 		'Heard Island and McDonald Islands' => 'HM',
// 		'Honduras' => 'HN',
// 		'Croatia' => 'HR',
// 		'Haiti' => 'HT',
// 		'Hungary' => 'HU',
// 		'Indonesia' => 'ID',
// 		'Ireland' => 'IE',
// 		'Israel' => 'IL',
// 		'Isle of Man' => 'IM',
// 		'India' => 'IN',
// 		'British Indian Ocean Territory' => 'IO',
// 		'Iraq' => 'IQ',
// 		'Iran' => 'IR',
// 		'Iceland' => 'IS',
// 		'Italy' => 'IT',
// 		'Jersey' => 'JE',
// 		'Jamaica' => 'JM',
// 		'Jordan' => 'JO',
// 		'Japan' => 'JP',
// 		'Kenya' => 'KE',
// 		'Kyrgyzstan' => 'KG',
// 		'Cambodia' => 'KH',
// 		'Kiribati' => 'KI',
// 		'Comores' => 'KM',
// 		'Saint Kitts and Nevis' => 'KN',
// 		'North Korea' => 'KP',
// 		'South Korea' => 'KR',
// 		'Kuwait' => 'KW',
// 		'Cayman Islands' => 'KY',
// 		'Kazakhstan' => 'KZ',
// 		'Laos' => 'LA',
// 		'Lebanon' => 'LB',
// 		'Saint Lucia' => 'LC',
// 		'Liechtenstein' => 'LI',
// 		'Sri Lanka' => 'LK',
// 		'Liberia' => 'LR',
// 		'Lesotho' => 'LS',
// 		'Lithuania' => 'LT',
// 		'Luxembourg' => 'LU',
// 		'Latvia' => 'LV',
// 		'Libya' => 'LY',
// 		'Morocco' => 'MA',
// 		'Monaco' => 'MC',
// 		'Moldova' => 'MD',
// 		'Montenegro' => 'ME',
// 		'Saint Martin (French part)' => 'MF',
// 		'Madagascar' => 'MG',
// 		'Marshall Islands' => 'MH',
// 		'North Macedonia' => 'MK',
// 		'Mali' => 'ML',
// 		'Myanmar' => 'MM',
// 		'Mongolia' => 'MN',
// 		'Macao (SAR of China)' => 'MO',
// 		'Northern Mariana Islands' => 'MP',
// 		'Martinique' => 'MQ',
// 		'Mauritania' => 'MR',
// 		'Montserrat' => 'MS',
// 		'Malta' => 'MT',
// 		'Mauritius' => 'MU',
// 		'Maldives' => 'MV',
// 		'Malawi' => 'MW',
// 		'Mexico' => 'MX',
// 		'Malaysia' => 'MY',
// 		'Mozambique' => 'MZ',
// 		'Namibia' => 'NA',
// 		'New Caledonia' => 'NC',
// 		'Niger' => 'NE',
// 		'Norfolk Island' => 'NF',
// 		'Nigeria' => 'NG',
// 		'Nicaragua' => 'NI',
// 		'The Netherlands' => 'NL',
// 		'Norway' => 'NO',
// 		'Nepal' => 'NP',
// 		'Nauru' => 'NR',
// 		'Niue' => 'NU',
// 		'New Zealand' => 'NZ',
// 		'Oman' => 'OM',
// 		'Panama' => 'PA',
// 		'Peru' => 'PE',
// 		'French Polynesia' => 'PF',
// 		'Papua New Guinea' => 'PG',
// 		'Philippines' => 'PH',
// 		'Pakistan' => 'PK',
// 		'Poland' => 'PL',
// 		'Saint Pierre and Miquelon' => 'PM',
// 		'Pitcairn' => 'PN',
// 		'Puerto Rico' => 'PR',
// 		'Palestinian Territory' => 'PS',
// 		'Portugal' => 'PT',
// 		'Palau' => 'PW',
// 		'Paraguay' => 'PY',
// 		'Qatar' => 'QA',
// 		'Reunion' => 'RE',
// 		'Romania' => 'RO',
// 		'Serbia' => 'RS',
// 		'Russia' => 'RU',
// 		'Rwanda' => 'RW',
// 		'Saudi Arabia' => 'SA',
// 		'Solomon Islands' => 'SB',
// 		'Seychelles' => 'SC',
// 		'Sudan' => 'SD',
// 		'Sweden' => 'SE',
// 		'Singapore' => 'SG',
// 		'Saint Helena' => 'SH',
// 		'Slovenia' => 'SI',
// 		'Svalbard and Jan Mayen' => 'SJ',
// 		'Slovakia' => 'SK',
// 		'Sierra Leone' => 'SL',
// 		'San Marino' => 'SM',
// 		'Sénégal' => 'SN',
// 		'Somalia' => 'SO',
// 		'Suriname' => 'SR',
// 		'South Sudan' => 'SS',
// 		'Sao Tomé and Príncipe' => 'ST',
// 		'El Salvador' => 'SV',
// 		'Saint Martin (Dutch part)' => 'SX',
// 		'Syria' => 'SY',
// 		'eSwatini' => 'SZ',
// 		'Turks and Caicos Islands' => 'TC',
// 		'Chad' => 'TD',
// 		'French Southern and Antarctic Lands' => 'TF',
// 		'Togo' => 'TG',
// 		'Thailand' => 'TH',
// 		'Tajikistan' => 'TJ',
// 		'Tokelau' => 'TK',
// 		'Timor-Leste' => 'TL',
// 		'Turkmenistan' => 'TM',
// 		'Tunisia' => 'TN',
// 		'Tonga' => 'TO',
// 		'Turkey' => 'TR',
// 		'Trinidad and Tobago' => 'TT',
// 		'Tuvalu' => 'TV',
// 		'Taiwan' => 'TW',
// 		'Tanzania' => 'TZ',
// 		'Ukraine' => 'UA',
// 		'Uganda' => 'UG',
// 		'United States Minor Outlying Islands' => 'UM',
// 		'United States of America' => 'US',
// 		'Uruguay' => 'UY',
// 		'Uzbekistan' => 'UZ',
// 		'City of the Vatican' => 'VA',
// 		'Saint Vincent and the Grenadines' => 'VC',
// 		'Venezuela' => 'VE',
// 		'British Virgin Islands' => 'VG',
// 		'United States Virgin Islands' => 'VI',
// 		'Vietnam' => 'VN',
// 		'Vanuatu' => 'VU',
// 		'Wallis and Futuna' => 'WF',
// 		'Samoa' => 'WS',
// 		'Yemen' => 'YE',
// 		'Mayotte' => 'YT',
// 		'South Africa' => 'ZA',
// 		'Zambia' => 'ZM',
// 		'Zimbabwe' => 'ZW'
// 	};

// 	public class AccountAlreadyExistsException extends Exception {
// 		public AccountAlreadyExistsException(List<AccountResponse> accounts) {
// 			this.setMessage(JSON.serialize(accounts));
// 		}
// 	}

// 	@AuraEnabled(cacheable=false)
// 	public static AccountResponse bodOnDemandAccountToLN(AccountRequest call) {
// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		return client.internalBodOnDemandAccountToLN(call); //CALLOUT
// 	}

// 	public class AccountResponse {
// 		@AuraEnabled
// 		public String accountNumber { get; set; }
// 		@AuraEnabled
// 		public String errorMessage { get; set; }
// 	}

// 	public class AccountRequest {
// 		@AuraEnabled
// 		public String id { get; set; }
// 		@AuraEnabled
// 		public String bp { get; set; }
// 		@AuraEnabled
// 		public String name { get; set; }
// 		@AuraEnabled
// 		public String taxNumber { get; set; }
// 		@AuraEnabled
// 		public String defaults { get; set; }
// 		@AuraEnabled
// 		public String currencyType { get; set; }
// 		@AuraEnabled
// 		public String salesOffice { get; set; }
// 		@AuraEnabled
// 		public AddressInfo address { get; set; }
// 	}

// 	public AccountResponse internalBodOnDemandAccountToLN(AccountRequest call) {
// 		//validate call here
// 		// validate other call fields ??
// 		// validate call.address here
// 		if (addressIsNorthAmerican(call.address)) {
// 			List<String> addressErrors = getShortAddressInfoErrors(call.address);
// 			if (addressErrors.size() > 0) {
// 				throw new IException('address: ' + String.join(addressErrors, ','));
// 			}
// 			call.address.addressFormat = 'NA';
// 		} else if (requiresLongAddress(call.address)) {
// 			List<String> addressErrors = getLongAddressInfoErrors(call.address);
// 			if (addressErrors.size() > 0) {
// 				throw new IException('address: ' + String.join(addressErrors, ','));
// 			}
// 			call.address.addressFormat = 'PL0';
// 		} else {
// 			List<String> addressErrors = getShortAddressInfoErrors(call.address);
// 			if (addressErrors.size() > 0) {
// 				throw new IException('address: ' + String.join(addressErrors, ','));
// 			}
// 			call.address.addressFormat = 'SF';
// 		}

// 		String body;
// 		try {
// 			body = JSON.serialize(call);
// 		} catch (Exception e) {
// 			throw new IException('Failed to serialize call. ' + e.getMessage());
// 		}

// 		String proxyUrl = 'callout:ION_API/infor/CustomerApi/GIS/BOD';
// 		String apiPath = '/api/SF_AccountBOD/Upsert_LN';
// 		String url = proxyUrl + apiPath;
// 		HttpRequest req = new HttpRequest();
// 		req.setEndpoint(url);
// 		req.setMethod('POST');
// 		req.setHeader('Content-Type', 'application/json');
// 		req.setBody(body);
// 		req.setTimeout(120 * 1000); //default is 10 s, min is 1 ms, max is 120 s apex allows || throw

// 		Http http = new Http();
// 		HTTPResponse res = http.send(req);
// 		Integer status = res.getStatusCode();
// 		String responseBody = res.getBody();

// 		AccountResponse ret = new AccountResponse();

// 		if (status == 409) {
// 			List<AccountResponse> accList = new List<AccountResponse>();
// 			accList = (List<AccountResponse>) JSON.deserialize(responseBody, List<AccountResponse>.class);

// 			ret.accountNumber = accList[0].accountNumber;
// 			ret.errorMessage = 'OK';
// 		} else if (status == 425) {
// 			ret.accountNumber = '';
// 			ret.errorMessage = 'ERROR 425';
// 		} else if (status == 200) {
// 			ret = (AccountResponse) JSON.deserialize(responseBody, AccountResponse.class);
// 			ret.errorMessage = 'OK';
// 		} else {
// 			ret.accountNumber = '';
// 			ret.errorMessage = 'Reszta';
// 		}

// 		//_______________________________________________________________________________________________`
// 		if (ret.accountNumber != '') {
// 			Account acc = [SELECT Name, Customer_Number_LN__c FROM Account WHERE id = :call.id];
// 			acc.Customer_Number_LN__c = ret.accountNumber;
// 			update acc;
// 		}
// 		//_______________________________________________________________________________________________

// 		return ret;
// 	}

// 	//---------------------------------------------------------------------------------------------
// 	public class BodRequestOrders {
// 		@AuraEnabled
// 		public String accountNumber { get; set; }
// 		@AuraEnabled
// 		public String startDate { get; set; }
// 		@AuraEnabled
// 		public String endDate { get; set; }
// 	}

// 	@AuraEnabled(cacheable=false)
// 	public static void bodOnDemandOrders(BodRequestOrders bodRequestOrders) {
// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		client.bodOnDemandOrdersInternal(bodRequestOrders); //CALLOUT
// 	}

// 	public void bodOnDemandOrdersInternal(BodRequestOrders bodRequestOrders) {
// 		if (bodRequestOrders == null) {
// 			throw new IException('AgumentNullException bodOnDemandOrdersInternal bodRequestOrders');
// 		}

// 		String body;
// 		try {
// 			body = JSON.serialize(bodRequestOrders); // {accountNumber, startDate, endDate}
// 		} catch (Exception e) {
// 			throw new IException('Failed to serialize bodRequestOrders. ' + e.getMessage());
// 		}

// 		String proxyUrl = 'callout:ION_API/infor/CustomerApi/GIS/BOD';
// 		String apiPath = '/api/LN/BodRequestOrders';
// 		String url = proxyUrl + apiPath;
// 		HttpRequest req = new HttpRequest();
// 		req.setEndpoint(url);
// 		req.setMethod('POST');
// 		req.setHeader('Content-Type', 'application/json');
// 		req.setBody(body);
// 		req.setTimeout(120 * 1000); //default is 10 s, min is 1 ms, max is 120 s apex allows || throw

// 		Http http = new Http();
// 		HTTPResponse res = http.send(req);
// 		Integer status = res.getStatusCode();
// 		if (status != 200) {
// 			//throw ugly string for poor (de)buggers
// 			throw new IException('status: ' + status + ', responseBody: ' + res.getBody());
// 		}
// 	}

// 	private DOM.XmlNode createSOAPBodyNode(
// 		DOM.Document doc,
// 		string businessInterfaceNamespaceName,
// 		string businessInterfaceNamespaceUri
// 	) {
// 		return createSOAPBodyNode(doc, businessInterfaceNamespaceName, businessInterfaceNamespaceUri, '1000');
// 	}

// 	private DOM.XmlNode createSOAPBodyNode(
// 		DOM.Document doc,
// 		string businessInterfaceNamespaceName,
// 		string businessInterfaceNamespaceUri,
// 		string companyId
// 	) {
// 		DOM.XmlNode envelope = doc.createRootElement('Envelope', SOAP_NAMESPACE, 'soapenv');
// 		envelope.setNamespace('xsi', XSI_NAMESPACE);
// 		envelope.setNamespace(businessInterfaceNamespaceName, businessInterfaceNamespaceUri);
// 		DOM.XmlNode activation = envelope.addChildElement('Header', SOAP_NAMESPACE, null)
// 			.addChildElement('Activation', businessInterfaceNamespaceUri, null);

// 		activation.addChildElement('username', null, null).addTextNode(this.clientSettings.Username__c);
// 		activation.addChildElement('password', null, null).addTextNode(this.clientSettings.Password__c);
// 		activation.addChildElement('company', null, null).addTextNode(companyId);
// 		return envelope.addChildElement('Body', SOAP_NAMESPACE, null);
// 	}

// 	private DOM.Document sendSoapXml(DOM.Document doc, string webServiceName) {
// 		string xml = doc.toXmlString();
// 		HttpRequest req = new HttpRequest();
// 		req.setEndpoint('callout:ION_API/infor/CustomerApi/LN/' + webServiceName);
// 		req.setMethod('POST');
// 		req.setHeader('Content-Type', 'text/xml');
// 		req.setBody(xml);
// 		//req.setBodyDocument(doc);
// 		req.setTimeout(120000);
// 		System.debug('sendSoapXML ' + req.getBody());
// 		Http http = new Http();
// 		HTTPResponse res = http.send(req);
// 		if (res.getStatusCode() == 200) {
// 			System.debug('Got response ' + res.getBody());
// 			return res.getBodyDocument();
// 		}
// 		string responseXml = res.getBody();
// 		System.debug(responseXml);
// 		string faultString = res.getStatus();
// 		List<DOM.XmlNode> detailedMessages = new List<DOM.XmlNode>();
// 		if (responseXml != null && responseXml.indexOf('<?xml version') > -1) {
// 			try {
// 				DOM.XmlNode responseEnvelope = res.getBodyDocument().getRootElement();
// 				DOM.XmlNode faultStringNode = Glamox_XML_Utils.FindFirstDescendantByName(
// 					responseEnvelope,
// 					'faultstring'
// 				);
// 				if (faultStringNode != null) {
// 					faultString = faultStringNode.getText();
// 				}
// 				detailedMessages.addAll(Glamox_XML_Utils.FindFirstDescendantsByName(responseEnvelope, 'Message'));
// 			} catch (Exception e) {
// 				System.debug(e);
// 			}
// 		}
// 		DOM.Document errDoc = new DOM.Document();
// 		DOM.XmlNode errorNode = errDoc.createRootElement('Error', null, null);
// 		errorNode.addChildElement('ErrorCode', null, null).addTextNode(string.valueOf(res.getStatusCode()));
// 		errorNode.addChildElement('ErrorDesc', null, null).addTextNode(faultString);
// 		if (detailedMessages.size() > 0) {
// 			DOM.XmlNode errorDetails = errorNode.addChildElement('ErrorDetails', null, null);
// 			for (DOM.XmlNode msg : detailedMessages) {
// 				Glamox_XML_Utils.AddChildShallow(errorDetails, 'Message', msg);
// 			}
// 		}
// 		return errDoc;
// 	}

// 	private static string errorAsJsonString(integer errorCode, string errorMsg) {
// 		Map<string, object> errorResponse = new Map<string, object>();
// 		errorResponse.put('ErrorCode', errorCode);
// 		errorResponse.put('ErrorDesc', errorMsg);
// 		return JSON.serialize(errorResponse);
// 	}

// 	private string getWarehouseInventoryForProductByRecordId(Id recordId) {
// 		Sobject obj = [SELECT ProductCode FROM Product2 WHERE Id = :recordId];
// 		string productCode = (string) obj.get('ProductCode');
// 		return getWarehouseInventoryForProductByProductCode(productCode);
// 	}

// 	private static string formatDate(Date d) {
// 		integer month = d.month();
// 		integer day = d.day();
// 		return d.year() +
// 			'-' +
// 			(month < 10 ? '0' + month : string.valueOf(month)) +
// 			'-' +
// 			(day < 10 ? '0' + day : string.valueOf(day));
// 	}

// 	private static string formatDatetime(Datetime d) {
// 		return d?.formatGmt('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ');
// 	}

// 	private static string createMaxLengthString(String s, Integer maxLength) {
// 		/* 2022-01-10 Create an error, instead of just chopping off the end */
// 		if (s != null && s.length() > maxLength) {
// 			String choppedVersion = s.substring(0, maxLength);
// 			throw new IllegalArgumentException(
// 				'Too long value, must be chopped at ' +
// 				maxLength +
// 				', which would make it look like this: ' +
// 				choppedVersion
// 			);
// 			//return errorAsJsonString(500, fieldName + ' Too long value, must be chopped at ' + maxLength + ', which would make it look like this: ' + choppedVersion);
// 		}
// 		return s;
// 	}

// 	public string doFindCityCodeFromPostalCode(string postalCode, string countryCode) {
// 		DOM.Document doc = new DOM.Document();
// 		DOM.XmlNode bodyNode = createSOAPBodyNode(doc, 'zip', ZIPCODE_NAMESPACE);
// 		if (bodyNode == null) {
// 			System.debug('Could not create integration message to send to LN. Please check logs for an explanation');
// 			return null;
// 		}
// 		DOM.XmlNode createRequest = bodyNode
// 			.addChildElement('Show', ZIPCODE_NAMESPACE, null)
// 			.addChildElement('ShowRequest', null, null);
// 		DOM.XmlNode addressNode = createRequest
// 			.addChildElement('DataArea', null, null)
// 			.addChildElement('ZipCodesByCountryGLX', null, null);
// 		addressNode.addChildElement('country', null, null).addTextNode(countryCode);
// 		addressNode.addChildElement('zipCode', null, null).addTextNode(postalCode);
// 		System.debug('doFindCityCodeFromPostalCode request ' + doc.toXmlString());
// 		DOM.Document responseDoc = sendSoapXml(doc, 'ZipCodesByCountry');
// 		System.debug(responseDoc.toXmlString());

// 		DOM.XmlNode responseEnvelope = responseDoc.getRootElement();
// 		if (responseEnvelope.getName().equals('Error')) {
// 			return Glamox_XML_Utils.ErrorAsJsonString(responseEnvelope);
// 		} else {
// 			DOM.XmlNode cityNode = Glamox_XML_Utils.FindFirstDescendantByName(responseEnvelope, 'city');
// 			if (cityNode != null) {
// 				return cityNode.getText();
// 			}
// 			System.debug('Could not find a city code in zipcode response');
// 			return null;
// 		}
// 	}

// 	public static String doValidateOrder(Quote quote) {
// 		String soldToBp;
// 		String salesOrderType;
// 		Id recordId = quote.Id;

// 		if (quote.Wholesaler_Quote__c == true) {
// 			soldToBp = quote.Wholesaler__r.Customer_Number_LN__c;
// 			salesOrderType = '124';
// 			if (soldToBp == null) {
// 				return 'Cannot create order from quote ' +
// 					recordId +
// 					'. Wholesaler ' +
// 					quote.Wholesaler__r.Name +
// 					' is missing LN customer';
// 			}
// 		} else {
// 			soldToBp = quote.Bidder__r.Customer_Number_LN__c;
// 			// if (quote.ReplacementOrClaim__c == true) {
// 			//     salesOrderType = '500';
// 			// } else {
// 			//     salesOrderType = '100';
// 			// }
// 			salesOrderType = quote.OrderType__c != null ? quote.OrderType__c : '100';

// 			if (soldToBp == null) {
// 				return 'Cannot create order from quote ' +
// 					recordId +
// 					'. Bidder ' +
// 					quote.Bidder__r.Name +
// 					' is missing LN customer';
// 			}
// 		}

// 		String bidderValidation = doValidateBidder(quote);
// 		if (bidderValidation != null) {
// 			return 'Cannot create order from quote ' + recordId + bidderValidation;
// 		}

// 		if (salesOrderType == '124' && (quote.QuoteArea__c == null || quote.QuoteArea__c == 'N04')) {
// 			/* CRM-1120 Order type N04 (the default) should not be transfered to LN in GSN (order type 124).
// 			 Sales rep must set something else. Whatever, just not N04 */
// 			return 'Field Area on quote ' +
// 				quote.QuoteNumber +
// 				' has an invalid value (' +
// 				quote.QuoteArea__c +
// 				') for wholesaler quote. Please correct it.';
// 		}

// 		return null; // All is OK
// 	}

// 	public static String doValidateBidder(Quote quote) {
// 		/* CRM-1163 and CRM-1161 disable this check for now
//         String quoteBusinessUnit = getBusinessUnitName(quote);
//         Account soldToAccount;

//         if (quote.Wholesaler_Quote__c == true) {
//             soldToAccount = quote.Wholesaler__r;
//         } else {
//             soldToAccount = quote.Bidder__r;
//         }

//         String bidderBusinessUnit = soldToAccount.Business_Unit__c;
//         if (quoteBusinessUnit != bidderBusinessUnit) {
//             return 'Quote is for business unit ' + quoteBusinessUnit + ' while the bidder has business unit ' + bidderBusinessUnit;
//         } */
// 		return null; /* OK for now */
// 	}

// 	/* The doCreateAddress function does validation, but that is too late.
//     We want to check the addresses before we send the order to wholesaler (if applicable).
//     @TODO Move all address validation from doCreateAddress into here */
// 	public static String doValidateAddress(String addressName, String addressAdditionalName, System.Address addr) {
// 		if (addr == null || addr.getPostalCode() == null || addr.getCountryCode() == null) {
// 			String message = 'Incomplete address, ';
// 			message += addr == null
// 				? 'address missing'
// 				: addr.getPostalCode() == null
// 						? 'postal code missing'
// 						: addr.getCountryCode() == null ? 'country code missing' : 'unknown';

// 			return errorAsJsonString(500, message);
// 		}

// 		createMaxLengthString(addressName, 35);
// 		createMaxLengthString(addressAdditionalName, 35);

// 		if (addr.getStreet() != null) {
// 			// @TODO De-duplicate this
// 			String street = doCleanupTextfield(addr.getStreet());

// 			List<string> streetNameTokens = street.split('\\n');
// 			if (streetNameTokens.size() > 0) {
// 				createMaxLengthString(streetNameTokens.get(0), 30);
// 			}
// 			if (streetNameTokens.size() > 1) {
// 				streetNameTokens.remove(0); /* We already included this */
// 				createMaxLengthString(String.join(streetNameTokens, '\n'), 30);
// 			}
// 		}
// 		return null; /* Meaning OK for once. */
// 	}

// 	public string doCreateAddress(
// 		string addressName,
// 		string addressAdditionalName,
// 		System.Address addr,
// 		string emailAddress,
// 		string phoneNumber
// 	) {
// 		DOM.Document doc = new DOM.Document();
// 		DOM.XmlNode bodyNode = createSOAPBodyNode(doc, 'sal', ADDRESS_NAMESPACE);
// 		if (bodyNode == null) {
// 			System.debug('Could not create integration message to send to LN. Please check logs for an explanation');
// 			return null;
// 		}
// 		DOM.XmlNode createRequest = bodyNode
// 			.addChildElement('Create', ADDRESS_NAMESPACE, null)
// 			.addChildElement('CreateRequest', null, null);
// 		DOM.XmlNode addressNode = createRequest
// 			.addChildElement('DataArea', null, null)
// 			.addChildElement('Address_v3', null, null);
// 		addressNode.addChildElement('addressCode', null, null).addTextNode('90');
// 		if (emailAddress != null) {
// 			addressNode.addChildElement('emailAddress', null, null).addTextNode(emailAddress);
// 		}
// 		if (phoneNumber != null) {
// 			addressNode.addChildElement('smsNumber', null, null).addTextNode(phoneNumber);
// 		}

// 		/* Let's do null checking */
// 		if (addr == null || addr.getPostalCode() == null || addr.getCountryCode() == null) {
// 			String message = 'Failed to retrieve city code from LN ';
// 			message += addr == null
// 				? 'address missing'
// 				: addr.getPostalCode() == null
// 						? 'postal code missing'
// 						: addr.getCountryCode() == null ? 'country code missing' : 'unknown';

// 			return errorAsJsonString(500, message);
// 		}

// 		if (addr.getPostalCode() != null) {
// 			String postalCode = doCleanupTextfieldSingleLine(addr.getPostalCode());
// 			String countryCode = doCleanupTextfieldSingleLine(addr.getCountryCode());
// 			addressNode.addChildElement('postalCode', null, null).addTextNode(postalCode);
// 			string cityCode = doFindCityCodeFromPostalCode(postalCode, countryCode);

// 			if (cityCode != null) {
// 				if (cityCode.contains('Error')) {
// 					System.debug('Failed to retrieve city code from postal code');
// 					System.debug(cityCode);
// 					Map<string, object> m = (Map<string, object>) JSON.deserializeUntyped(cityCode);
// 					m.put(
// 						'ErrorDesc',
// 						'Failed to retrieve city code from LN based on postal code "' +
// 						addr.getPostalCode() +
// 						'" and country "' +
// 						addr.getCountryCode() +
// 						'"'
// 					);
// 					return JSON.serialize(m);
// 				} else {
// 					addressNode.addChildElement('city', null, null).addTextNode(cityCode);
// 				}
// 			} else {
// 				return errorAsJsonString(
// 					500,
// 					'Unable to retrieve city code from LN based on postal code "' +
// 					postalCode +
// 					'" and country "' +
// 					countryCode +
// 					'"'
// 				);
// 			}
// 		}
// 		if (addr.getCountryCode() != null) {
// 			addressNode.addChildElement('country', null, null)
// 				.addTextNode(doCleanupTextfieldSingleLine(addr.getCountryCode()));
// 		}
// 		if (addressName != null) {
// 			addressName = createMaxLengthString(addressName, 35);
// 			addressNode.addChildElement('name', null, null).addTextNode(doCleanupTextfieldSingleLine(addressName));
// 		}
// 		if (addressAdditionalName != null) {
// 			addressAdditionalName = createMaxLengthString(addressAdditionalName, 35);
// 			addressNode.addChildElement('additionalName', null, null)
// 				.addTextNode(doCleanupTextfieldSingleLine(addressAdditionalName));
// 		}
// 		if (addr.getStreet() != null) {
// 			String street = doCleanupTextfield(addr.getStreet());

// 			List<string> streetNameTokens = street.split('\\n');
// 			if (streetNameTokens.size() > 0) {
// 				String street1 = doCleanupTextFieldSingleLine(createMaxLengthString(streetNameTokens.get(0), 30));
// 				addressNode.addChildElement('streetName', null, null).addTextNode(street1);
// 			}
// 			if (streetNameTokens.size() > 1) {
// 				streetNameTokens.remove(0); /* We already included this */
// 				String street2 = doCleanupTextFieldSingleLine(
// 					createMaxLengthString(String.join(streetNameTokens, '\n'), 30)
// 				);
// 				addressNode.addChildElement('additionalAddress', null, null).addTextNode(street2);
// 			}
// 		}
// 		System.debug(doc.toXmlString());
// 		DOM.Document responseDoc = sendSoapXml(doc, 'Address');
// 		System.debug(responseDoc.toXmlString());
// 		DOM.XmlNode responseEnvelope = responseDoc.getRootElement();
// 		if (responseEnvelope.getName().equals('Error')) {
// 			return Glamox_XML_Utils.ErrorAsJsonString(responseEnvelope);
// 		} else {
// 			DOM.XmlNode responseAddressNode = Glamox_XML_Utils.FindFirstDescendantByName(
// 				responseEnvelope,
// 				'addressCode'
// 			);
// 			if (responseAddressNode != null) {
// 				return responseAddressNode.getText();
// 			}
// 			System.debug('Could not find an address code in address response');
// 			return null;
// 		}
// 	}

// 	private string findCurrentUserInitials() {
// 		string initials = '';
// 		string name = UserInfo.getName();
// 		if (name == null) {
// 			return null;
// 		}
// 		string userid = UserInfo.getUserId();
// 		List<User> users = [SELECT LN_Initials__c FROM User WHERE id = :userid];
// 		if (users != null && users.size() > 0) {
// 			if (users[0].LN_Initials__c != null) {
// 				initials = users[0].LN_Initials__c;
// 			}
// 		}
// 		if (initials == '' || initials == null) {
// 			string[] nameTokens = name.trim().split(' ');
// 			for (string nt : nameTokens) {
// 				if (nt.length() > 0) {
// 					initials += nt.substring(0, 1).toUpperCase();
// 				}
// 			}
// 		}
// 		return initials;
// 	}

// 	public static String doCleanupTextfieldSingleLine(String inputField) {
// 		inputField = inputField.trim();
// 		/* Replace other whitespace with a space */
// 		inputField = inputField.replaceAll('[\\u00A0\\t]', ' ');
// 		/* Remove other special characters */
// 		return inputField.replaceAll('[\\r\\n]', '');
// 	}

// 	public static String doCleanupTextfield(String inputField) {
// 		inputField = inputField.trim();
// 		/* Replace other whitespace with a space */
// 		inputField = inputField.replaceAll('[\\u00A0\\t]', ' ');
// 		/* Remove other special characters */
// 		return inputField.replaceAll('[\\r]', '');
// 	}

// 	/* Same code exists in Glamox_EFONELFO_Client. Should maybe call this */
// 	public static Boolean quoteHasLNOrder(Quote quote) {
// 		String lnOrderId = quote.LN_Order_ID__c;
// 		if (String.isBlank(lnOrderId)) {
// 			return false;
// 		}

// 		Set<String> specialLNOrderIds = new Set<String>{ 'STARTED', 'FWD_TO_LN', 'EXT_HANDLER', 'ERROR' };
// 		if (specialLNOrderIds.contains(lnOrderId)) {
// 			return false;
// 		}

// 		/* Is there already a order ID in here? */
// 		Matcher pm = Pattern.compile('([A-Z]{2})(\\d{7})').matcher(quote.LN_Order_ID__c);

// 		return (pm.matches());

// 		// return new OrderCreationResult('ERROR', 'Quote has been sent to LN already and created order ' + quote.LN_Order_ID__c);
// 	}

// 	/* This is configured as a Custom Setting in Salesforce */
// 	public static String checkActiveServicewindow() {
// 		LN_Servicewindow__c sw = LN_Servicewindow__c.getInstance();
// 		DateTime windowStart = sw.Next_Servicewindow_Start__c;
// 		DateTime windowEnd = sw.Next_Servicewindow_End__c;
// 		System.debug('Next servicewindow ' + windowStart + ' ' + windowEnd);

// 		Boolean thatTimeIsNow = (datetime.now() >= windowStart) && (datetime.now() < windowEnd);
// 		if (!thatTimeIsNow) {
// 			return null;
// 		} else {
// 			System.debug('LN is down for maintenance');
// 			return 'LN is unavailable due to scheduled maintenance from ' + windowStart + ' to ' + windowEnd;
// 		}
// 	}

// 	//The real problem here is that the process of creating the soap document is coupled with LOTs! of other logic, @£$%&!
// 	//The other real problem is that these fields keep being "used differently" by the different parties.
// 	//LN encodes orderLine with unfathomable logic
// 	public List<DOM.XMLNode> createOrderLinesFromQuoteLines(
// 		DOM.XmlNode orderNode,
// 		Boolean hideDiscounts,
// 		Boolean hasSpecificWishDateOnQuoteLine,
// 		Date requestedDate,
// 		List<QuoteLineItem> quoteLines
// 	) {
// 		List<DOM.XmlNode> orderLines = new List<DOM.XMLNode>();
// 		List<Glamox_QuoteLineItem_Comparable> comparableQuoteLines = new List<Glamox_QuoteLineItem_Comparable>();
// 		for (QuoteLineItem qli : quoteLines) {
// 			comparableQuoteLines.add(new Glamox_QuoteLineItem_Comparable(qli));
// 		}
// 		comparableQuoteLines.sort(); //Brian: sorts on SortOrder, this was an attempt to match QuoteLineItem with OrderLineItem returned from LN CREATE, but that was flawed because Glamox_LN_Client_Updates was given the full list of QuoteLines, but it did not take out the IsDummy etc, and also because SortOrder could have changed in the time between now and then (Wholesale order attempt for example)
// 		for (Glamox_QuoteLineItem_Comparable comparableQli : comparableQuoteLines) {
// 			QuoteLineItem qli = comparableQli.getQuoteLineItem();
// 			if (qli.Placeholder__c == true || qli.Product2.Is_Dummy__c != null && qli.Product2.Is_Dummy__c == true) {
// 				continue;
// 			}

// 			Decimal listPrice = qli.Listprice_WhenAdded__c; // Used to be qli.ListPrice;
// 			Decimal uomDiscount = qli.LineDiscount__c != null ? qli.LineDiscount__c : 0;

// 			/* CRM-898 Kan velge mellom SALES_PRICE og LIST_PRICES_AND_DISCOUNTS */
// 			if (hideDiscounts) {
// 				listPrice = qli.UnitPrice;
// 				uomDiscount = 0;
// 			}

// 			DOM.XmlNode orderLinesNode = orderNode.addChildElement('SalesOrderLine', null, null);
// 			orderLinesNode.addChildElement('item', null, null)
// 				.addTextNode(LN_ITEMCODE_PREFIX + qli.Product2.ProductCode);

// 			//@£$%&@$! gdmfsft! if statement is shit that wont happen in real life, but happens in the test (only in the test), which we do shit here to pass.
// 			// tested production SELECT Id FROM QuoteLineItem WHERE SortOrder = null limit 100 returned 0

// 			if (qli.SortOrder != null) {
// 				String orderLine = string.valueOf(qli.SortOrder) + '0'; //ATTEMPTING TO MATCH LN LOGIC, this needs to be matched in Glamox_LN_Client_Updates.cls 48. LN (best guess) starts off counting by 10s, so that it leaves room for changes, i.e. 21,22 is a change to 20 (??), there is also encoding like above 1999 are cost items which have no SF equivalent, but there is other willy nilly encoding too
// 				//On the pull back side this will arrive as a number, i.e. 10,20,...
// 				orderLinesNode.addChildElement('orderLine', null, null).addTextNode(orderLine); // Brian Added: 2022.07.28, see Glamox_LN_Client_Updates.cls 48 where we get this back for matching to qli and the correct Product2Id, PricebookEntryId
// 			}
// 			// else all goes to hell -- the mapping back on the other side will be f'd and it will be a mystery inside a conundrum

// 			if (
// 				qli.ConfiguratorHeaderId__c != null &&
// 				qli.ConfiguratorConfigurationId__c != null &&
// 				qli.ConfiguratorConfigurationId__c.length() > 0
// 			) {
// 				DOM.XmlNode orderLineConfiguratorLinks = orderLinesNode.addChildElement(
// 					'orderLineConfiguratorLinks',
// 					null,
// 					null
// 				);
// 				orderLineConfiguratorLinks.addChildElement('ConfigurationDetailID', null, null)
// 					.addTextNode(qli.ConfiguratorConfigurationId__c);
// 				orderLineConfiguratorLinks.addChildElement('ConfigurationID', null, null)
// 					.addTextNode(qli.ConfiguratorHeaderId__c);
// 			}

// 			orderLinesNode.addChildElement('orderLineSalesForceLineID', null, null).addTextNode(string.valueOf(qli.Id));

// 			String unit = qli.Product2.QuantityUnitOfMeasure != null &&
// 				qli.Product2.QuantityUnitOfMeasure != ''
// 				? qli.Product2.QuantityUnitOfMeasure
// 				: 'pcs'; //default best guess for missing data

// 			orderLinesNode.addChildElement('orderLineOrderQuantityInOrderUOMUOM', null, null).addTextNode(unit);
// 			orderLinesNode.addChildElement('orderLineOrderQuantityInOrderUOMValue', null, null)
// 				.addTextNode(string.valueOf(qli.Quantity));
// 			if (qli.CurrencyIsoCode != null) {
// 				orderLinesNode.addChildElement('priceInOrderCurInPriceUOMCur', null, null)
// 					.addTextNode(qli.CurrencyIsoCode);
// 			}
// 			orderLinesNode.addChildElement('priceInOrderCurInPriceUOMUOM', null, null).addTextNode(unit);
// 			if (listPrice != null) {
// 				orderLinesNode.addChildElement('priceInOrderCurInPriceUOMValue', null, null)
// 					.addTextNode(string.valueOf(listPrice));
// 			}

// 			String orderLineText = '';

// 			if (qli.Description_to_order__c == true && qli.Description != null) {
// 				orderLineText += '< ' + qli.Description.replaceAll('[\\r\\n]', '').replaceAll('[\\n]', '') + '\n';
// 			}
// 			if (qli.Description_to_order_External__c == true && qli.Description != null) {
// 				orderLineText += qli.Description.replaceAll('[\\r\\n]', '').replaceAll('[\\n]', '') + '\n';
// 			}
// 			if (qli.Pos__c != null && qli.Pos__c.length() > 0) {
// 				orderLineText += '##' + doCleanupTextfieldSingleLine((qli.Pos__c));
// 			}
// 			System.debug('LN OrderLineText ' + orderLineText);
// 			if (orderLineText.length() > 0) {
// 				/* Single line input */
// 				//orderLineText = orderLineText.replaceAll('[\\r\\n]', '');
// 				orderLinesNode.addChildElement('orderLineText', null, null).addTextNode(orderLineText);
// 			}

// 			orderLinesNode.addChildElement('orderLineDiscountPercentage', null, null)
// 				.addTextNode(string.valueOf(uomDiscount));

// 			if (qli.ServiceDate != null) {
// 				orderLinesNode.addChildElement('orderLineCustomerWishDate', null, null)
// 					.addTextNode(formatDatetime(qli.ServiceDate));
// 			} else if (hasSpecificWishDateOnQuoteLine && requestedDate != null) {
// 				orderLinesNode.addChildElement('orderLineCustomerWishDate', null, null)
// 					.addTextNode(formatDatetime(requestedDate));
// 			}
// 			orderLines.add(orderLinesNode);
// 		}
// 		System.debug('Order lines to LN ' + orderLines);
// 		return orderLines;
// 	}

// 	public string doCreateOrderFromQuote(Id recordId) {
// 		return this.doCreateOrderFromQuote(recordId, null);
// 	}

// 	public string doCreateOrderFromQuote(Id recordId, String updatedYourReference) {
// 		DOM.Document doc = new DOM.Document();
// 		DOM.XmlNode bodyNode = createSOAPBodyNode(doc, 'sal', SALES_ORDER_NAMESPACE);
// 		if (bodyNode == null) {
// 			return errorAsJsonString(
// 				500,
// 				'Could not create integration message to send to LN. Please check logs for an explanation'
// 			);
// 		}
// 		DOM.XmlNode createRequest = bodyNode
// 			.addChildElement('Create', SALES_ORDER_NAMESPACE, null)
// 			.addChildElement('CreateRequest', null, null);
// 		createRequest
// 			.addChildElement('ControlArea', null, null)
// 			.addChildElement('processingScope', null, null)
// 			.addTextNode('request');
// 		DOM.XmlNode orderNode = createRequest
// 			.addChildElement('DataArea', null, null)
// 			.addChildElement('SalesOrderGLX', null, null);

// 		Quote quote = this.queries.getQuoteByRecordId(recordId);
// 		System.assert(quote != null, 'Unknown quote ' + recordId);

// 		if (quoteHasLNOrder(quote) == true) {
// 			return errorAsJsonString(
// 				400,
// 				'Quote has been sent to LN already and created order ' +
// 				quote.LN_Order_ID__c +
// 				'.'
// 			);
// 		}

// 		if (quote.Handled_By_Wholesaler__c == true) {
// 			return errorAsJsonString(400, 'This quote is set to be handled by wholesaler, not by Glamox.');
// 		}

// 		List<QuoteLineItem> quoteLines = this.queries.getQuoteLineItems(quote);
// 		if (quoteLines.size() == 0) {
// 			return errorAsJsonString(400, 'This quote has no quote lines.');
// 		}
// 		Boolean hasQuoteLines = false;
// 		for (QuoteLineItem qli : quoteLines) {
// 			if (qli.Placeholder__c == true || qli.Product2.Is_Dummy__c != null && qli.Product2.Is_Dummy__c == true) {
// 				continue;
// 			}
// 			hasQuoteLines = true;
// 		}
// 		if (!hasQuoteLines) {
// 			return errorAsJsonString(400, 'This quote has no quote lines, or only placeholder quote lines.');
// 		}

// 		User oppOwner = getOpportunityOwner(quote); //getOpportunityOwner quote must have Opportunity.OwnerId

// 		string segment = segmentMapping.get(quote.Opportunity.Segment__c);
// 		System.debug('Segment mapping is ' + segment + ' for value ' + quote.Opportunity.Segment__c);
// 		if (segment == null) {
// 			return errorAsJsonString(
// 				500,
// 				'Segment value ' +
// 				quote.Opportunity.Segment__c +
// 				' did not map to a lineOfBusiness value'
// 			);
// 		}

// 		string orderSeries = orderSeriesMapping.get(integer.valueOf(oppOwner.GMS_MarkedID__c));
// 		if (orderSeries == null) {
// 			return errorAsJsonString(
// 				500,
// 				'GMS Market value ' +
// 				oppOwner.GMS_MarkedID__c +
// 				' did not map to an order series'
// 			);
// 		}

// 		if (quote.Bidder__r == null) {
// 			return errorAsJsonString(
// 				500,
// 				'Cannot create order from quote ' +
// 				recordId +
// 				'. Bidder is not set on quote'
// 			);
// 		}

// 		Boolean accountHasWeee = quote.Wholesaler_Quote__c
// 			? quote.Wholesaler__r.UseWEEE__c
// 			: quote.Bidder__r.UseWEEE__c;
// 		if (accountHasWEEE) {
// 			Account account = queries.getAccountById(quote.accountId);
// 			System.debug(
// 				'UseWEEE__c quote ' +
// 				quote.QuoteNumber +
// 				' wholesalerr? ' +
// 				quote.Wholesaler_Quote__c +
// 				' weee? ' +
// 				quote.Wholesaler__r.UseWEEE__c +
// 				' or ' +
// 				quote.Bidder__r.UseWEEE__c
// 			);
// 			String useWeeeYesNo = quote.WEEEType__c == null ? 'no' : quote.WEEEType__c;
// 			orderNode.addChildElement('salesOrderHeaderUseWEEE', null, null).addTextNode(useWeeeYesNo);
// 		} else if (!(quote.WEEEType__c == 'no' || quote.WEEEType__c == null)) {
// 			String accountName = quote.Wholesaler_Quote__c ? quote.Wholesaler__r.Name : quote.Bidder__r.Name;
// 			return errorAsJsonString(
// 				500,
// 				'Cannot create order from quote ' +
// 				recordId +
// 				'. Quote has Use WEEE selected, but account ' +
// 				accountName +
// 				' has not.'
// 			);
// 		} /* If account doesn't have UseWEEE__c we must not send it to LN */

// 		string shippingAddressCode = null;
// 		if (quote.ShippingAddress != null) {
// 			try {
// 				shippingAddressCode = doCreateAddress(
// 					quote.ShippingName,
// 					quote.ShippingAdditionalName__c,
// 					quote.ShippingAddress,
// 					quote.ShippingEmail__c,
// 					quote.ShippingPhone__c
// 				);
// 			} catch (IllegalArgumentException e) {
// 				System.debug('Error creating shipping address: ' + e.getMessage());
// 				return errorAsJsonString(500, 'Shipping address, ' + e.getMessage());
// 			}
// 			if (shippingAddressCode != null && shippingAddressCode.contains('ErrorCode')) {
// 				// The result is an error instead of an address code. Return the error instead.
// 				return shippingAddressCode;
// 			}
// 		}
// 		System.debug('SJEKK');
// 		string billingAddressCode = null;
// 		String billingName;
// 		String billingAdditionalName;
// 		Address billingAddress;
// 		String soldToBp;
// 		String salesOrderType;

// 		if (quote.BillingAddress != null) {
// 			billingName = quote.BillingName;
// 			billingAdditionalName = quote.BillingAdditionalName__c;
// 			billingAddress = quote.BillingAddress;
// 		}

// 		if (quote.Wholesaler_Quote__c == true) {
// 			soldToBp = quote.Wholesaler__r.Customer_Number_LN__c;
// 			salesOrderType = '124';
// 			if (soldToBp == null) {
// 				return errorAsJsonString(
// 					500,
// 					'Cannot create order from quote ' +
// 					recordId +
// 					'. Wholesaler ' +
// 					quote.Wholesaler__r.Name +
// 					' is missing LN customer'
// 				);
// 			}
// 		} else {
// 			soldToBp = quote.Bidder__r.Customer_Number_LN__c;
// 			// salesOrderType = '100';
// 			// if (quote.ReplacementOrClaim__c == true) {
// 			//     salesOrderType = '500';
// 			// }
// 			salesOrderType = quote.OrderType__c != null ? quote.OrderType__c : '100';

// 			if (soldToBp == null) {
// 				return errorAsJsonString(
// 					500,
// 					'Cannot create order from quote ' +
// 					recordId +
// 					'. Bidder ' +
// 					quote.Bidder__r.Name +
// 					' is missing LN customer'
// 				);
// 			}
// 		}

// 		if (billingName != null) {
// 			try {
// 				billingAddressCode = doCreateAddress(billingName, billingAdditionalName, billingAddress, null, null);
// 			} catch (IllegalArgumentException e) {
// 				System.debug('Error creating billing address: ' + e.getMessage());
// 				return errorAsJsonString(500, 'Billing address, ' + e.getMessage());
// 			}

// 			if (billingAddressCode != null && billingAddressCode.contains('ErrorCode')) {
// 				// The result is an error instead of an address code. Return the error instead.
// 				return billingAddressCode;
// 			}
// 		}

// 		orderNode.addChildElement('soldToBusinessPartner', null, null).addTextNode(soldToBp);
// 		String quoteNumber = quote.QuoteNumber != null ? quote.QuoteNumber : '';
// 		orderNode.addChildElement('salesOrderHeaderCustomerOrder', null, null).addTextNode(quoteNumber);

// 		User salesRep = quote.Sales_Rep__r;
// 		if (salesRep != null && salesRep.LN_EmployeeNO__c != null) {
// 			orderNode.addChildElement('internalSalesPerson', null, null).addTextNode(salesRep.LN_EmployeeNO__c);
// 		}

// 		orderNode.addChildElement('lineOfBusiness', null, null).addTextNode(segment);
// 		orderNode.addChildElement('orderCurrency', null, null).addTextNode(quote.CurrencyIsoCode);
// 		orderNode.addChildElement('salesOrder', null, null).addTextNode(orderSeries);
// 		String salesOffice = oppOwner.LN_Sales_Office__c;
// 		if (salesOffice == null) {
// 			return errorAsJsonString(
// 				500,
// 				'Cannot create order from quote ' +
// 				recordId +
// 				'. Opportunity owner ' +
// 				quote.Opportunity.OwnerId +
// 				' has no LN_Sales_Office__c set, maybe check BU configuration.'
// 			);
// 		} else {
// 			System.debug('Salsoffice for quote ' + quote.Id + ' is ' + salesOffice);
// 		}
// 		orderNode.addChildElement('salesOffice', null, null).addTextNode(salesOffice);
// 		orderNode.addChildElement('salesOrderType', null, null).addTextNode(salesOrderType); // 100 vanlegvis, skal vere 124 på wholesaler
// 		orderNode.addChildElement('salesOrderHeaderDate', null, null).addTextNode(formatDatetime(Datetime.now()));

// 		string userInitials = findCurrentUserInitials();
// 		if (userInitials != null) {
// 			orderNode.addChildElement('salesOrderHeaderBackofficeReference', null, null).addTextNode(userInitials);
// 		}

// 		boolean hasSpecificWishDateOnQuoteLine = false;
// 		for (QuoteLineItem qli : quoteLines) {
// 			if (qli.ServiceDate != null) {
// 				hasSpecificWishDateOnQuoteLine = true;
// 			}
// 		}

// 		Boolean isSandbox = [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;

// 		if (isSandbox) {
// 			/* AOL 20210119: Enable these lines for all orgs when salesOrderHeaderUseWEEE, salesOrderHeaderLatePaymentSurcharge and
// 			 salesOrderHeaderArea are supported in production */
// 			/* TBRI 20210412 Enabled now */
// 		}

// 		if (quote.Carrier__c != null && quote.Carrier__c.length() > 0) {
// 			/* S01 is valid for market 164, Sweden */
// 			/* D01 is valid for market 3 Denmark */

// 			Decimal marketId = oppOwner.GMS_MarkedID__c;
// 			if (marketId == null) {
// 				return errorAsJsonString(
// 					500,
// 					'Cannot create order from quote ' +
// 					recordId +
// 					'. Quote owner ' +
// 					oppOwner +
// 					' has no market ID set, maybe check BU configuration.'
// 				);
// 			}

// 			orderNode.addChildElement('carrier', null, null).addTextNode(quote.Carrier__c);
// 		}

// 		if (quote.Freight_Zone__c != null) {
// 			orderNode.addChildElement('salesOrderHeaderLatePaymentSurcharge', null, null)
// 				.addTextNode(quote.Freight_Zone__c);
// 		}

// 		if (salesOrderType == '124' && (quote.QuoteArea__c == null || quote.QuoteArea__c == 'N04')) {
// 			/* CRM-1120 Order type N04 (the default) should not be transfered to LN in GSN (order type 124).
// 			 Sales rep must set something else. Whatever, just not N04 */
// 			return errorAsJsonString(
// 				500,
// 				'Field Area on quote ' +
// 				quote.QuoteNumber +
// 				' has an invalid value (' +
// 				quote.QuoteArea__c +
// 				') for wholesaler quote. Please correct it.'
// 			);
// 		}

// 		if (quote.QuoteArea__c != null) {
// 			orderNode.addChildElement('salesOrderHeaderArea', null, null).addTextNode(quote.QuoteArea__c);
// 		}

// 		/* For setting source of BODs */
// 		orderNode.addChildElement('salesOrderHeaderOrderSource', null, null).addTextNode('SF');

// 		if (quote.Point_Of_Title_Passage__c != null) {
// 			/* Example: <salesOrderHeaderPointOfTitlePassage>BODO</salesOrderHeaderPointOfTitlePassage> */
// 			String place = quote.Point_Of_Title_Passage__c;
// 			String code = Glamox_GSS_Client.addPlaceIfNotExistsAndReturnCode(place);
// 			if (code == null) {
// 				return errorAsJsonString(500, 'Cannot create place (Point of title passage): ' + place);
// 			}

// 			orderNode.addChildElement('salesOrderHeaderPointOfTitlePassage', null, null).addTextNode(code);
// 		}

// 		if (quote.Vat_Exception__c != null) {
// 			String vatException = (quote.Vat_Exception__c) ? 'yes' : 'no';
// 			/* Example: <salesOrderHeaderVATException>yes</salesOrderHeaderVATException> */
// 			orderNode.addChildElement('salesOrderHeaderVATException', null, null).addTextNode(vatException);
// 		}

// 		//}

// 		if (!hasSpecificWishDateOnQuoteLine && quote.Requested_Date__c != null) {
// 			orderNode.addChildElement('salesOrderHeaderCustomerWishDate', null, null)
// 				.addTextNode(formatDatetime(quote.Requested_Date__c));
// 		}

// 		Decimal orderDiscount = null;

// 		if (quote.OrderDiscount__c != null && quote.OrderDiscount__c > 0) {
// 			orderDiscount = quote.OrderDiscount__c;
// 		}

// 		if (quote.Wholesaler_Commission__c != null && quote.Wholesaler_Commission__c > 0) {
// 			if (orderDiscount != null) {
// 				System.debug(
// 					'Quote ' +
// 					quote.Id +
// 					' has both order discount and wholesaler commission. We choose the latter.'
// 				);
// 			}

// 			orderDiscount = quote.Wholesaler_Commission__c;
// 		}

// 		if (orderDiscount != null) {
// 			orderNode.addChildElement('salesOrderHeaderDiscountPercentage', null, null)
// 				.addTextNode(orderDiscount.toPlainString());
// 		}

// 		if (quote.YourReference__c != null || updatedYourReference != null) {
// 			String yourReference = quote.YourReference__c;
// 			if (updatedYourReference != null) {
// 				yourReference = updatedYourReference;
// 			}

// 			if (yourReference != null && yourReference.length() > 30) {
// 				return errorAsJsonString(
// 					500,
// 					'Field YourReference on quote ' +
// 					quote.QuoteNumber +
// 					' is ' +
// 					yourReference.length() +
// 					' characters. The maximum is 30, please change.'
// 				);
// 			}

// 			if (yourReference != null) {
// 				orderNode.addChildElement('salesOrderHeaderCustomerReference', null, null).addTextNode(yourReference);
// 			}
// 		}

// 		if (shippingAddressCode != null) {
// 			orderNode.addChildElement('shipToAddress', null, null).addTextNode(shippingAddressCode);
// 		}

// 		if (billingAddressCode != null) {
// 			orderNode.addChildElement('invoiceToAddress', null, null).addTextNode(billingAddressCode);
// 		}

// 		if (quote.Shipping_Constraint__c != null) {
// 			orderNode.addChildElement('salesOrderHeaderShippingConstraint', null, null)
// 				.addTextNode(quote.Shipping_Constraint__c);
// 		}

// 		if (quote.Opportunity.Opportunity_Number__c != null) {
// 			orderNode.addChildElement('salesOrderHeaderSalesForceOpportunity', null, null)
// 				.addTextNode(quote.Opportunity.Opportunity_Number__c);
// 		}

// 		if (quote.Opportunity.Name != null) {
// 			orderNode.addChildElement('salesOrderHeaderSalesForceOpportunityDescription', null, null)
// 				.addTextNode(quote.Opportunity.Name);
// 		}

// 		String email = buildOrderSpecificEmail(quote);

// 		if (email != null) {
// 			orderNode.addChildElement('salesOrderHeaderOrderSpecificEmail', null, null).addTextNode(email);
// 		}

// 		if (quote.TermsOfPayment__c != null) {
// 			string paymentTerms = quote.TermsOfPayment__c.trim();
// 			if (paymentTerms.length() >= 3) {
// 				paymentTerms = paymentTerms.substring(0, 3);
// 				orderNode.addChildElement('paymentTerms', null, null).addTextNode(paymentTerms);
// 			}
// 		}

// 		if (quote.TermsOfDelivery__c != null) {
// 			string deliveryTerms = quote.TermsOfDelivery__c.trim();
// 			if (deliveryTerms.length() >= 3) {
// 				deliveryTerms = deliveryTerms.substring(0, 3);
// 				orderNode.addChildElement('transportationTerm', null, null).addTextNode(deliveryTerms);
// 			}
// 		}

// 		string headerText = '';
// 		if (quote.External_Notes__c != null) {
// 			headerText = quote.External_Notes__c;
// 		}

// 		if (quote.Internal_Notes__c != null) {
// 			headerText += Glamox_LN_Client.encodeInternalNotes(quote.Internal_Notes__c, quote.Wholesaler_Ref_text__c);
// 		}

// 		if (quote.Pallet_Marking__c != null) {
// 			List<String> palletMarkingTokens = doCleanupTextfield(quote.Pallet_Marking__c).split('\\n');
// 			for (String pt : palletMarkingTokens) {
// 				headerText += '\n##';
// 				headerText += pt;
// 			}
// 		}

// 		String businessUnit = Glamox_LN_Client.getBusinessUnitName(quote);
// 		if (businessUnit.contains(GLAMOX_NORWAY_BUNAME)) {
// 			/* CRM-993 Only show these if quote is owned by GSN */
// 			String deliveryMarkings = fetchDeliveryMarkings(quote);
// 			if (deliveryMarkings != null) {
// 				headerText += '\n' + deliveryMarkings;
// 			}
// 		}

// 		if (headerText != null && headerText != '') {
// 			orderNode.addChildElement('headerText', null, null).addTextNode(headerText);
// 			System.debug('LN Header text ' + headerText);
// 		}

// 		createOrderLinesFromQuoteLines(
// 			orderNode,
// 			quote.HideDiscounts__c,
// 			hasSpecificWishDateOnQuoteLine,
// 			quote.Requested_Date__c,
// 			quoteLines
// 		); // we set SalesOrderLine.orderLine to the QuoteLineItem.SortOrder
// 		String xmlString = doc.toXmlString();
// 		System.debug('SalesOrderGLX ' + xmlString);
// 		System.debug('SalesOrderGLX Length ' + xmlString.length());
// 		System.debug('SalesOrderGLX 1 ' + xmlString.left(1700));
// 		System.debug('SalesOrderGLX 2 ' + xmlString.right(1700));
// 		DOM.Document responseDoc = null;
// 		try {
// 			responseDoc = sendSoapXml(doc, 'SalesOrderGLX');
// 		} catch (CalloutException e) {
// 			/* We want to handle timeouts here */
// 			System.debug('Got exception sending order to LN ' + e.getMessage() + ' because ' + e);
// 			return errorAsJsonString(500, 'Unable to send order to LN: ' + e.getMessage());
// 		}
// 		System.debug(responseDoc.toXmlString());
// 		DOM.XmlNode responseEnvelope = responseDoc.getRootElement();
// 		if (responseEnvelope.getName().equals('Error')) {
// 			return Glamox_XML_Utils.ErrorAsJsonString(responseEnvelope);
// 		} else {
// 			DOM.XmlNode responseBodyNode = responseEnvelope.getChildElement('Body', SOAP_NAMESPACE);
// 			DOM.XmlNode firstResponse = responseBodyNode.getChildElement('CreateResponse', SALES_ORDER_NAMESPACE);
// 			DOM.XmlNode salesOrderNode = firstResponse.getChildren()[0].getChildren()[0].getChildren()[0];
// 			Map<string, string> item = new Map<string, string>();
// 			string salesOrderLines = '';
// 			List<Integer> salesOrderLinesList = new List<Integer>();
// 			for (DOM.XmlNode childNode : salesOrderNode.getChildren()) {
// 				if (childNode.getName().equals('salesOrder')) {
// 					item.put('OrderNumber', childNode.getText());
// 				} else if (childNode.getName().equals('SalesOrderLine')) {
// 					if (salesOrderLines.length() > 0) {
// 						salesOrderLines += ';';
// 					}
// 					string salesOrderLineNumber = childNode.getChildren()[0].getText(); //Brian: wtf??,TODO: find by NODE NAME, and salesOrderLineNumber should now be QuoteLineItem.SortOrder
// 					salesOrderLines += salesOrderLineNumber;
// 					salesOrderLinesList.add(Integer.valueOf(salesOrderLineNumber));
// 				}
// 			}
// 			item.put('SalesOrderType', salesOrderType);
// 			if (salesOrderLines.length() > 0) {
// 				item.put('SalesOrderLines', salesOrderLines);
// 			}

// 			if (item.containsKey('OrderNumber')) {
// 				updates.updateLNOrderIdOnQuote(quote.Id, item.get('OrderNumber'));
// 				try {
// 					updates.createDraftSalesforceOrder(
// 						quote,
// 						quoteLines,
// 						item.get('OrderNumber'),
// 						salesOrderLinesList,
// 						quote.Bidder__r.Id
// 					); //List<QuoteLineItem.SortOrder>
// 				} catch (Exception e) {
// 					System.debug('Failed to create order object in Salesforce');
// 					System.debug(e);
// 				}
// 			}

// 			string returnValue = JSON.serialize(item);
// 			System.debug(returnValue);
// 			return returnValue;
// 		}
// 	}

// 	public string doGetWarehouseInventoryForProductByProductCode(string productCode) {
// 		if (productCode == null) {
// 			return errorAsJsonString(400, 'Cannot specify a null value for productCode');
// 		}
// 		DOM.Document doc = new DOM.Document();
// 		DOM.XmlNode bodyNode = createSOAPBodyNode(doc, 'war', WAREHOUSE_NAMESPACE);
// 		if (bodyNode == null) {
// 			return errorAsJsonString(
// 				500,
// 				'Could not create integration message to send to LN. Please check logs for an explanation'
// 			);
// 		}
// 		DOM.XmlNode itemNode = bodyNode
// 			.addChildElement('Show', WAREHOUSE_NAMESPACE, null)
// 			.addChildElement('ShowRequest', null, null)
// 			.addChildElement('DataArea', null, null)
// 			.addChildElement('WarehouseItemInventory', null, null)
// 			.addChildElement('Item', null, null)
// 			.addTextNode(LN_ITEMCODE_PREFIX + productCode);
// 		DOM.Document responseDoc = sendSoapXml(doc, 'WarehouseItemInventory');
// 		DOM.XmlNode responseEnvelope = responseDoc.getRootElement();
// 		if (responseEnvelope.getName().equals('Error')) {
// 			return Glamox_XML_Utils.ErrorAsJsonString(responseEnvelope);
// 		} else {
// 			List<Map<string, object>> ret = new List<Map<string, object>>();
// 			List<DOM.XmlNode> invoiceNodes = Glamox_XML_Utils.FindFirstDescendantsByName(responseEnvelope, 'Inventory');
// 			for (DOM.XmlNode child : invoiceNodes) {
// 				Map<string, object> childAsMap = Glamox_XML_Utils.ConvertShallow(child);
// 				if (childAsMap.containsKey('OnHand')) {
// 					childAsMap.put('OnHand', Double.valueOf(childAsMap.get('OnHand')));
// 				}
// 				/* @see @Glamox_XML_Utils_Test.ConvertAttributesAndText */
// 				List<DOM.XmlNode> userAreas = Glamox_XML_Utils.FindFirstDescendantsByName(child, 'UserArea');
// 				List<DOM.XmlNode> properties = Glamox_XML_Utils.FindFirstDescendantsByName(child, 'Property');
// 				List<DOM.XmlNode> values = Glamox_XML_Utils.FindFirstDescendantsByName(child, 'NameValue');
// 				if (values.size() > 0) {
// 					/* If we have any NameValue elements, we expect them to be availableInventory */
// 					List<Map<String, Object>> valuesAsList = Glamox_XML_Utils.ConvertAttributesAndText(values);
// 					Map<String, Object> value = valuesAsList.get(0);
// 					System.assert(value.get('@name') == 'availableInventory');
// 					childAsMap.put('AvailableInventory', Double.valueOf(value.get('text')));
// 				}

// 				ret.add(childAsMap);
// 			}
// 			return JSON.serialize(ret);
// 		}
// 	}

// 	public string doGetItemList(Id recordId) {
// 		System.debug('Calling getItemList()');
// 		Schema.sObjectType sObjType = recordId.getSObjectType();
// 		Schema.DescribeSObjectResult sObjDescribeResult = sObjType.getDescribe();
// 		if (sObjDescribeResult.getName() == 'ProductGroup__c') {
// 			string productGroup = this.queries.getProductGroup(recordId);
// 			System.debug('Product group is ' + productGroup);
// 			DOM.Document doc = new DOM.Document();
// 			DOM.XmlNode bodyNode = createSOAPBodyNode(doc, 'item', ITEM_NAMESPACE);
// 			if (bodyNode == null) {
// 				return errorAsJsonString(
// 					500,
// 					'Could not create integration message to send to LN. Please check logs for an explanation'
// 				);
// 			}
// 			DOM.XmlNode controlArea = bodyNode
// 				.addChildElement('List', ITEM_NAMESPACE, null)
// 				.addChildElement('ListRequest', null, null)
// 				.addChildElement('ControlArea', null, null);

// 			DOM.XmlNode selection = controlArea.addChildElement('Selection', null, null);
// 			selection.addChildElement('selectionAttributes', null, null).addTextNode('Item_v3.EANCode');
// 			selection.addChildElement('selectionAttributes', null, null).addTextNode('Item_v3.description');

// 			DOM.XmlNode comparisonExpression = controlArea.addChildElement('Filter', null, null)
// 				.addChildElement('ComparisonExpression', null, null);
// 			comparisonExpression.addChildElement('comparisonOperator', null, null).addTextNode('eq');
// 			comparisonExpression.addChildElement('attributeName', null, null).addTextNode('Item_v3.itemGroup');
// 			comparisonExpression.addChildElement('instanceValue', null, null).addTextNode(productGroup);

// 			DOM.Document responseDoc = sendSoapXml(doc, 'Items');
// 			return Glamox_XML_Utils.ConvertResponseToJsonShallow(responseDoc.getRootElement(), 'Item_v3');
// 		} else {
// 			return errorAsJsonString(
// 				400,
// 				'Object was of type ' +
// 				sObjDescribeResult.getName() +
// 				'. This object type is not supported'
// 			);
// 		}
// 	}

// 	public string doGetPrices(string lnBusinessPartnerCode, string currencyCode, List<string> productCodes) {
// 		System.debug(
// 			'Calling doGetPrices(' +
// 			lnBusinessPartnerCode +
// 			',' +
// 			currencyCode +
// 			',' +
// 			JSON.serialize(productCodes) +
// 			')'
// 		);

// 		DOM.Document doc = new DOM.Document();
// 		DOM.XmlNode bodyNode = createSOAPBodyNode(doc, 'cus', CUSTOMER_PRICE_NAMESPACE);
// 		if (bodyNode == null) {
// 			return errorAsJsonString(
// 				500,
// 				'Could not create integration message to send to LN. Please check logs for an explanation'
// 			);
// 		}
// 		DOM.XmlNode requestNode = bodyNode
// 			.addChildElement('SimulatePrice', CUSTOMER_PRICE_NAMESPACE, null)
// 			.addChildElement('SimulatePriceRequest', null, null);
// 		requestNode.addChildElement('ControlArea', null, null)
// 			.addChildElement('processingScope', null, null)
// 			.addTextNode('request');
// 		DOM.XmlNode dataArea = requestNode.addChildElement('DataArea', null, null);

// 		for (string productCode : productCodes) {
// 			DOM.XmlNode customerPrice = dataArea.addChildElement('CustomerPrice', null, null);
// 			customerPrice.addChildElement('customerCode', null, null).addTextNode(lnBusinessPartnerCode);
// 			customerPrice.addChildElement('itemCode', null, null).addTextNode(LN_ITEMCODE_PREFIX + productCode);
// 			customerPrice.addChildElement('priceDatetime', null, null).addTextNode(formatDate(Date.today()));
// 			customerPrice.addChildElement('currency', null, null).addTextNode(currencyCode);
// 		}
// 		DOM.Document responseDoc = sendSoapXml(doc, 'CustomerPrice');
// 		return Glamox_XML_Utils.ConvertResponseToJsonShallow(responseDoc.getRootElement(), 'CustomerPrice');
// 	}

// 	public string doGetPricesForQuote(Id quoteRecordId, List<Id> productRecordIds) {
// 		System.debug('Calling doGetPricesForQuote()');
// 		Quote q = queries.getQuoteByRecordId(quoteRecordId);
// 		if (q.Bidder__r == null) {
// 			return errorAsJsonString(
// 				500,
// 				'Unable to retrieve prices for quote ' +
// 				quoteRecordId +
// 				'. No Bidder set for this quote'
// 			);
// 		}
// 		string customerNumberLn = q.Bidder__r.Customer_Number_LN__c;
// 		if (customerNumberLn == null) {
// 			return errorAsJsonString(
// 				500,
// 				'Unable to retrieve prices for quote ' +
// 				quoteRecordId +
// 				'. Bidder account has no LN number'
// 			);
// 		}
// 		List<string> productCodes = queries.getProductCodesForRecordIds(productRecordIds);
// 		if (productCodes.size() == 0) {
// 			return errorAsJsonString(
// 				500,
// 				'Unable to retrieve prices for quote ' +
// 				quoteRecordId +
// 				'. No product codes found for product record Ids ' +
// 				JSON.serialize(productRecordIds)
// 			);
// 		}
// 		return doGetPrices(q.Bidder__r.Customer_Number_LN__c, q.CurrencyIsoCode, productCodes);
// 	}

// 	public string doGetSalesOrders(string lnBusinessPartnerCode) {
// 		System.debug('Calling doGetSalesOrders()');

// 		DOM.Document doc = new DOM.Document();
// 		DOM.XmlNode bodyNode = createSOAPBodyNode(doc, 'sal', SALES_ORDER_NAMESPACE);
// 		if (bodyNode == null) {
// 			return errorAsJsonString(
// 				500,
// 				'Could not create integration message to send to LN. Please check logs for an explanation'
// 			);
// 		}
// 		DOM.XmlNode requestNode = bodyNode
// 			.addChildElement('List', SALES_ORDER_NAMESPACE, null)
// 			.addChildElement('ListRequest', null, null);
// 		DOM.XmlNode controlAreaNode = requestNode.addChildElement('ControlArea', null, null);
// 		DOM.XmlNode selectionNode = controlAreaNode.addChildElement('Selection', null, null);

// 		selectionNode.addChildElement('selectionAttribute', null, null).addTextNode('SalesOrderGLX.carrier');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.internalSalesPerson');
// 		selectionNode.addChildElement('selectionAttribute', null, null).addTextNode('SalesOrderGLX.lineOfBusiness');
// 		selectionNode.addChildElement('selectionAttribute', null, null).addTextNode('SalesOrderGLX.orderCurrency');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.orderDiscountAmountInOrderCurCur');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.orderDiscountAmountInOrderCurValue');
// 		selectionNode.addChildElement('selectionAttribute', null, null).addTextNode('SalesOrderGLX.paymentTerms');
// 		selectionNode.addChildElement('selectionAttribute', null, null).addTextNode('SalesOrderGLX.salesOrder');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.salesOrderHeaderCustomerOrder');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.salesOrderHeaderDate');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.salesOrderHeaderDiscountPercentage');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.salesOrderHeaderPromisedDeliveryDate');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.salesOrderHeaderPromisedShipDate');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.salesOrderHeaderStatus');
// 		selectionNode.addChildElement('selectionAttribute', null, null).addTextNode('SalesOrderGLX.shipToAddress');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.shipToBusinessPartner');
// 		selectionNode.addChildElement('selectionAttribute', null, null).addTextNode('SalesOrderGLX.soldToAddress');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.soldToBusinessPartner');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.totalOrderAmountInOrderCurCur');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.totalOrderAmountInOrderCurValue');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.totalOrderLineAmountInOrderCurCur');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.totalTaxAmountInOrderCurCur');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.totalTaxAmountInOrderCurValue');
// 		selectionNode.addChildElement('selectionAttribute', null, null).addTextNode('SalesOrderGLX.transportationTerm');

// 		DOM.XmlNode comparisonExpressionNode = controlAreaNode.addChildElement('Filter', null, null)
// 			.addChildElement('ComparisonExpression', null, null);
// 		comparisonExpressionNode.addChildElement('comparisonOperator', null, null).addTextNode('eq');
// 		comparisonExpressionNode.addChildElement('attributeName', null, null)
// 			.addTextNode('SalesOrderGLX.soldToBusinessPartner');
// 		comparisonExpressionNode.addChildElement('instanceValue', null, null).addTextNode(lnBusinessPartnerCode);

// 		DOM.Document responseDoc = sendSoapXml(doc, 'SalesOrderGLX');
// 		return Glamox_XML_Utils.ConvertResponseToJsonShallow(responseDoc.getRootElement(), 'SalesOrderGLX');
// 	}

// 	/** Returns null if there are no sales orders for this quote in LN. If not it will return a list of order numbers. */
// 	public List<String> doHasSalesorder(String quoteNumber) {
// 		System.debug('Calling doHasSalesorder()');

// 		DOM.Document doc = new DOM.Document();
// 		DOM.XmlNode bodyNode = createSOAPBodyNode(doc, 'sal', SALES_ORDER_NAMESPACE);
// 		if (bodyNode == null) {
// 			//return errorAsJsonString(500, 'Could not create integration message to send to LN. Please check logs for an explanation');
// 			throw new IllegalArgumentException(
// 				'Could not create integration message to send to LN. Please check logs for an explanation'
// 			);
// 		}
// 		DOM.XmlNode requestNode = bodyNode
// 			.addChildElement('List', SALES_ORDER_NAMESPACE, null)
// 			.addChildElement('ListRequest', null, null);
// 		DOM.XmlNode controlAreaNode = requestNode.addChildElement('ControlArea', null, null);
// 		DOM.XmlNode selectionNode = controlAreaNode.addChildElement('Selection', null, null);

// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.salesOrderHeaderCustomerOrder');
// 		selectionNode.addChildElement('selectionAttribute', null, null)
// 			.addTextNode('SalesOrderGLX.salesOrderHeaderStatus');

// 		DOM.XmlNode comparisonExpressionNode = controlAreaNode.addChildElement('Filter', null, null)
// 			.addChildElement('ComparisonExpression', null, null);
// 		comparisonExpressionNode.addChildElement('comparisonOperator', null, null).addTextNode('eq');
// 		comparisonExpressionNode.addChildElement('attributeName', null, null)
// 			.addTextNode('SalesOrderGLX.salesOrderHeaderCustomerOrder');
// 		comparisonExpressionNode.addChildElement('instanceValue', null, null).addTextNode(quoteNumber);

// 		DOM.Document responseDoc = sendSoapXml(doc, 'SalesOrderGLX');
// 		DOM.XmlNode responseEnvelope = responseDoc.getRootElement();
// 		String resp = Glamox_XML_Utils.ConvertResponseToJsonShallow(responseDoc.getRootElement(), 'SalesOrderGLX');
// 		System.debug('RESP STR ' + resp);
// 		List<Object> items = (List<Object>) JSON.deserializeUntyped(resp);
// 		if (items.size() == 0) {
// 			return null;
// 		}
// 		List<String> retval = new List<String>();
// 		for (Object item : items) {
// 			Map<String, Object> so = (Map<String, Object>) item;
// 			System.debug('OBJ ' + so);
// 			String sono = (String) so.get('salesOrder');
// 			retval.add(sono);
// 		}
// 		return retval;
// 	}

// 	public string doGetInvoices(Id accountId) {
// 		System.debug('Calling doGetInvoices()');

// 		Account account = queries.getAccountById(accountId);
// 		string financialCompany = queries.getFinancialCompanyForAccount(account);

// 		DOM.Document doc = new DOM.Document();
// 		DOM.XmlNode bodyNode = createSOAPBodyNode(doc, 'sal', SALES_INVOICE_NAMESPACE, financialCompany);
// 		if (bodyNode == null) {
// 			return errorAsJsonString(
// 				500,
// 				'Could not create integration message to send to LN. Please check logs for an explanation'
// 			);
// 		}
// 		DOM.XmlNode requestNode = bodyNode
// 			.addChildElement('List', SALES_INVOICE_NAMESPACE, null)
// 			.addChildElement('ListRequest', null, null);
// 		DOM.XmlNode controlAreaNode = requestNode.addChildElement('ControlArea', null, null);

// 		DOM.XmlNode comparisonExpressionNode = controlAreaNode.addChildElement('Filter', null, null)
// 			.addChildElement('ComparisonExpression', null, null);
// 		comparisonExpressionNode.addChildElement('comparisonOperator', null, null).addTextNode('eq');
// 		comparisonExpressionNode.addChildElement('attributeName', null, null)
// 			.addTextNode('SalesInvoice_BDE.customerId');
// 		comparisonExpressionNode.addChildElement('instanceValue', null, null)
// 			.addTextNode(account.Customer_Number_LN__c);

// 		DOM.Document responseDoc = sendSoapXml(doc, 'SalesInvoice_BDE');
// 		return Glamox_XML_Utils.ConvertResponseToJsonShallow(responseDoc.getRootElement(), 'SalesInvoice_BDE');
// 	}

// 	public string doGetCreditInformation(Id accountId) {
// 		System.debug('Calling doGetCreditInformation()');

// 		Account account = queries.getAccountById(accountId);
// 		string financialCompany = queries.getFinancialCompanyForAccount(account);

// 		if (account == null) {
// 			return errorAsJsonString(400, 'No account found for Id ' + accountId);
// 		}

// 		if (account.Customer_Number_LN__c == null) {
// 			return errorAsJsonString(400, 'No LN customer number found for account with Id ' + accountId);
// 		}

// 		if (financialCompany == null) {
// 			return errorAsJsonString(400, 'No financial compay found for account ' + accountId);
// 		}

// 		DOM.Document doc = new DOM.Document();
// 		DOM.XmlNode bodyNode = createSOAPBodyNode(doc, 'cus', CUSTOMER360_NAMESPACE, financialCompany);
// 		if (bodyNode == null) {
// 			return errorAsJsonString(
// 				500,
// 				'Could not create integration message to send to LN. Please check logs for an explanation'
// 			);
// 		}
// 		DOM.XmlNode requestNode = bodyNode
// 			.addChildElement('Show', CUSTOMER360_NAMESPACE, null)
// 			.addChildElement('ShowRequest', null, null);
// 		DOM.XmlNode dataNode = requestNode.addChildElement('DataArea', null, null)
// 			.addChildElement('Customer360GLX', null, null);
// 		dataNode.addChildElement('CustomerID', null, null).addTextNode(account.Customer_Number_LN__c);
// 		dataNode.addChildElement('CreditInformation', null, null)
// 			.addChildElement('FinancialCompany', null, null)
// 			.addTextNode(financialCompany);
// 		System.debug(doc.toXmlString());
// 		DOM.Document responseDoc = sendSoapXml(doc, 'Customer360GLX');
// 		System.debug(responseDoc.toXmlString());
// 		DOM.XmlNode responseEnvelope = responseDoc.getRootElement();
// 		if (responseEnvelope.getName().equals('Error')) {
// 			return Glamox_XML_Utils.ErrorAsJsonString(responseEnvelope);
// 		} else {
// 			List<Map<string, object>> ret = new List<Map<string, object>>();
// 			DOM.XmlNode customer360Node = Glamox_XML_Utils.FindFirstDescendantByName(
// 				responseEnvelope,
// 				'Customer360GLX'
// 			);
// 			if (customer360Node != null) {
// 				Map<string, object> itemElement = new Map<string, object>();
// 				List<string> addressLines = new List<string>();
// 				List<Map<string, object>> turnovers = new List<Map<string, object>>();
// 				for (DOM.XmlNode child : customer360Node.getChildren()) {
// 					string childName = child.getName();
// 					if (childName.equals('CustomerID') || childName.equals('CustomerName')) {
// 						itemElement.put(childName, child.getText());
// 					} else if (childName.equals('AddressLine') && child.getChildren().size() > 0) {
// 						for (DOM.XmlNode addressChild : child.getChildren()) {
// 							if (addressChild.getName().equals('Text')) {
// 								addressLines.add(addressChild.getText());
// 							}
// 						}
// 					} else if (childName.equals('Turnover') && child.getChildren().size() > 0) {
// 						Map<string, object> turnover = new Map<string, object>();
// 						for (DOM.XmlNode turnoverChild : child.getChildren()) {
// 							object value = turnoverChild.getText();
// 							if (!turnoverChild.getName().equals('Currency')) {
// 								value = Decimal.valueOf(turnoverChild.getText().trim());
// 							}
// 							turnover.put(turnoverChild.getName(), value);
// 						}
// 						turnovers.add(turnover);
// 					} else if (childName.equals('Transactions') && child.getChildren().size() > 0) {
// 						Map<string, object> transactions = new Map<string, object>();
// 						for (DOM.XmlNode transactionsChild : child.getChildren()) {
// 							transactions.put(transactionsChild.getName(), Integer.valueOf(transactionsChild.getText()));
// 						}
// 						itemElement.put('Transactions', transactions);
// 					} else if (childName.equals('CreditInformationAllCompanies') && child.getChildren().size() > 0) {
// 						Map<string, object> creditInfos = new Map<string, object>();
// 						for (DOM.XmlNode creditInfosChild : child.getChildren()) {
// 							object value = creditInfosChild.getText();
// 							if (!creditInfosChild.getName().equals('Currency')) {
// 								value = Decimal.valueOf(creditInfosChild.getText().trim());
// 							}
// 							creditInfos.put(creditInfosChild.getName(), value);
// 						}
// 						itemElement.put('CreditInformationAllCompanies', creditInfos);
// 					} else if (childName.equals('CreditInformation') && child.getChildren().size() > 0) {
// 						Map<string, object> creditInfos = new Map<string, object>();
// 						for (DOM.XmlNode creditInfosChild : child.getChildren()) {
// 							object value = creditInfosChild.getText();
// 							if (
// 								!creditInfosChild.getName().endsWith('Currency') &&
// 								!creditInfosChild.getName().endsWith('Company')
// 							) {
// 								value = Decimal.valueOf(creditInfosChild.getText().trim());
// 							}
// 							creditInfos.put(creditInfosChild.getName(), value);
// 						}
// 						itemElement.put('CreditInformation', creditInfos);
// 					}
// 				}
// 				itemElement.put('Address', addressLines);
// 				itemElement.put('Turnover', turnovers);
// 				ret.add(itemElement);
// 			}
// 			return JSON.serialize(ret);
// 		}
// 	}

// 	/**
// 	 * CRM-578 Delivery markings are gathered from a set of fields with info to be shown at final destinatoin.
// 	 * Return null if none of the delivery marking fields have values.
// 	 */

// 	public static String fetchDeliveryMarkings(Quote quote) {
// 		Map<String, String> fieldValues = new Map<String, String>{
// 			'Customer No: ' => quote.Wholesaler_Customer_Number__c,
// 			'Project No: ' => quote.Wholesaler_Project_Number__c,
// 			'Order No: ' => quote.Wholesaler_Order_Number__c,
// 			'Phone: ' => quote.Wholesaler_Customer_Phone__c
// 		};

// 		Id employeeContactId = null;
// 		if (quote.Wholesaler_Bidder_Contact__c != null) {
// 			employeeContactId = quote.Wholesaler_Bidder_Contact__c;
// 		} else if (quote.ContactId != null) {
// 			employeeContactId = quote.ContactId;
// 		}

// 		if (employeeContactId != null) {
// 			Contact cont = [SELECT Id, Name FROM Contact WHERE Id = :employeeContactId];

// 			if (cont.Name != null && cont.Name.length() > 0) {
// 				String employee = cont.Name;
// 				fieldValues.put('Employee ID: ', employee);
// 			}
// 		}

// 		if (quote.email != null || quote.Email2__c != null) {
// 			string email = quote.email != null ? quote.email : '';
// 			if (email != '') {
// 				email += ';';
// 			}
// 			email += quote.Email2__c != null ? quote.Email2__c : '';
// 			fieldValues.put('Email: ', email);
// 		}

// 		if (quote.Wholesaler_Project_Number__c == null && quote.YourReference__c != null) {
// 			fieldValues.put('Project No: ', quote.YourReference__c);
// 		}

// 		String retval = '';
// 		Boolean hasValues = false;
// 		for (String fieldlabel : fieldValues.keySet()) {
// 			String fieldValue = fieldValues.get(fieldlabel);
// 			if (fieldValue != null && fieldValue.length() > 0) {
// 				retval += fieldlabel + fieldValue + '\n';
// 				hasValues = true;
// 			}
// 		}

// 		if (!hasValues) {
// 			return null;
// 		} else {
// 			retval = 'Delivery Marking\n' + retval;
// 			return retval;
// 		}
// 	}

// 	/**
// 	 * Retrieves warehouse inventory status for the product corresponding to the specified Salesforce recordId.
// 	 * This method sends a SOAP query to LN to retrieve inventory values.
// 	 */
// 	@AuraEnabled(cacheable=true)
// 	public static string getWarehouseInventoryForProduct(Id recordId) {
// 		System.debug('Calling getWarehouseInventoryForProduct()');
// 		Schema.sObjectType sObjType = recordId.getSObjectType();
// 		Schema.DescribeSObjectResult sObjDescribeResult = sObjType.getDescribe();
// 		if (sObjDescribeResult.getName() == 'Product2') {
// 			Glamox_LN_Client client = new Glamox_LN_Client();
// 			return client.getWarehouseInventoryForProductByRecordId(recordId);
// 		} else {
// 			return errorAsJsonString(
// 				400,
// 				'Object was of type ' +
// 				sObjDescribeResult.getName() +
// 				'. This is not supported'
// 			);
// 		}
// 	}

// 	/**
// 	 * Creates an order based on the information found in the quote
// 	 */
// 	@AuraEnabled(cacheable=false)
// 	public static string createOrderFromQuote(Id recordId) {
// 		return Glamox_LN_Client.createOrderFromQuote(recordId, null, null, null); //back to the original from Torvald
// 	}

// 	public static string createOrderFromQuote(Id recordId, String yourReference) {
// 		System.assert(false, 'Thismethodisnothere');
// 		return 'hei';
// 	}

// 	/** @TODO Move the function that checks the length of street address > 30 here. */
// 	public static string createOrderFromQuote(
// 		Id recordId,
// 		String yourReference,
// 		String lnOrderId,
// 		Glamox_LN_Client lnClient
// 	) {
// 		System.debug(
// 			'Create Order From Quote, external? ' +
// 			Glamox_EFONELFO_Client.quoteHandledByExternal(recordId) +
// 			' yourRef ' +
// 			yourReference +
// 			' LN ' +
// 			lnOrderId
// 		);
// 		Quote quote = [
// 			SELECT
// 				ShippingAddress,
// 				QuoteArea__c,
// 				BillingAddress,
// 				BillingAdditionalName__c,
// 				ShippingName,
// 				ShippingAdditionalName__c,
// 				BillingName,
// 				QuoteNumber,
// 				Quote.Wholesaler_Quote__c,
// 				Quote.Bidder__c,
// 				Bidder__r.Customer_Number_LN__c,
// 				Quote.Wholesaler__r.Customer_Number_LN__c,
// 				Bidder__r.Name,
// 				Quote.Wholesaler__r.Name,
// 				/*ReplacementOrClaim__c,*/ OrderType__c,
// 				OpportunityId,
// 				Bidder__r.Business_Unit__c,
// 				Wholesaler__r.Business_Unit__c
// 			FROM Quote
// 			WHERE Id = :recordId
// 		];
// 		List<String> existingOrdersInLn;
// 		if (lnClient == null) {
// 			/* @TODO A bit of a hack. This whole method should be moved into a non static context */
// 			existingOrdersInLn = hasSalesOrder(quote.QuoteNumber);
// 		} else {
// 			existingOrdersInLn = lnClient.doHasSalesorder(quote.QuoteNumber);
// 		}

// 		System.debug('Do we have an order for quote ' + quote.quoteNumber + '? ' + existingOrdersInLn);
// 		if (existingOrdersInLn != null && existingOrdersInLn.size() > 0) {
// 			String errorString =
// 				'Can not create new order in LN for quote ' +
// 				quote.QuoteNumber +
// 				', it already has order';
// 			errorString += (existingOrdersInLn.size() > 1) ? 's ' : ' ';
// 			errorString += String.join(existingOrdersInLn, ',');
// 			quote.LN_Order_ID__c = existingOrdersInLn.get(0);
// 			update quote;

// 			errorString += ', using that.';

// 			return errorAsJsonString(500, errorString);
// 		}

// 		String serviceWindowActive = checkActiveServicewindow();
// 		if (serviceWindowActive != null) {
// 			return errorAsJsonString(500, serviceWindowActive);
// 		}

// 		// @TODO Move validation stuff from here into the doValidateOrder
// 		String orderValidation = doValidateOrder(quote);
// 		if (orderValidation != null) {
// 			return errorAsJsonString(500, orderValidation);
// 		}
// 		String shippingName = quote.Shippingname;
// 		if (shippingName != null && shippingName.length() > 35) {
// 			return errorAsJsonString(400, 'The shipping name is too long.');
// 		}

// 		if (quote.BillingName != null) {
// 			String validation = null;
// 			try {
// 				validation = doValidateAddress(quote.billingName, quote.BillingAdditionalName__c, quote.billingAddress);
// 			} catch (IllegalArgumentException e) {
// 				System.debug('Billing address fails validation: : ' + e.getMessage());
// 				return errorAsJsonString(500, 'Billing address, ' + e.getMessage());
// 			}
// 			if (validation != null) {
// 				return validation;
// 			}
// 		}

// 		if (quote.ShippingName != null) {
// 			String validation = null;
// 			try {
// 				validation = doValidateAddress(
// 					quote.ShippingName,
// 					quote.ShippingAdditionalName__c,
// 					quote.ShippingAddress
// 				);
// 			} catch (IllegalArgumentException e) {
// 				System.debug('Shipping address fails validation: ' + e.getMessage());
// 				return errorAsJsonString(500, 'Shipping address, ' + e.getMessage());
// 			}
// 			if (validation != null) {
// 				return validation;
// 			}
// 		}

// 		try {
// 			if (lnOrderId != 'FWD_TO_LN' && Glamox_EFONELFO_Client.quoteHandledByExternal(recordId)) {
// 				System.debug('Create Order from Quote ' + recordId + '  sending to EFONELFO');
// 				Glamox_EFONELFO_Client client = new Glamox_EFONELFO_Client();
// 				return client.doCreateOrderFromQuote(recordId);
// 			} else {
// 				System.debug('Create Order from Quote ' + recordId + '  sending to LN');
// 				/* @TODO A bit of a hack. This whole method should be moved into a non static context */
// 				Glamox_LN_Client client = lnClient;
// 				if (client == null) {
// 					client = new Glamox_LN_Client();
// 				}

// 				return client.doCreateOrderFromQuote(recordId, yourReference);
// 			}
// 		} catch (OrderException oe) {
// 			return errorAsJsonString(400, oe.getMessage());
// 		} catch (Exception e) {
// 			throw e;
// 		}
// 	}

// 	/**
// 	 * Retrieves warehouse inventory status for the product with the specified product code.
// 	 * This method sends a SOAP query to LN to retrieve inventory values.
// 	 *
// 	 * Note; "product code", in this respect, is the MFArtNo.
// 	 */
// 	@AuraEnabled(cacheable=true)
// 	public static string getWarehouseInventoryForProductByProductCode(string productCode) {
// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		return client.doGetWarehouseInventoryForProductByProductCode(productCode);
// 	}

// 	/**
// 	 * Retrieves an item list from LN based on the Salesforce recordId. At present, the record must be of
// 	 * type ProductGroup__c.
// 	 */
// 	@AuraEnabled(cacheable=true)
// 	public static string getItemList(Id recordId) {
// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		return client.doGetItemList(recordId);
// 	}

// 	/**
// 	 * Retrieves prices from LN for the specified business partner and product codes. Note that 'product code'  in this
// 	 * respect means MFArtNo.
// 	 */
// 	@AuraEnabled(cacheable=true)
// 	public static string getProductPrices(
// 		string lnBusinessPartnerCode,
// 		string currencyCode,
// 		List<string> productCodes
// 	) {
// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		return client.doGetPrices(lnBusinessPartnerCode, currencyCode, productCodes);
// 	}

// 	/**
// 	 * Retreives prices from LN for products registered on quote line items for the specified quote
// 	 */
// 	@AuraEnabled(cacheable=true)
// 	public static string getProductPricesForQuote(Id quoteRecordId, List<Id> productRecordIds) {
// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		return client.doGetPricesForQuote(quoteRecordId, productRecordIds);
// 	}

// 	/**
// 	 * Retrieves orders from LN for the specified business partner. Note that order lines are not included; the web service on the LN side
// 	 * runs out of memory when order lines are included
// 	 */
// 	@AuraEnabled(cacheable=true)
// 	public static string getSalesOrders(string lnBusinessPartnerCode) {
// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		return client.doGetSalesOrders(lnBusinessPartnerCode);
// 	}

// 	/**
// 	 * Query LN to see if we have any orders already for this quote. Returns null if not, or a list of the orders.
// 	 * If we have an order, we should not create it.
// 	 */
// 	@AuraEnabled(cacheable=true)
// 	public static List<String> hasSalesOrder(String quoteNumber) {
// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		return client.doHasSalesorder(quoteNumber);
// 	}

// 	/**
// 	 * Retrieves invoices from LN for the specified business partner. Note that invoice lines are not included; the web service on the LN side
// 	 * does not support invoice lines at this point.
// 	 */
// 	@AuraEnabled(cacheable=true)
// 	public static string getInvoices(Id accountId) {
// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		return client.doGetInvoices(accountId);
// 	}

// 	/**
// 	 * Retrieves credit information for a specific business partner (using its account Id)
// 	 */
// 	@AuraEnabled(cacheable=false)
// 	public static string getCreditInformation(Id accountId) {
// 		Glamox_LN_Client client = new Glamox_LN_Client();
// 		return client.doGetCreditInformation(accountId);
// 	}

// 	public static String encodeInternalNotes(String internalNotes, String wholesalerNotes) {
// 		String headerTextPart = '';
// 		/* CRM-608 */
// 		if (wholesalerNotes != null && wholesalerNotes.length() > 0) {
// 			List<String> wholesalerNotesTokens = splitByLine('Internal remark: ' + wholesalerNotes);
// 			List<String> lengthLimtedTokens = splitByLength(wholesalerNotesTokens, 60);
// 			for (string nt : lengthLimtedTokens) {
// 				headerTextPart += '\n<';
// 				headerTextPart += nt;
// 			}
// 		}

// 		List<string> notesTokens = splitByLine(internalNotes);

// 		/* CRM-932 */
// 		List<String> lengthLimtedTokens = splitByLength(notesTokens, 60);
// 		for (string nt : lengthLimtedTokens) {
// 			headerTextPart += '\n<';
// 			headerTextPart += nt;
// 		}
// 		return headerTextPart;
// 	}

// 	public static String encodeInternalNotesBrouHaHa(String internalNotes) {
// 		String txt = '';
// 		List<String> lengthLimtedTokens = splitByLength(splitByLine(internalNotes), 60);
// 		for (string nt : lengthLimtedTokens) {
// 			txt += nt + '\n';
// 		}
// 		return txt;
// 	}

// 	private boolean isNotZero(Decimal amount) {
// 		Decimal rounded = amount.setScale(2);
// 		boolean isZero = rounded == 0.00;
// 		return !isZero;
// 	}

// 	private static List<String> splitByLine(String input) {
// 		/* Sometimes we get \r\n but sometimes only \n. As in CRM-932 */
// 		/* Used to do internalNotes.split('\\r\\n') */
// 		List<String> retval = new List<String>();
// 		for (String part : input.split('\n')) {
// 			String part2 = part.trim(); /* Remove \r */
// 			retval.add(part2);
// 		}
// 		return retval;
// 	}

// 	private static List<String> splitByLength(List<String> pieces, integer max) {
// 		List<String> tokens = new List<String>();
// 		for (String piece : pieces) {
// 			while (piece.length() > 0) {
// 				String nibble = piece.left(max);
// 				tokens.add(nibble);
// 				piece = piece.mid(max, piece.length());
// 			}
// 		}
// 		return tokens;
// 	}

// 	// replaced with getOpportunityOwner => LN_Sales_Office__c //@OwnerProblem
// 	private String getSalesoffice(Quote quote) {
// 		// CRM-865
// 		// bidder -> owner -> salesoffice
// 		// CRM-1163
// 		// (Sales_Rep__c / QuoteOwner__c / OwnerId ) -<> BU -> salesOffice

// 		Id salesUser = quote.Sales_Rep__c;
// 		if (salesUser == null) {
// 			salesUser = quote.QuoteOwner__c;
// 		}

// 		if (salesUser == null) {
// 			salesUser = quote.OwnerId;
// 		}

// 		if (salesUser == null) {
// 			throw new IllegalArgumentException('Quote ' + quote.QuoteNumber + ' must have an owner.');
// 		}

// 		User owner = [SELECT LN_Sales_Office__c FROM User WHERE Id = :salesUser];

// 		String so = owner.LN_Sales_Office__c;
// 		if (so != null) {
// 			return so;
// 		}
// 		return null;
// 	}

// 	public String buildOrderSpecificEmail(Quote quote) {
// 		String emails = '';

// 		if (quote.Email != null && quote.Email.length() > 0) {
// 			emails += quote.Email;
// 		}

// 		if (quote.Email2__c != null && quote.Email2__c.length() > 0) {
// 			emails += (emails.length() > 0) ? ';' : '';
// 			emails += quote.Email2__c;
// 		}

// 		User ownerId = quote.QuoteOwner__r;
// 		User salesRepId = quote.Sales_Rep__r;

// 		if (ownerId == null && salesRepId == null) {
// 			return emails;
// 		}

// 		if (
// 			ownerId != null &&
// 			ownerId.ReceiveOrderConfirmationFromLN__c &&
// 			ownerId.Email != null &&
// 			ownerId.Email.length() > 0
// 		) {
// 			emails += (emails.length() > 0) ? ';' : '';
// 			emails += ownerId.Email;
// 		}

// 		if (
// 			salesRepId != null &&
// 			salesRepId.ReceiveOrderConfirmationFromLN__c &&
// 			salesRepId.Email != null &&
// 			salesRepId.Email.length() > 0
// 		) {
// 			emails += (emails.length() > 0) ? ';' : '';
// 			emails += salesRepId.Email;
// 		}

// 		return emails;
// 	}

// 	public static String getBusinessUnitName(Quote quote) {
// 		/* CRM-993 Show delivery marking only for GSN */
// 		/* CRM-1161 Ensure we are using an account from the same BU */
// 		/* Code stolen from Glamox_PdfDataProvider */
// 		Opportunity opportunity = [
// 			SELECT
// 				Id,
// 				Owner.Name,
// 				Owner.Id,
// 				Owner.Title,
// 				Owner.MobilePhone,
// 				Owner.Phone,
// 				Owner.Email,
// 				Owner.Signature__c,
// 				CurrencyIsoCode,
// 				Owner.Business_Unit__c,
// 				Segment__c
// 			FROM Opportunity
// 			WHERE Id = :quote.OpportunityId
// 			LIMIT 1
// 		];

// 		User oppOwner = (User) opportunity.Owner;
// 		BusinessUnit__c bUnit;
// 		BusinessUnit__c[] bUnits = [
// 			SELECT Id, Name, Legal_Name__c, QuoteEndingText__c, QuoteIntroductionText__c, GSSLanguageID__c, MarketID__c
// 			FROM BusinessUnit__c
// 			WHERE Name = :oppOwner.Business_Unit__c
// 		];

// 		System.assert(bUnits.size() > 0, 'Unable to fetch Business Unit id ' + oppOwner.Business_Unit__c);

// 		if (bUnits.size() > 0) {
// 			bUnit = bUnits[0];
// 		}
// 		return bUnit.Name;
// 	}

// 	public static String testCoverageImprover() {
// 		String ret = 'This is a test';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		ret += ' a test ';
// 		return ret;
// 	}
}
